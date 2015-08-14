# ReCaptcha

Gem to easily use reCaptcha

Run tests with ``` rake ```
Run console with preloaded library ``` rake console ```

## Getting started

You first need to configure the gem.

```
ReCaptcha.configure do |config|
  config.private_key = "secret key"
  config.public_key  = "site key"
end

```

Other options are:
- api_endpoint (default: https://www.google.com/recaptcha/)
- skipped_env (default: ['test', 'cucumber'])
- language_table: the table to map locale with language code
- deny_on_error: if the Google reCaptcha API can't be accessed, deny the verification (default: false)

The default language table is the following:

```
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

To access the helpers in the views, make sure to include them in a Helper class
such as ApplicationHelper (Rails)

```
module ApplicationHelper
  include ReCaptcha::Helper
end
```

Then include the script tag using this helper method in your view:
```
recaptcha_script(language: nil)
```
language is one of the locale defined in the language table.

You can now add the reCaptcha box in your forms:
```
recaptcha_tags(options = {})
```

The options are the following:
- theme: 'light'
- type: 'image'
- size: 'normal'
- tab_index: 0
- callback: nil
- expired_callback: nil

Check the reCaptcha doc for the available values (https://developers.google.com/recaptcha/docs/display).

## Verification

Assuming that your application uses Rails, verify the reCaptcha response using the method below:
```
recaptcha_valid?(response, remote_ip: nil, model: nil, message: nil)
```

The response should be retrieved with ```params.fetch(:"g-recaptcha-response", "")```.  Optional args model and message allow to add an error with the given message on the :base attr of the provided model.
