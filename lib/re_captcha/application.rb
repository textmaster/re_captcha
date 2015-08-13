require 're_captcha/api'
require 're_captcha/secure_token_builder'

module ReCaptcha
  module Application
    include API

    def is_recaptcha_valid?(response, remote_ip: nil, model: nil, message: nil)
      return true if should_skip_verification?
      params = generate_verification_params(response, remote_ip)
      verification = verify_recaptcha(params)
      valid = verification["success"]
      add_error_on_model(model, message) unless valid
      valid
    end

    def secure_token
      SecureTokenBuilder.build(private_key)
    end

    private

    def verify_recaptcha(params)
      post "api/siteverify", params, options: {verify_ssl: false}
    end

    def generate_verification_params(response, remote_ip)
      {response: response, secret: private_key, remoteip: remote_ip}
    end

    def should_skip_verification?
      skipped_env.include? env
    end

    def add_error_on_model(model, message)
      model.errors.add :base, message if model && message
    end

  end
end
