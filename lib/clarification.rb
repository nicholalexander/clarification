require "clarification/client"
require "clarification/concept"
require "clarification/configuration"
require "clarification/end_points"
require "clarification/enrich"
require "clarification/hit"
require "clarification/model"
require "clarification/objectifier"
require "clarification/predict"
require "clarification/response"
require "clarification/response/search_response"
require "clarification/response/train_response"
require "clarification/requester"
require "clarification/requester/predict_requester"
require "clarification/requester/search_requester"
require "clarification/requester/train_requester"
require "clarification/search"
require "clarification/train"
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
