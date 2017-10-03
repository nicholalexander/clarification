require 'spec_helper'

RSpec.describe Clarification::SearchRequester do

  describe "#index" do
    
    before do
      Clarification.configure do |config|
        config.api_key = 'f7cc628178994e16b2470ae739ef927a'
        config.default_public_models = [:food, :general]
      end
      images = YAML.load_file("spec/fixtures/images.yml")
      @image = images[:donuts]

      VCR.use_cassette('search_requester_index') do
        @search_requester = Clarification::SearchRequester.new
        @response = @search_requester.index([@image])
      end
    end

    it "should return the body of the response" do
      expect(@response.class).to eq String
    end

    it 'should raise an error if you dont send it an array' do
      expect{@search_requester.index(@image)}.to raise_error(RuntimeError)
    end

    it 'should have successfully added the image' do
      json_response = JSON.parse(@response)
      expect(json_response['status']['code']).to eq 10000
    end

  end

  describe "#get_results_for_concept" do
    it "should return some concepts against the app's index"
  end


end
