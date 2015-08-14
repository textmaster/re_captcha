module ReCaptcha
  module Helper
    def recaptcha_tags(options = {})
      html = ''
      html << %(<div class="g-recaptcha" data-sitekey="#{ReCaptcha.client.public_key}" )
      html << %(data-stoken="#{ReCaptcha.client.secure_token}" #{tag_attributes(options)}></div>\n)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def recaptcha_script(language: nil)
      html = ''
      html << %(<script src="#{ReCaptcha.client.api_endpoint}api.js#{language_query(language)}" async defer></script>\n)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    private

    def tag_attributes(theme: 'light', type: 'image', size: 'normal',
      tab_index: 0, callback: nil, expired_callback: nil)
      attributes = ''
      attributes << %(data-theme="#{theme}" data-type="#{type}" data-size="#{size}" data-tabindex="#{tab_index}" )
      attributes << %(data-callback="#{callback}" ) if callback
      attributes << %(data-expired-callback="#{expired_callback}") if expired_callback
      attributes.respond_to?(:html_safe) ? attributes.html_safe : attributes
    end

    def language_query(language)
      "?hl=#{ReCaptcha.client.language_code(language)}" if language
    end
  end
end
