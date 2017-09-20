module Clarification
  class Objectifier

    attr_reader :response_json, :status, :concepts

    def initialize(response)
      @response_json = JSON.parse(response)
      @status = OpenStruct.new(@response_json["status"])
      @concepts = []

      build_concept_objects
    end

    def build_concept_objects
      @response_json["outputs"][0]["data"]["concepts"].each do |concept|
        @concepts << OpenStruct.new(concept)
      end
    end

  end
end
