require 're_captcha/configurable'
require 're_captcha/client'
require 're_captcha/helper'

module ReCaptcha
  extend Configurable

  def self.client
    @client ||= ReCaptcha::Client.new(configuration)
  end
end
