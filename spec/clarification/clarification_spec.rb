require "spec_helper"

RSpec.describe Clarification do
  describe "#configure" do
    
    context "when it is configured" do
      before do
        Clarification.configure do |config|
          config.api_key = 'asdfasdfasdf'    
          config.default_public_models = [:food, :faces]
        end
      end

      it "should be configured with an api key" do
        expect(Clarification.configuration.api_key).to eq 'asdfasdfasdf'
      end

      it "should be configured with an array of models to process against" do
        expect(Clarification.configuration.default_public_models).to eq [:food, :faces]
      end
    end

    context "when it does not have a configuration set for the models" do
      it "should have have an empty array for the models" do
        Clarification.configuration = nil
        
        Clarification.configure do |config|
          config.api_key = 'asdf'
        end
        expect(Clarification.configuration.default_public_models.empty?).to be true
      end
    end


  end
end