require 'forwardable'
require 're_captcha/application'

module ReCaptcha
  class Client
    extend Forwardable
    include Application

    attr_reader :env

    def initialize(configuration)
      @configuration = configuration
      @env           = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || "development"
    end

    def_delegators :@configuration, :api_endpoint, :public_key, :private_key, :skipped_env

  end
end
