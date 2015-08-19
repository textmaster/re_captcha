# ReCaptcha

[![Build Status](https://travis-ci.org/textmaster/re_captcha.svg?branch=master)](https://travis-ci.org/textmaster/re_captcha)

Gem to easily use [Google reCaptcha](https://www.google.com/recaptcha/)

The gem implements v2 of the reCaptcha API.

Run tests with ``` rake ```

Run console with preloaded library with ``` rake console ```

## Getting started

You may need to configure the gem with non default values:

```ruby
ReCaptcha.configure do |config|
  config.private_key = "secret key"
  config.public_key  = "site key"
end

```

The options are:
- `private_key` (default: `ENV['RECAPTCHA_PRIVATE_KEY']`)
- `public_key` (default: `ENV['RECAPTCHA_PUBLIC_KEY']`)
- `api_endpoint` (default: https://www.google.com/recaptcha/)
- `skipped_env` (default: `['test', 'cucumber']`)
- `language_table`: the table to map locale with language code
- `deny_on_error`: if the Google reCaptcha API can't be accessed, deny the verification (default: `false`)

The default language table is the following:

```ruby
{
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
```

## Display

The view helpers are automatically included in a Rails app.  If you're not using Rails, include the helpers with ```include ReCaptcha::Helpers```.

The available helper methods are the following:

- ```recaptcha_script(language: nil)``` includes the script tag in the view.  Language is one of the locale defined in the language table.

- ```recaptcha_tags(options = {})``` adds the reCaptcha box in the view.

The options are the following (the default value is given):
- theme: 'light'
- type: 'image'
- size: 'normal'
- tab_index: 0
- callback: nil
- expired_callback: nil

Check the reCaptcha doc for the available values (https://developers.google.com/recaptcha/docs/display).

Here is an example that shows how to use the helpers in a view (haml)
```ruby
- content_for :scripts do
  = recaptcha_script(language: I18n.locale)

...

= form_for @object, url: my_path, method: :post, html: { class: 'form' } do |form|
  = form.text_area :message, placeholder: 'Message'
  = recaptcha_tags
  = form.submit 'Submit', class: 'submit btn blue-bg anim'
```

## Verification

Assuming that your application uses Rails, verify the reCaptcha response in your controller using the method ```recaptcha_valid?(model: nil, message: nil)```.

model and message are optional and enables you to set an error message on the :base attribute of the provided model.

Example
```ruby
def create
  @user = User.new(user_params)

  return error(t('invalid_recaptcha')) unless recaptcha_valid?

  if @user.save
    redirect_to root_path
  else
    error(t('user_error'))
  end
end

private

def error(message)
  flash[:error] = message
  render :new
end
```

If you're not using Rails, this method can be called like this: ```ReCaptcha.client.recaptcha_valid?(response, remote_ip: nil)```.  No model nor message can be provided.

## Integration with devise

- Get your keys from [Google reCaptcha](https://www.google.com/recaptcha/).  The site key is the public key and the secret is the secret one.
- Install this gem
```ruby
# Gemfile
gem 're_captcha'
```
- Add the tags in your views.  ```recaptcha_script``` may be added in your layout view.
```
<%= recaptcha_script(...) %>

...

<%= recaptcha_tags(...) %>
```
- Create your own controllers that inherit from the Devise controllers.
  - For unlocks
  ```ruby
  class UnlocksController < Devise::UnlocksController
    def create
      if recaptcha_valid?
        super
      else
        self.resource = resource_class.find_or_initialize_with_errors(resource_class.unlock_keys, resource_params, :not_found)
        flash[:error] = t("invalid_recaptcha")
        render :new
      end
    end
  end

  ```
  - For passwords
  ```ruby
  class PasswordsController < Devise::PasswordsController
    def create
      if recaptcha_valid?
        super
      else
        self.resource = resource_class.find_or_initialize_with_errors(resource_class.unlock_keys, resource_params, :not_found)
        flash[:error] = t("invalid_recaptcha")
        render :new
      end
    end
  end
  ```
  - etc

Other examples are given on the [Devise Wiki](https://github.com/plataformatec/devise/wiki/How-To:-Use-Recaptcha-with-Devise) for [Recaptcha Gem](https://github.com/ambethia/recaptcha).  The use case is similar and examples can be easily adapted.
