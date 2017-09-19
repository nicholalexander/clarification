require "clarification/configuration"
require "clarification/end_points"
require "clarification/version"

module Clarification
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(self.configuration)
    end
  end
end 
