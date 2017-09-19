module Clarification
  class Requester

    def initialize(model)
      @model = model
    end

    def get(target_url)
      uri = uri_builder
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

    def uri_builder
      uri = URI.parse("https://api.clarifai.com/v2/models/bd367be194cf45149e75f01d59f77ba7/outputs")
    end

    def request_builder(uri, body)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = "Key f7cc628178994e16b2470ae739ef927a"
      request.body = JSON.dump(body)

      return request
    end

    def options_builder(uri)
      request_options = {
        use_ssl: uri.scheme == "https",
      }

      return request_options
    end



  end
end
