module Clarification
  class Predict

    attr_reader :last_response
    
    def initialize(models)
      @models = models
      @last_response = nil
    end

    def by_url(url)
      requester = PredictRequester.new(@models)
      response = requester.get(url)
      @last_response = Enrich.new(response).run
      return @last_response
    end

  end
end
