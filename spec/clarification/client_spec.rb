require "spec_helper"

RSpec.describe Clarification::Client do
      
  context "when first initialized" do 
    it "should raise a configuration error if no configuration present" do
      Clarification.configuration = nil
      expect{Clarification::Client.new}.to raise_error(RuntimeError)
    end

    it "should initialize from the configuration" do
      Clarification.configure do |config|
        config.api_key = 'blurgh'
        config.default_public_models = [:food]
      end

      client = Clarification::Client.new

      expect(client.active_models.first.name).to eq(:food)
    end
  end

  context "when the models are changed" do
    it "should rewrite the active_models" do
      client = Clarification::Client.new

      client.set_active_models_by_public_key([:general, :focus])

      expect(client.active_models.count).to eq(2)
      expect(client.active_models.last.name).to eq(:focus)
      expect(client.active_models.include?(:food)).to be(false)
    end

    context "when the models are changed and a single item is passed in" do
      it "should raise an error if the argument isn't an array" do
        client = Clarification::Client.new
        expect{client.set_active_models_by_public_key(:food)}.to raise_error(RuntimeError)
      end

      it "should give a meaningful error message about arrays" do
        client = Clarification::Client.new
        expect{client.set_active_models_by_public_key(:food)}.to raise_error(/array of model/)
      end
    end
  end

  describe "#predict" do
    it "the client should have accees to a predict object" do
      expect(Clarification::Client.new.predict.class).to eq Clarification::Predict
    end
  end

  describe "#search" do
    it "should have an instance of the search class accessible" do
      expect(Clarification::Client.new.search.class).to eq Clarification::Search
    end
  end

  describe "#train" do
    it "should have an instance of the train class accessible" do
      expect(Clarification::Client.new.train.class).to eq Clarification::Train
    end
  end


  describe "attr_readers" do
    it "should respond to active_public_models" do
      expect(Clarification::Client.new.respond_to? :active_models).to be true
    end
  end


end