require 'rspec/core/rake_task'

desc "Open an irb session with CheckoutSystem preloaded"
task :console do
  exec "irb -I lib -r checkout_system"
end

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w(--color --format doc)
end

task :default => :spec
