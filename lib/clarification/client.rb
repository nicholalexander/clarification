module Clarification
  class Client

    attr_reader :active_public_models, :last_response, :search

    def initialize
      raise "No Configuration Found." if Clarification.configuration.nil?
      @active_public_models = Clarification.configuration.default_public_models
      @last_response = nil
      @search = Search.new
    end
    
    def predict(url)
      requester = Requester.new(@active_public_models)
      response = requester.get(url)
      @last_response = Enrich.new(response).run
      return @last_response
    end

    def set_models(model_array)
      @active_public_models = model_array
    end

  end

end
