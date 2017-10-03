require 'spec_helper'

RSpec.describe Clarification::Train do

  describe "#train_model" do
  
    before do
      
      VCR.use_cassette('train_train_model') do
        Clarification.configure do |config|
          config.api_key = 'f7cc628178994e16b2470ae739ef927a'
          config.default_public_models = [:food, :general]
        end

        @model = Clarification::Model.new(name: 'faces', id: 'faces')
        train = Clarification::Train.new
        @response = train.train_model(@model)
      end
    
    end

    it "should return a model" do
      expect(@response.class).to eq Clarification::Model
    end

    it "should return a the model being trained" do
      expect(@response.id).to eq @model.id
      expect(@response.name).to eq @model.name
    end

  end

end
