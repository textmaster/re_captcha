module ReCaptcha
  module Helper
    def recaptcha_tags
      html = ""
      html << %{<div class="g-recaptcha" data-sitekey="#{ReCaptcha.client.public_key}" data-stoken="#{ReCaptcha.client.secure_token}"></div>\n}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def recaptcha_script
      html = ""
      html << %{<script src="#{ReCaptcha.client.api_endpoint}api.js" async defer></script>\n}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end
  end
end
