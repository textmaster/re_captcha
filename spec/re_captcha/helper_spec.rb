require 'spec_helper'

describe ReCaptcha::Helper do
  let(:dummy_class) { Class.new { include ReCaptcha::Helper } }

  subject { dummy_class.new }

  it { expect(subject).to respond_to(:recaptcha_tags) }
  it { expect(subject).to respond_to(:recaptcha_script) }
end
