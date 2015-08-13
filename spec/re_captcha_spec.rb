require 'spec_helper'

describe ReCaptcha do
  it { expect(described_class).to respond_to(:client) }
  it { expect(described_class).to respond_to(:configuration) }
  it { expect(described_class).to respond_to(:configure) }


  describe '.configure' do
    let(:configuration) { instance_double('ReCaptcha::Configuration') }

    it 'yields configuration' do
      expect(described_class).to receive(:configure).and_yield(configuration)
      expect { |b| described_class.configure(&b) }.to yield_with_args(configuration)
    end

  end

  describe '.configuration' do
    let(:configuration) { instance_double('ReCaptcha::Configuration') }

    it 'returns the configuration' do
      expect(described_class).to receive(:configuration).and_return(configuration)
      described_class.configuration
    end
  end

  describe '.client' do
    let(:client) { instance_double('ReCaptcha::Client') }

    it 'returns the client instance' do
      expect(described_class).to receive(:client).and_return(client)
      described_class.client
    end
  end
end
