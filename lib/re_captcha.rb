require 're_captcha/configurable'
require 're_captcha/client'
require 're_captcha/helper'

module ReCaptcha
  extend Configurable

  MUTEX = Mutex.new

  def self.client
    MUTEX.synchronize do
      @client ||= ReCaptcha::Client.new(configuration)
    end
  end
end
