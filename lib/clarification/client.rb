module Clarification
  class Client

    attr_reader :active_models, :last_response

    def initialize
      raise "No Configuration Found." if Clarification.configuration.nil?
      @active_models = Clarification.configuration.default_models
      @last_response = nil
    end
    
    def predict(url)
      requester = Requester.new(@active_models)
      response = requester.get(url)
      @last_response = Enrich.new(response).run
      return @last_response
    end

    def set_models(model_array)
      @active_models = model_array
    end

  end

end
