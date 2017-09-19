module Clarification
  class Client

    def initialize
      @active_models = Clarification.configuration.default_models
    end
    
    def request(url)
      r = Requester.new(@active_models)
      response = r.get(url)
    end

    def set_models(model_array)
      @active_models = model_array
    end

  end

end
