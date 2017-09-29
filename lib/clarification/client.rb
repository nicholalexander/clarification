module Clarification
  class Client

    attr_reader :active_public_models, :search, :train, :predict

    def initialize
      raise "No Configuration Found." if Clarification.configuration.nil?
      @active_public_models = Clarification.configuration.default_public_models
      @search = Search.new
      @train = Train.new
      @predict = Predict.new(@active_public_models)
    end

    def set_models(model_array)
      if model_array.class != Array
        raise "Clarification expects an array of models."
      end
      
      @active_public_models = model_array
      @predict = Predict.new(@active_public_models)
    end

  end

end
