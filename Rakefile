$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'vote_tracker'

task :console do
  require 'irb'
  IRB.start
end

task :update do
  senate = VoteTracker::Senate.new

  senate.votes.each do |vote|
    VoteTracker::Twitter.instance.tweet(vote)
  end
end

task default: :console
