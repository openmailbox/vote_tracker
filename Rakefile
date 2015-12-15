$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'vote_tracker'

task :console do
  require 'irb'
  IRB.start
end

task :update do
  count   = 0
  senate  = VoteTracker::Senate.new
  twitter = VoteTracker::Twitter.instance

  senate.votes.reverse.each do |vote|
    count += 1 if twitter.tweet!(vote)
  end

  VoteTracker.logger.info("Tweeted #{count} times.")
end

task default: :console
