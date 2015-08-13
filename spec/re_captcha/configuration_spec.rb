require 'spec_helper'

describe ReCaptcha::Configuration do
  let(:instance) { described_class.new }

  describe 'instance' do
    it { expect(instance).to respond_to(:api_endpoint) }
    it { expect(instance).to respond_to(:public_key) }
    it { expect(instance).to respond_to(:private_key) }
    it { expect(instance).to respond_to(:skipped_env) }
    it { expect(instance).to respond_to(:language_code) }
    it { expect(instance).to respond_to(:deny_on_error) }

    describe '#language_code' do
      context 'when the language table contains the locale' do
        it 'should return the correct language code' do
          expect(instance.language_code("zh-CN")).to eq("zh-CN")
        end
      end

      context 'when the language table does not contain the locale' do
        it 'should return "en"' do
          expect(instance.language_code("foo")).to eq("en")
        end
      end
    end

    describe '#valid?' do
      context 'when private and public keys are given' do
        it 'should return true' do
          allow(instance).to receive(:private_key) { 'foo' }
          allow(instance).to receive(:public_key) { 'bar' }
          expect(instance.valid?).to eq(true)
        end
      end

      context 'when the private or public key is missing' do
        it 'should return false' do
          allow(instance).to receive(:public_key) { 'bar' }
          allow(instance).to receive(:private_key) { nil }
          expect(instance.valid?).to eq(false)
        end
      end
    end
  end
end
