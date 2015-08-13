require 'forwardable'
require 're_captcha/application'
require 're_captcha/exceptions'

module ReCaptcha
  class Client
    extend Forwardable
    include Application

    attr_reader :env

    def initialize(configuration)
      @configuration = configuration
      @env           = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
      raise ConfigurationError.new "Invalid configuration" unless configuration.valid?
    end

    def_delegators :@configuration, :api_endpoint,
      :public_key, :private_key, :skipped_env, :language_code,
      :deny_on_error

  end
end
