require 'spec_helper'

describe ReCaptcha::Helper do
  let(:dummy_class) { Class.new { include ReCaptcha::Helper } }

  before(:all) do
    ReCaptcha.configure do |config|
      config.private_key = 'foo'
      config.public_key = 'bar'
    end
  end

  subject { dummy_class.new }

  it { expect(subject).to respond_to(:recaptcha_tags) }
  it { expect(subject).to respond_to(:recaptcha_script) }

  describe '#recaptcha_tags' do
    context 'with options' do
      it 'should return an html tag' do
        expect(subject.recaptcha_tags(theme: 'dark')).to be_a(String)
        expect(subject.recaptcha_tags(theme: 'dark')).to match(/data-theme="dark"/)
      end
    end

    context 'without options' do
      it 'should return an html tag' do
        expect(subject.recaptcha_tags).to be_a(String)
        expect(subject.recaptcha_tags).to match(/data-theme="light"/)
      end
    end
  end

  describe '#recaptcha_script' do
    context 'without locale' do
      it 'should return an html tag without language code' do
        expect(subject.recaptcha_script).to be_a(String)
        expect(subject.recaptcha_script).to match(/api.js\" async defer>/)
      end
    end

    context 'with a known locale' do
      it 'should return an html tag with the right language code' do
        expect(subject.recaptcha_script(language: 'zh-CN')).to be_a(String)
        expect(subject.recaptcha_script(language: 'zh-CN')).to match(/api.js\?hl=zh-CN\" async defer>/)
      end
    end

    context 'with an unknown locale' do
      it 'should return an html tag with the "en" language code' do
        expect(subject.recaptcha_script(language: 'foo-BAR')).to be_a(String)
        expect(subject.recaptcha_script(language: 'foo-BAR')).to match(/api.js\?hl=en\" async defer>/)
      end
    end
  end
end
