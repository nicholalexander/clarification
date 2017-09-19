require "spec_helper"

RSpec.describe Clarification do
  describe "#configure" do
    before do
      Clarification.configure do |config|
        config.api_key = 'asdfasdfasdf'    
      end
    end

    it "should be configured with an api key" do
      expect(Clarification.configuration.api_key).to eq 'asdfasdfasdf'
    end
  end
end