require 'vote_tracker/configuration'
require 'vote_tracker/senate'
require 'vote_tracker/twitter'
require 'vote_tracker/version'
require 'vote_tracker/vote'

module VoteTracker
  CONGRESS = 114
  SESSION  = 1

  class << self
    attr_reader :env
  end
  @env = ENV['VOTE_TRACKER_ENV'] || 'development'

  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield configuration
  end

  def self.logger
    configuration.logger
  end
end
