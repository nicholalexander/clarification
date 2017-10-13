module Clarification

  class TrainResponse < Response

    def initialize(raw_response)
      @raw_response = JSON.parse(raw_response)
    end

    def create_model
      if @raw_response['status']['code'] == 10000
        Model.new(id: @raw_response['model']['id'],
          name: @raw_response['model']['name'])
      end
    end

    def train_model
      if @raw_response['status']['code'] == 10000
        Model.new(id: @raw_response['model']['id'],
          name: @raw_response['model']['name'])
      end
    end



  end
end

