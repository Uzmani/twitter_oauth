get '/' do
  erb :index
end

get '/sign_in' do
  # @user = User.find_by_email(params[:email])
  #   if @user.password == params[:password]
  #     session[:user_id] = @user.id
  #   end
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url # 2 r_t, #3
end

get '/sign_out' do
  session.clear
  redirect '/'
end 

get '/auth' do # 5
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])  ## 6  and # 7
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  
  # at this point in the code is where you'll need to create your user account and store the access token
  @user = User.create(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  session[:user_id] = @user.id
  
  erb :index
end

post '/tweet' do 

########12
  @user = Twitter::Client.new(
  :oauth_token => current_user.oauth_token,
  :oauth_token_secret => current_user.oauth_secret
)
  @user.update(params[:tweet_input])


  erb :index

end
