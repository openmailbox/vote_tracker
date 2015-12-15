require 'logger'
require 'yaml'

module VoteTracker
  class Configuration
    include Singleton

    SECRETS_PATH     = File.expand_path('../../../config/secrets.yml', __FILE__)
    DEFAULT_LOG_PATH = File.expand_path('../../../log/vote_tracker.log', __FILE__)

    attr_accessor :logger, :twitter

    def initialize
      @logger  = Logger.new(DEFAULT_LOG_PATH)
      @twitter = secrets['twitter'].inject({}) do |memo, (key, value)|
        memo[key.to_sym] = value
        memo
      end
    end

    private

    def secrets
      YAML.load_file(SECRETS_PATH)
    rescue => e
      logger.error('No config/secrets.yml file detected.  Unable to continue.')
      logger.error("#{e.message}\n#{e.backtrace.join("\n")}")
    end
  end
end
