require "spec_helper"

RSpec.describe Clarification do
  describe "end points" do
    it "should have v2 as the base url" do
      expect(Clarification::BASE_URL.include?('v2')).to be true
    end

    it "should have a value for food" do
      expect(Clarification.constants.include?(:FOOD)).to be true
    end
  end
end

