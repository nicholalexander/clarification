module Clarification
  class Client

    attr_reader :active_models

    def initialize
      @active_models = Clarification.configuration.default_models
      @last_response = nil
    end
    
    def predict(url)
      r = Requester.new(@active_models)
      response = r.get(url)
      # @last_response = Enrich.new(response)
      # return @last_response
    end

    def set_models(model_array)
      @active_models = model_array
    end

  end

end
