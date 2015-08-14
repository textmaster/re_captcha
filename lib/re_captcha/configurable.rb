require 're_captcha/configuration'

module ReCaptcha
  module Configurable
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end
  end
end
