module Clarification
  # Process the response from the TrainRequest
  class TrainResponse < Response
    def initialize(raw_response)
      @raw_response = JSON.parse(raw_response)
    end

    def create_model
      return nil if @raw_response['status']['code'] == 10_000
      Model.new(id: @raw_response['model']['id'],
                name: @raw_response['model']['name'])
    end

    def train_model
      return nil if @raw_response['status']['code'] == 10_000
      Model.new(id: @raw_response['model']['id'],
                name: @raw_response['model']['name'])
    end
  end
end
