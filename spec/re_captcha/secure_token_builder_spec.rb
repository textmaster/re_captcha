require 'spec_helper'

describe ReCaptcha::SecureTokenBuilder do
  it { expect(described_class).to respond_to(:build) }

  describe '.build' do
    let(:key) { 'my secret key' }

    it 'builds a secure token' do
      expect(described_class.build(key)).to be_a(String)
      expect(described_class.build(key)).not_to be_empty
    end
  end
end
