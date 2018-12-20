require File.expand_path('../lib/re_captcha/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock'

  gem.name = 're_captcha'
  gem.summary = 'reCaptcha helpers'
  gem.description = 'Google reCaptcha helpers and verifier'
  gem.version = ReCaptcha::VERSION.dup
  gem.authors = ['David Jeusette']
  gem.email = ['david@textmaster.com']
  gem.homepage = 'https://github.com/textmaster/re_captcha'
  gem.require_paths = ['lib']
  gem.license = 'MIT'

  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")
end
