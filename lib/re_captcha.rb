module ReCaptcha
  extend Configurable

  def self.client
    @client ||= ReCaptcha::Client.new(configuration)
  end
end

if defined?(Rails)
  ActionView::Base.send(:include, ReCaptcha::Helper)
end
