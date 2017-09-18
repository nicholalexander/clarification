require "spec_helper"

RSpec.describe Clarification do
  it "has a version number" do
    expect(Clarification::VERSION).not_to be nil
  end

  it "does nothing useful" do
    expect(true).to eq(true)
  end
end