require 're_captcha/rails/helpers'

module ReCaptcha
  class Engine < ::Rails::Engine
    initializer 're_captcha.action_controller.helpers' do
      ActiveSupport.on_load(:action_controller) do
        include ReCaptcha::Rails::Helpers
      end
    end

    initializer 're_captcha.action_view.helpers' do
      config.to_prepare do
        ApplicationController.helper(ReCaptcha::Helpers)
      end
    end
  end
end
