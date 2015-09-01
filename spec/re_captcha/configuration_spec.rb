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
          expect(instance.language_code('zh-CN')).to eq('zh-CN')
        end
      end

      context 'when the language table does not contain the locale' do
        it 'should return "en"' do
          expect(instance.language_code('foo')).to eq('en')
        end
      end
    end

    describe '#valid?' do
      let(:errors) { double('Array', :<< => nil) }

      it 'resets errors' do
        expect(instance).to receive(:reset_errors)
        instance.valid?
      end

      it 'sets errors' do
        expect(instance).to receive(:set_errors)
        instance.valid?
      end

      it 'checks the number of errors' do
        allow(instance).to receive(:errors).and_return(errors)
        expect(errors).to receive(:empty?)
        instance.valid?
      end

      context 'when private and public keys are given' do
        before(:each) do
          allow(instance).to receive(:private_key) { 'foo' }
          allow(instance).to receive(:public_key) { 'bar' }
        end

        it 'returns true' do
          expect(instance.valid?).to eq(true)
        end

        it 'sets no errors' do
          instance.valid?
          expect(instance.errors.size).to be(0)
        end
      end

      context 'when the private key is missing' do
        before(:each) do
          allow(instance).to receive(:public_key) { 'bar' }
          allow(instance).to receive(:private_key) { nil }
        end

        it 'returns false' do
          expect(instance.valid?).to eq(false)
        end

        it 'sets one error' do
          instance.valid?
          expect(instance.errors.size).to be(1)
        end
      end

      context 'when the public key is missing' do
        before(:each) do
          allow(instance).to receive(:public_key) { nil }
          allow(instance).to receive(:private_key) { 'foo' }
        end

        it 'returns false' do
          expect(instance.valid?).to eq(false)
        end

        it 'sets one error' do
          instance.valid?
          expect(instance.errors.size).to be(1)
        end
      end

      context 'when both the public and the private keys are missing' do
        before(:each) do
          allow(instance).to receive(:public_key) { nil }
          allow(instance).to receive(:private_key) { nil }
        end

        it 'should return false' do
          expect(instance.valid?).to eq(false)
        end

        it 'sets two errors' do
          instance.valid?
          expect(instance.errors.size).to be(2)
        end
      end
    end
  end
end
