module Clarification
  class SearchRequester < Clarification::Requester

    def initialize
    end

    def index(target_urls)
      uri = uri_builder("inputs")
      body = body_builder(target_urls)
      response = get_response(uri, body)
      return response
    end

    def get_results_for_concept(concept)
      uri = uri_builder("searches")
      body = concept_body_builder(concept)
      response = get_response(uri, body)
      return response
    end

    private

    def body_builder(target_urls)
      # build individual inputs
      inputs = []
      target_urls.each do |url|
        inputs << {
          data: {
            image: {
              url: url
            }
          }
        }
      end

      # wrap for api
      {
        inputs: inputs
      }
    end

    def concept_body_builder(concept)
      {
        query: {
          ands: [
            {
              output: {
                data: {
                  concepts: [
                    {
                      name: "#{concept}"
                    }
                  ]
                }
              }
            }
          ]
        }
      }
      
    end


    def uri_builder(path)
      url = "#{Clarification::BASE_URL}#{path}"
      uri = URI.parse(url)
    end

  end
end
