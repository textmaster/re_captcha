module ReCaptcha
  class ConfigurationError < StandardError
    def initialize(name)
      super(compose_message(name))
    end

    private

    def compose_message(name)
      problem = name
      resolution = ''
      resolution << %(\nMake sure to have configured the gem using the configure block)
      resolution << %(\nReCaptcha.configure do |config|)
      resolution << %(\n\tconfig.private_key = "private_key")
      resolution << %(\n\tconfig.public_key = "public_key")
      resolution << %(\nend)

      "#{problem} #{resolution}"
    end
  end
end
