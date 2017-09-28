module Clarification
  class Requester

    def initialize(*model_array)
      @model_array = model_array
    end

    def get(target_url)
      response = {}
      @model_array.each do |model|
        response[model] = get_with_model(target_url, model)
      end
      return response
    end

    private

    def get_with_model(target_url, model)
      uri = uri_builder(model)
      body = body_builder(target_url)
      request = request_builder(uri, body)
      options = options_builder(uri)

      response = Net::HTTP.start(uri.hostname, uri.port, options) do |http|
        http.request(request)
      end

      return response
    end

    private

    def body_builder(url)
      {
        "inputs": [
          {
            "data": {
              "image": {
                "url": "#{url}"
              }
            }
          }
        ]
      }
    end

    def uri_builder(model)
      model_key = Clarification::PUBLIC_MODELS[model]
      url = "#{Clarification::BASE_URL}models/#{model_key}/outputs"
      uri = URI.parse(url)
    end

    def request_builder(uri, body)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = "Key #{Clarification.configuration.api_key}"
      request.body = JSON.dump(body)

      return request
    end

    def options_builder(uri)
      request_options = {
        use_ssl: uri.scheme == "https",
      }
      return request_options
    end

    def get_response(uri, body)
      request = request_builder(uri, body)
      options = options_builder(uri)

      response = Net::HTTP.start(uri.hostname, uri.port, options) do |http|
        http.request(request)
      end

      return response
    
    end


  end
end
