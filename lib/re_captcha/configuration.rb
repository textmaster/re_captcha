module ReCaptcha
  class Configuration
    API_END_POINT = 'https://www.google.com/recaptcha/'
    SKIPPED_ENVIRONMENTS = %w(test cucumber)
    LANGUAGE_TABLE = {
      'en-US' => 'en',
      'fr-FR' => 'fr',
      'es-ES' => 'es',
      'pt-PT' => 'pt-PT',
      'it-IT' => 'it',
      'en-GB' => 'en-GB',
      'de-DE' => 'de',
      'pt-BR' => 'pt-BR',
      'en-EU' => 'en-GB',
      'es-LA' => 'es-419',
      'zh-CN' => 'zh-CN',
    }

    attr_accessor :api_endpoint, :public_key,
      :private_key, :skipped_env, :language_table, :deny_on_error

    def initialize
      @api_endpoint   = API_END_POINT
      @skipped_env    = SKIPPED_ENVIRONMENTS
      @public_key     = ENV['RECAPTCHA_PUBLIC_KEY']
      @private_key    = ENV['RECAPTCHA_PRIVATE_KEY']
      @language_table = LANGUAGE_TABLE
      @deny_on_error  = false
    end

    def language_code(locale)
      @language_table[locale] || 'en'
    end

    def valid?
      !private_key.nil? && !public_key.nil?
    end
  end
end
