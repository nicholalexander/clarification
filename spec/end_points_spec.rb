require "spec_helper"

RSpec.describe Clarification do
  describe "end points" do
    it "should have v2 as the base url" do
      expect(Clarification::BASE_URL.include?('v2')).to be true
    end

    it "should have values for all clarifai public models" do
      models = [:apparel,
         :celebrity,
         :color,
         :demographics,
         :face_detection,
         :face_embedding,
         :focus,
         :food,
         :general,
         :general_embedding,
         :logo,
         :moderation,
         :nsfw,
         :travel,
         :wedding ]
      expect(Clarification::PUBLIC_MODELS.keys).to eq(models)
    end

  end
end

