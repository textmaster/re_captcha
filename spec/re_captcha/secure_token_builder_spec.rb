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

      it 'builds a token with a correct value' do
        time = Time.parse("Feb 24 1981")
        allow(Time).to receive(:now).and_return(time)
        allow(SecureRandom).to receive(:uuid).and_return('8a180d31-c031-4258-a36f-bc4207f67bef')
        expect(instance.build).to eq("95ZHArcXmvPlPBc6r95vSj_83vWuXuetY9KfVy4O6AszqvTE_ok6u85L74jMQYmYKtIEqjOJzUgiK9kSjEROQYHleYCsftaXldeLgxeQCFI")
      end
    end
  end
end
