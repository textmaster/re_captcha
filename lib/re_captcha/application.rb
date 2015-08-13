module ReCaptcha
  module Application
    include API

    def is_recaptcha_valid?(params)
      return true if should_skip_verification?
      verification = verify_recaptcha(params)
      verification["success"]
    end

    def verify_recaptcha(params)
      post "api/siteverify", params, {verify_ssl: false}
    end

    def secure_token
      SecureTokenBuilder.build(private_key)
    end

    private

    def should_skip_verification?
      skipped_env.include? env
    end

  end
end
