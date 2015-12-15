require 'logger'
require 'yaml'

module VoteTracker
  class Configuration
    include Singleton

    SECRETS_PATH = File.expand_path('../../../config/secrets.yml', __FILE__)

    attr_accessor :logger, :twitter

    def initialize
      @logger  = Logger.new(STDOUT)
      @twitter = secrets['twitter'].inject({}) do |memo, (key, value)|
        memo[key.to_sym] = value
        memo
      end
    end

    private

    def secrets
      YAML.load_file(SECRETS_PATH)
    rescue
      logger.error('No config/secrets.yml file detected. Did you try copying the example file?')
      raise
    end
  end
end
