require "clarification/client"
require "clarification/configuration"
require "clarification/end_points"
require "clarification/requester"
require "clarification/version"

require 'net/http'
require 'uri'
require 'json'

module Clarification
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(self.configuration)
    end
  end
end 
