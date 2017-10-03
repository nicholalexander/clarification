module Clarification
  class Train

    def add_image(image, concept_array)
      training_requester = TrainRequester.new
      response = training_requester.add_image_with_concepts(image, concept_array)
      return response # will be mostly status
    end
    
    def create_model(name, concept_array)
      training_requester = TrainRequester.new
      response = training_requester.create_model(name, concept_array)
      TrainResponse.new(response).create_model
    end
    
    def train_model(model)
      training_requester = TrainRequester.new
      response = training_requester.train_model(model.id)
      TrainResponse.new(response).train_model
    end

  end
end
