get '/' do
  erb :index
end

get '/sign_in' do

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
  @jid = current_user.tweet(params[:tweet_input])
  p @jid
  p job_is_complete(@jid)
  if job_is_complete(@jid)
    erb :_tweetjob_status, :layout => false
  else
    erb :_no_job, :layout => false
  end
end

get '/status/:job_id' do 
  

  
end
