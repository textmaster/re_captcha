require 'rspec/core/rake_task'
require 'gemfury'
require 'gemfury/command'

module Bundler
  class GemHelper
    def rubygem_push(path)
      ::Gemfury::Command::App.start(['push', path])
    end
  end
end

desc 'Open an irb session with ReCaptcha preloaded'
task :console do
  exec 'irb -I lib -r re_captcha'
end

desc 'Run the test suite'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w(--color --format doc)
end

task default: :spec
task test: :spec
