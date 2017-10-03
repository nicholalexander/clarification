require 'spec_helper'

RSpec.describe Clarification::TrainRequester do

  it "should be a requester" do
    expect(Clarification::TrainRequester.superclass).to eq Clarification::Requester
  end

  before do
    Clarification.configure do |config|
      config.api_key = 'f7cc628178994e16b2470ae739ef927a'
      config.default_public_models = [:food, :general]
    end
    @concept_array = ['faces', 'people']
    @model_name = 'faces'
    @train_requester = Clarification::TrainRequester.new
  end

  describe "#add_image_with_concepts" do
    before do 
      @images = YAML.load_file("spec/fixtures/images.yml")
      image = @images[:faces]

      VCR.use_cassette('add_image_with_concepts') do
        @response = @train_requester.add_image_with_concepts(image, @concept_array)
      end
    end

    it "should return a successful status" do
      json_response = JSON.parse(@response)
      expect(json_response["status"]["code"]).to eq 10000
    end

    it "should return the unparsed body of the response" do
      expect(@response.class).to eq String
    end
    
  end

  describe "#create_model" do
    before do
      model_name = 'faces'

      VCR.use_cassette('create_model') do
        @response = @train_requester.create_model(model_name, @concept_array)
      end
    end

    it "should return the unparsed body of the resposne" do
      expect(@response.class).to eq String
    end

    it "should return a successful status" do
      json_response = JSON.parse(@response)
      expect(json_response["status"]["code"]).to eq 10000
    end

    it "should have the correct number of concepts trained" do
      json_response = JSON.parse(@response)
      expect(json_response["model"]["model_version"]["active_concept_count"]).to eq @concept_array.count
    end
  end

  describe "#train_model" do
    before do
      VCR.use_cassette('train_model') do
        @response = @train_requester.create_model(@model_name, @concept_array)
      end
    end

    it "should return the unparsed body of the resposne" do
      expect(@response.class).to eq String
    end

    it "should return a successful status" do
      json_response = JSON.parse(@response)
      expect(json_response["status"]["code"]).to eq 10000
    end

    it "should name the model the same as the id" do
      json_response = JSON.parse(@response)
      expect(json_response["model"]["name"]).to eq(@model_name)
      expect(json_response["model"]["id"]).to eq(@model_name)
    end
  end

end
