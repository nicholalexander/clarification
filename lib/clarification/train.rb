module Clarification
  class Train

    def initialize
      @model_id = nil
    end

    def add_image(image, concept_array)
      training_requester = TrainRequester.new([])
      response = training_requester.add_image_with_concepts(image, concept_array)
      return response # will be mostly status
    end
    
    def create_model(name, concept_array)
      training_requester = TrainRequester.new([])
      response = training_requester.create_model(name, concept_array)
      return response # should contain id and set model id?
    end
    
    def train_model(id)
      training_requester = TrainRequester.new([])
      response = training_requester.train_model(id)
      return response # should be status.
    end

  end
end
