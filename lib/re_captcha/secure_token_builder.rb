require 'json'
require 'securerandom'
require 'openssl'

module ReCaptcha
  class SecureTokenBuilder

    def self.build(private_key)
      json_token = generate_json_token
      private_key_digest = digest_key private_key
      cipher = prepare_cipher private_key_digest
      encode_token json_token, cipher
    end

    private

    def self.encode_token(token, cipher)
      encrypted_token = cipher.update(token) << cipher.final
      strip_padding Base64.urlsafe_encode64(encrypted_stoken)
    end

    def self.digest_key(key)
      Digest::SHA1.digest(key)[0...16]
    end

    def self.prepare_cipher(key)
      cipher = OpenSSL::Cipher::AES128.new(:ECB)
      cipher.encrypt
      cipher.key = key
      cipher
    end

    def self.generate_json_token
      {session_id: SecureRandom.uuid, ts_ms: (Time.now.to_f * 1000).to_i}.to_json
    end

    def self.strip_padding(string)
      string.gsub(/\=+\Z/, '')
    end
  end
end
