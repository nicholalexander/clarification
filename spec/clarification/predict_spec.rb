require 'spec_helper'

RSpec.describe Clarification::Predict do

    before do
      Clarification.configure do |config|
        config.api_key = 'f7cc628178994e16b2470ae739ef927a'
        config.default_public_models = [:food, :general]
      end

      images = YAML.load_file("spec/fixtures/images.yml")
      @url = images[:kitten]
    end

    it "should return an array of concepts" do        
      VCR.use_cassette('predict_cat') do

        client = Clarification::Client.new
        response = client.predict.by_url(@url)

        expect(response[:general].concepts.class).to eq Array
      end
    end

    it "should set @last_response" do
      VCR.use_cassette('predict_cat', re_record_interval: 604800) do

        client = Clarification::Client.new
        response = client.predict.by_url(@url)

        expect(client.predict.last_response).to eq response
      end
    end

end
