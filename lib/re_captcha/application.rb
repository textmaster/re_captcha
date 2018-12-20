require 're_captcha/api'

module ReCaptcha
  module Application
    include API

    def recaptcha_valid?(response, remote_ip: nil)
      return true if skip_verification?
      params = generate_verification_params(response, remote_ip)
      verification = verify_recaptcha(params)
      verification['success']
    end

    private

    def verify_recaptcha(params)
      post 'api/siteverify', params, options: { verify_ssl: false }
    end

    def generate_verification_params(response, remote_ip)
      { response: response, secret: private_key, remoteip: remote_ip }
    end

    def skip_verification?
      skipped_env.include? env
    end
  end
end
