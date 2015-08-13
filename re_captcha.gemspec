require File.expand_path('../lib/re_captcha/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.name = 're_captcha'
  gem.summary = 'reCaptcha helpers'
  gem.description = 'Google reCaptcha helpers and verifier'
  gem.version = ReCaptcha::VERSION.dup
  gem.authors = ['David Jeusette']
  gem.email = ['jeusette.david@gmail.com']
  gem.homepage = 'https://github.com/djeusette/re_captcha'
  gem.require_paths = ['lib']
  gem.license = 'MIT'

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")
end
