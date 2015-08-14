require File.expand_path('../lib/re_captcha/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'gemfury', '~> 0.6'
  gem.add_development_dependency 'webmock', '~> 1.21'

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
