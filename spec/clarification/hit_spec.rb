require "spec_helper"

RSpec.describe Clarification::Hit do

  it "should have a nil score" do
    expect(Clarification::Hit.new.score.nil?).to be true    
  end

  it "should have a nil url" do
    expect(Clarification::Hit.new.url.nil?).to be true
  end

  it "should have a nil created_at" do    
    expect(Clarification::Hit.new.created_at.nil?).to be true
  end

end
