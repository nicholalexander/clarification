require 'spec_helper'

RSpec.describe Clarification::Configuration do

  it "should have api_key" do
    expect(Clarification::Configuration.new.api_key).to eq("YOUR_API_KEY")
  end

  it "should have empty default_public_models array" do
    expect(Clarification::Configuration.new.default_public_models.empty?).to be true
    expect(Clarification::Configuration.new.default_public_models.class).to eq Array
  end

end
