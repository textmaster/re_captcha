module ReCaptcha
  module API

    # TODO: handle 40x and 50x

    def post(path, params, options, end_point = api_endpoint)
      with_timeout do
        resource = RestClient::Resource.new(end_point + path, options.merge(default_options))
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

    def with_timeout(&block)
      begin
        block.call
      rescue RestClient::RequestTimeout => e
        {success: true}
      rescue => e
        raise e
      end
    end

  end
end
