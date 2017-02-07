require 'open-uri'
require 'nokogiri'

module VoteTracker
  class Senate
    BASE_URL = 'https://www.senate.gov/legislative/LIS/roll_call_lists/'

    def votes
      @votes ||= xml.css('vote').map do |node|
        vote = Vote.new

        vote.number  = node.css('vote_number').text
        vote.issue   = node.css('issue').text.strip.gsub(/\s|\./, '')
        vote.action  = node.css('result').text.upcase
        vote.type    = parsed_type(node).downcase
        vote.summary = node.css('title').text.split(';').last.strip

        vote
      end
    end

    private

    def parsed_type(node)
      match = node.css('question').text.match(/the (\w+)(\z|\s\w+)/)

      if match[2].length > 3
        match[1] + match[2]
      else
        match[1]
      end
    end

    def xml
      return @xml if @xml

      file_path = "vote_menu_#{VoteTracker::CONGRESS}_#{VoteTracker::SESSION}.xml"

      @xml = Nokogiri::HTML(open(BASE_URL + file_path))
    end
  end
end
