module VoteTracker
  class Vote
    ABBREVIATIONS = {
      'and'     => '&',
      'with'    => 'w/',
      'without' => 'w/o'
    }

    BASE_URL = 'http://www.senate.gov/legislative/LIS/roll_call_lists/roll_call_vote_cfm.cfm'

    attr_accessor :number, :issue, :action, :type, :summary

    def article
      if %w(a e i o u).include?(type.to_s[0])
        'an'
      else
        'a'
      end
    end

    def to_s
      "#Senate #{action} #{article} #{type} for #{issue}: #{summary}"
    end

    def to_tweet
      tweet = ''
      words = to_s.split

      words.each_with_index do |next_word, i|
        next_word = ABBREVIATIONS.fetch(next_word, next_word)

        if tweet.length + (next_word.length + 1) > 113
          tweet = tweet.sub(/[,.]\z/, '')
          tweet << '...'
          break
        else
          tweet << ' ' unless i == 0
          tweet << next_word
        end
      end

      tweet << " #{to_url}"
    end

    def to_url
      url = BASE_URL + "?congress=#{VoteTracker::CONGRESS}"
      url << "&session=#{VoteTracker::SESSION}"
      url << "&vote=#{number}"

      url
    end
  end
end
