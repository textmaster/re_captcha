module ReCaptcha
  class ConfigurationError < StandardError
    def initialize(name, configuration)
      super(compose_message(name, configuration: configuration))
    end

    private

    def compose_message(name, configuration: nil)
      title = name
      problems = ": #{configuration.errors.join(', ')}" unless configuration.nil?
      resolution = <<-END
        \nMake sure to have configured the gem using the configure block
        ReCaptcha.configure do |config|
        \tconfig.private_key = "private_key"
        \tconfig.public_key = "public_key"
        end
      END

      title + problems + resolution
    end
  end
end
