require 'spec_helper'

describe ReCaptcha::Client do

  describe '#new' do

    it 'should not accept no parameters' do
      expect { described_class.new }.to raise_error ArgumentError
    end

    context 'with an invalid configuration' do
      let(:configuration) { instance_double('ReCaptcha::Configuration', valid?: false) }

      it 'should raise a ReCaptcha::ConfigurationError error' do
        expect { described_class.new(configuration) }.to raise_error ReCaptcha::ConfigurationError
      end
    end

    context 'with a valid configuration' do
      let(:configuration) { instance_double('ReCaptcha::Configuration', valid?: true) }
      let(:instance) { described_class.new(configuration) }

      it 'should accept (configuration) as parameter' do
        expect(described_class).to receive(:new).with(configuration).and_return(instance)
        expect { described_class.new(configuration) }.to_not raise_error
      end

      it 'should return a proper instance' do
        expect { described_class.new(configuration) }.to_not raise_error
      end
    end


  end

  describe 'instance' do
    before(:all) do
      ReCaptcha.configure do |config|
        config.public_key = 'foo'
        config.private_key = 'bar'
        config.skipped_env = ['my-test']
      end
    end

    let(:configuration) { ReCaptcha.configuration }
    let(:instance) { ReCaptcha.client }

    it { expect(instance).to respond_to(:env) }
    it { expect(instance).to respond_to(:private_key) }
    it { expect(instance).to respond_to(:public_key) }
    it { expect(instance).to respond_to(:api_endpoint) }
    it { expect(instance).to respond_to(:skipped_env) }
    it { expect(instance).to respond_to(:is_recaptcha_valid?) }
    it { expect(instance).to respond_to(:secure_token) }

    describe '#private_key' do
      subject(:private_key) { instance.private_key }

      it 'delegates to configuration' do
        expect(configuration).to receive(:private_key)
        instance.private_key
      end

      it 'returns the correct private key' do
        expect(subject).to eq('bar')
      end
    end

    describe '#public_key' do
      subject(:public_key) { instance.public_key }

      it 'delegates to configuration' do
        expect(configuration).to receive(:public_key)
        instance.public_key
      end

      it 'returns the correct public key' do
        expect(subject).to eq('foo')
      end
    end

    describe '#api_endpoint' do
      subject(:api_endpoint) { instance.api_endpoint }

      it 'delegates to configuration' do
        expect(configuration).to receive(:api_endpoint)
        instance.api_endpoint
      end

      it 'returns the correct api_endpoint' do
        expect(subject).to eq('https://www.google.com/recaptcha/')
      end
    end

    describe '#skipped_env' do
      subject(:skipped_env) { instance.skipped_env }

      it 'delegates to configuration' do
        expect(configuration).to receive(:skipped_env)
        instance.skipped_env
      end

      it 'returns the correct skipped_env' do
        expect(subject).to be_a(Array)
        expect(subject).to eq(['my-test'])
      end
    end

    describe '#deny_on_error' do
      subject(:deny_on_error) { instance.deny_on_error }

      it 'delegates to configuration' do
        expect(configuration).to receive(:deny_on_error)
        instance.deny_on_error
      end

      it 'returns the correct value' do
        expect(subject).to be_a(FalseClass)
        expect(subject).to eq(false)
      end
    end

    describe '#language_code' do
      it 'delegates to configuration' do
        expect(configuration).to receive(:language_code)
        instance.language_code 'zh-CN'
      end
    end

    describe '#is_recaptcha_valid?' do
      context 'with a correct response' do

        before(:all) do
          stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').with(body: {"remoteip"=>"", "response"=>'correct response', "secret"=>"bar"}).to_return(status: 200, body: {success: true}.to_json)
        end

        let(:response) { 'correct response' }

        it 'returns true' do
          expect(instance.is_recaptcha_valid?(response)).to eq(true)
        end
      end

      context 'with an incorrect response' do

        before(:all) do
          stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').with(body: {"remoteip"=>"", "response"=>'incorrect response', "secret"=>"bar"}).to_return(status: 200, body: {success: false}.to_json)
        end

        let(:response) { 'incorrect response' }

        it 'returns false' do
          expect(instance.is_recaptcha_valid?(response)).to eq(false)
        end
      end

      context 'in a skipped environment' do

        it 'always returns true' do
          allow(instance).to receive(:env) { 'my-test' }
          expect(instance.is_recaptcha_valid?('foo')).to eq(true)
        end
      end

      context 'when the request timeouts' do
        before(:all) do
          stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').to_timeout
        end

        it 'returns true' do
          expect(instance.is_recaptcha_valid?('foo')).to eq(true)
        end
      end

      context 'when Google responds with a 40X error' do
        before(:all) do
          stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').to_return(:status => [401, 'Unauthorized'])
        end

        it 'returns true' do
          expect(instance.is_recaptcha_valid?('foo')).to eq(true)
        end
      end

      context 'when Google responds with a 50X error' do
        before(:all) do
          stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').to_return(:status => [500, 'Internal Server Error'])
        end

        it 'returns true' do
          expect(instance.is_recaptcha_valid?('foo')).to eq(true)
        end
      end

      context 'with deny on error activated' do
        context 'when Google responds with a 50X error' do
          before(:all) do
            stub_request(:post, 'https://www.google.com/recaptcha/api/siteverify').to_return(:status => [500, 'Internal Server Error'])
          end

          it 'returns false' do
            allow(instance).to receive(:deny_on_error) { true }
            expect(instance.is_recaptcha_valid?('foo')).to eq(false)
          end
        end
      end
    end

    describe '#secure_token' do
      it 'delegates to SecureTokenBuilder' do
        expect(ReCaptcha::SecureTokenBuilder).to receive(:build).with(instance.private_key)
        instance.secure_token
      end
    end

  end
end
