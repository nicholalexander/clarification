module Clarification
  class Client

    attr_reader :active_public_models, :last_response, :search, :train

    def initialize
      raise "No Configuration Found." if Clarification.configuration.nil?
      @active_public_models = Clarification.configuration.default_public_models
      @last_response = nil
      @search = Search.new
      @train = Train.new
    end
    
    def predict(url)
      requester = Requester.new(@active_public_models)
      response = requester.get(url)
      @last_response = Enrich.new(response).run
      return @last_response
    end

    def set_models(model_array)
      if model_array.class != Array
        raise "Clarification expects an array of models."
      end
      
      @active_public_models = model_array
    end

  end

end
