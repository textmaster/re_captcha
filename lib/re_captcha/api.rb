require 'rest-client'

module ReCaptcha
  module API

    def post(path, params, options: {}, end_point: api_endpoint)
      http_request do
        uri      = URI(end_point).merge(path).to_s
        resource = RestClient::Resource.new(uri, options.merge(default_options))
        response = resource.post params.merge(default_params)
        JSON.parse response
      end
    end

    private

    def default_params
      { secret: private_key }
    end

    def default_options
      { read_timeout: 3, open_timeout: 3 }
    end

    def http_request(&block)
      block.call
    rescue RestClient::RequestTimeout, RestClient::ExceptionWithResponse, RestClient::RequestFailed
      { "success" => true }
    end

  end
end
