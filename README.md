# ReCaptcha

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

## Verification

Assuming that your application uses Rails, verify the reCaptcha response in your controller using the method ```recaptcha_valid?(model: nil, message: nil)```.

model and message are optional and enables you to set an error message on the :base attribute of the provided model.


If you're not using Rails, this method can be called like this: ```ReCaptcha.client.recaptcha_valid?(response, remote_ip: nil)```.  No model nor message can be provided.
