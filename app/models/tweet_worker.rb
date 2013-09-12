 class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(id: tweet_id)
    user  = tweet.user
    puts "STARTING JOB #{jid}................"


    puts "About to sleep....................."

    sleep 10

    
    tweeter = Twitter::Client.new(
      :oauth_token => user.oauth_token,
      :oauth_token_secret => user.oauth_secret
    )
    tweeter.update(tweet.status)
    puts "ENDING JOB #{jid}.................."
  end

  # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
end

