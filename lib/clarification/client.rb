module Clarification
  class Client

    def initialize
      
    end
    
    def request(url)

      r = Requester.new(:food)
      response = r.get(url)

    end


    def make_request
      uri = URI.parse("https://api.clarifai.com/v2/models/bd367be194cf45149e75f01d59f77ba7/outputs")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = "Key f7cc628178994e16b2470ae739ef927a"
      request.body = JSON.dump({
        "inputs" => [
          {
            "data" => {
              "image" => {
                "url" => "https://samples.clarifai.com/food.jpg"
              }
            }
          }
        ]
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      puts response
    end

  end
end
