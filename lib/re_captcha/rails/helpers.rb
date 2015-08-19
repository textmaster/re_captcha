module ReCaptcha
  module Rails
    module Helpers
      extend ActiveSupport::Concern

      def recaptcha_valid?(model: nil, message: nil)
        recaptcha_response = params.fetch(:"g-recaptcha-response", "")
        remote_ip = request.remote_ip
        valid = ReCaptcha.client.recaptcha_valid?(recaptcha_response, remote_ip: remote_ip)
        add_error_on_model(model, message) unless valid
        valid
      end

      private

      def add_error_on_model(model, message)
        model.errors.add(:base, message) if model && message
      end
    end
  end
end
