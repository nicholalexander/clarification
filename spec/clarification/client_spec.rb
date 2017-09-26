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

      expect(client.last_response).to be nil
      expect(client.active_public_models).to eq([:food])
    end
  end

  context "when the models are changed" do
    it "should rewrite the active_models" do
      client = Clarification::Client.new

      client.set_models([:general, :blurgh])

      expect(client.active_public_models.count).to eq(2)
      expect(client.active_public_models.last).to eq(:blurgh)
      expect(client.active_public_models.include?(:food)).to be(false)
    end

    context "when the models are changed and a single item is passed in" do
      it "should raise an error if the argument isn't an array" do
        client = Clarification::Client.new
        expect{client.set_models(:food)}.to raise_error(RuntimeError)
      end

      it "should give a meaningful error message about arrays" do
        client = Clarification::Client.new
        expect{client.set_models(:food)}.to raise_error(/array of models/)
      end
    end
  end

  describe "#predict" do
    it "the client should implement a method called predict" do
      expect(Clarification::Client.new.respond_to? :predict).to be true
    end

    context "with mocks" do
      it "should use a Requester to get the url and run an Enricher" do
        allow_any_instance_of(Clarification::Requester).to receive(:get)
        allow_any_instance_of(Clarification::Enrich).to receive(:run)

        client = Clarification::Client.new
        client.predict("some_url")
      end

      it "should set @last_response" do
        allow_any_instance_of(Clarification::Requester).to receive(:get)
        allow_any_instance_of(Clarification::Enrich).to receive(:run).and_return("blonk")      
        client = Clarification::Client.new
        client.predict("some_url") 
        expect(client.last_response).to eq("blonk")
      end
    end
  end

  describe "#search" do
    it "should have an instance of the search class accessible" do
      expect(Clarification::Client.new.search.class).to eq Clarification::Search
    end
  end


  describe "attr_readers" do
    it "should respond to active_public_models, last_response, and search" do
      [:active_public_models, :last_response, :search].each do |method|
        expect(Clarification::Client.new.respond_to? method).to be true
      end
    end
  end


end