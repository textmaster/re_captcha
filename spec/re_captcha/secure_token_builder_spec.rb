require 'spec_helper'

describe ReCaptcha::SecureTokenBuilder do
  let(:key) { 'my secret key' }
  let(:instance) { described_class.new(key)}

  describe 'instance' do
    it { expect(instance).to respond_to(:build) }

    describe '#build' do
      it 'builds a secure token' do
        expect(instance.build).to be_a(String)
        expect(instance.build).not_to be_empty
      end
    end
  end
end
