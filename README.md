ReCaptcha
===

Gem to easily use reCaptcha

Run tests with ``` rake ```
Run console with preloaded library ``` rake console ```

Rails
=

To access the helpers in the views, make sure to include them in a Helper class
such as ApplicationHelper

```
module ApplicationHelper
  include ReCaptcha::Helper
end
```

