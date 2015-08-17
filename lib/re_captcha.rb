require 're_captcha/configurable'
require 're_captcha/client'
require 're_captcha/helpers'

module ReCaptcha
  extend Configurable

  MUTEX = Mutex.new

  def self.client
    MUTEX.synchronize do
      @client ||= ReCaptcha::Client.new(configuration)
    end
  end
end

if defined?(Rails)
  require 're_captcha/engine'
end
