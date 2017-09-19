require "clarification/version"
require "clarification/configuration"

module Clarification
  class << self
    attr_accessor :configuration

    def configure
      self.configuration || Configuration.new
      yield(configuration)
    end
  end
end 
