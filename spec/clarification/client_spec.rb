require 'pry'

require "spec_helper"

RSpec.describe Clarification::Client do
      
  context "when first initialized" do 
    it "should raise a configuration error if no configuration present" do
      expect{Clarification::Client.new}.to raise_error(RuntimeError)
    end

    it "should initialize from the configuration" do
      Clarification.configure do |config|
        config.api_key = 'blurgh'
        config.default_models = [:food]
      end

      client = Clarification::Client.new

      expect(client.last_response).to be nil
      expect(client.active_models).to eq([:food])
    end
  end

  context "when the models are changed" do
    it "should rewrite the active_models" do
      client = Clarification::Client.new

      client.set_models([:general, :blurgh])

      expect(client.active_models.count).to eq(2)
      expect(client.active_models.last).to eq(:blurgh)
      expect(client.active_models.include?(:food)).to be(false)
    end
  end

  describe "#predict" do
    it "the client should implement a method called predict" do
      expect(Clarification::Client.new.respond_to? :predict).to be true
    end
  end


end