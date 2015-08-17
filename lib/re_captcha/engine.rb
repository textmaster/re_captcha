require 're_captcha/rails/helpers'

module ReCaptcha
  class Engine < ::Rails::Engine
    initializer 're_captcha.action_controller.helpers' do
      ActiveSupport.on_load(:action_controller) do
        include ReCaptcha::Rails::Helpers
      end
    end

    initializer 're_captcha.action_view.helpers' do
      ApplicationHelper.send(:include, ReCaptcha::Helpers)
    end
  end
end
