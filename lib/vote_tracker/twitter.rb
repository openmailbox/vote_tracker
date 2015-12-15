require 'twitter'

module VoteTracker
  class Twitter
    DATA_PATH = File.expand_path('../../../data/last_tweet.txt', __FILE__)

    include Singleton

    def client
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key        = configuration[:consumer_key]
        config.consumer_secret     = configuration[:consumer_secret]
        config.access_token        = configuration[:access_token]
        config.access_token_secret = configuration[:access_token_secret]
      end
    end

    def tweet!(vote)
      return false if already_tweeted?(vote)

      if VoteTracker.env == 'production'
        client.update(vote.to_tweet)
      else
        VoteTracker.logger.info("Skipping Twitter update in #{VoteTracker.env} environment.")
      end

      record_tweet!(vote)

      true
    end

    private

    # TODO: Horrible state tracking.  Make something better.
    def already_tweeted?(vote)
      last_congress, last_number = File.read(DATA_PATH).chomp.split('-')

      VoteTracker::CONGRESS < last_congress.to_i ||
        last_number.to_i >= vote.number.to_i
    end

    def configuration
      VoteTracker.configuration.twitter
    end

    def record_tweet!(vote)
      File.open(DATA_PATH, 'w') do |file|
        file << "#{VoteTracker::CONGRESS}-#{vote.number}\n"
      end
    end
  end
end
