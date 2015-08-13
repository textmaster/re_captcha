require 'spec_helper'

describe ReCaptcha::Configuration do
  let(:instance) { described_class.new }

  describe 'instance' do
    it { expect(instance).to respond_to(:api_endpoint) }
    it { expect(instance).to respond_to(:public_key) }
    it { expect(instance).to respond_to(:private_key) }
    it { expect(instance).to respond_to(:skipped_env) }
  end
end
