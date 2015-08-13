module ReCaptcha
  class Configuration

    API_END_POINT = 'https://www.google.com/recaptcha/'
    SKIPPED_ENVIRONMENTS = ["test", "cucumber"]

    attr_accessor :api_endpoint, :public_key, :private_key, :skipped_env

    def initialize
      @api_endpoint = API_END_POINT
      @skipped_env  = SKIPPED_ENVIRONMENTS
      @public_key   = ENV["RECAPTCHA_PUBLIC_KEY"]
      @private_key  = ENV["RECAPTCHA_PRIVATE_KEY"]
    end

  end
end
