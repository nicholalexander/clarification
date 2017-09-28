module Clarification
  class TrainRequester < Clarification::Requester

    def add_image_with_concepts(target_url, concept_array)
      uri = uri_builder("inputs")
      body = image_with_concepts_body_builder(target_url, concept_array)
      response = get_response(uri, body)
      return response
    end

    def create_model(name, concept_array)
      uri = uri_builder("models")
      body = create_model_body_builder(name, concept_array)
      response = get_response(uri, body)
      return response
    end

    def train_model(id)
      uri = uri_builder("models/#{id}/versions")
      body = {}
      response = get_response(uri, body)
      return response
    end

    private

    def uri_builder(path)
      url = "#{Clarification::BASE_URL}#{path}"
      URI.parse(url)
    end

    def image_with_concepts_body_builder(target_url, concept_array)
      body_concepts = []

      concept_array.each do |concept|
        body_concepts << {
          id: concept,
          value: true
        }  
      end

      {
        inputs: [
          {
            data: {
              image: {
                url: target_url
              },
              concepts: body_concepts
            }
          }
        ]
      }
    end

    def create_model_body_builder(name, concept_array)
      body_concepts = []

      concept_array.each do |concept|
        body_concepts << {
          id: concept,
        }  
      end

      {
        model: {
          id: name,
          output_info: {
            data: {
              concepts: body_concepts
            },
            output_config: {
              concepts_mutually_exclusive: false,
              closed_environment:false
            }
          }
        }
      }
    end

  end
end
