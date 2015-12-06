require 'twitter'

module VoteTracker
  class Twitter
    DATA_PATH = File.expand_path('../../../data/last_tweet.txt', __FILE__)

    include Singleton

    def client
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key        = '***REMOVED***'
        config.consumer_secret     = '***REMOVED***'
        config.access_token        = '***REMOVED***'
        config.access_token_secret = '***REMOVED***'
      end
    end

    def tweet(vote)
      return if already_tweeted?(vote)

      client.update(vote.to_tweet)
      record_tweet!(vote)
    end

    private

    def already_tweeted?(vote)
      last_congress, last_number = File.read(DATA_PATH).chomp.split('-')

      VoteTracker::CONGRESS < last_congress.to_i ||
        last_number.to_i >= vote.number.to_i
    end

    def record_tweet!(vote)
      File.open(DATA_PATH, 'w') do |file|
        file << "#{VoteTracker::CONGRESS}-#{vote.number}\n"
      end
    end
  end
end
