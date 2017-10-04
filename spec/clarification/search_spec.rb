require 'spec_helper'

RSpec.describe Clarification::Search do 

  before do
    Clarification.configure do |config|
      config.api_key = 'f7cc628178994e16b2470ae739ef927a'
      config.default_public_models = [:food, :general]
    end
  end

  describe "#index_images" do
    it "should return a successful status" do
      search = Clarification::Search.new
      images = YAML.load_file("spec/fixtures/images.yml")
      image_array = [images[:kitten]]

      VCR.use_cassette('index_cat') do
        @response = search.index_images(image_array)
      end

      expect(@response.class).to eq String
      expect(JSON.parse(@response)['status']['code']).to eq 10000
    end
  end

  describe "#by_images" do
    it "should raise an error" do
      expect{Clarification::Search.new.by_images([])}.to raise_error(RuntimeError)
    end
  end

  describe "#by_concept" do
    context "when there is a successful search" do      
      before do
        search = Clarification::Search.new
        @concept = 'cat'
        VCR.use_cassette('search_cat') do
          @response = search.by_concept(@concept)
        end
      end

      it "should have a status of 10000 in the raw_response" do
        expect(@response.raw_response["status"]["code"]).to eq 10000
      end

      it "should return a SearchResponse" do
        expect(@response.class).to eq Clarification::SearchResponse
      end

      it "should store the json of the raw_response as a hash" do
        expect(@response.raw_response.class).to eq Hash
      end

      it "should have the searched concept in @concept" do
        expect(@response.concept).to eq @concept
      end

      it "should have an array of hits" do
        expect(@response.hits.class).to eq Array
        expect(@response.hits.count).not_to eq 0
      end
    end
  end

end
