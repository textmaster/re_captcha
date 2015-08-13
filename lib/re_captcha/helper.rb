module ReCaptcha
  module Helper

    def recaptcha_tags
      html = ""
      html << %{<div class="g-recaptcha" data-sitekey="#{ReCaptcha.client.public_key}" data-stoken="#{ReCaptcha.client.secure_token}"></div>\n}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def recaptcha_script(language: nil)
      html = ""
      html << %{<script src="#{ReCaptcha.client.api_endpoint}api.js#{language_query(language)}" async defer></script>\n}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    private

    def language_query(language)
      "?hl=#{ReCaptcha.client.language_code(language)}" if language
    end
  end
end
