require 'pry'

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
      concepts = @response_json.fetch("outputs").fetch(0).fetch("data", nil).fetch("concepts", nil)
      if concepts
        begin
          concepts.each do |concept|
            @concepts << OpenStruct.new(concept)
          end
        rescue
        end
      else
        data = @response_json.fetch("outputs").fetch(0).fetch("data", nil)
        if !data.empty?
          
          # case @response[:focus].response_json['outputs'][0]['model']['name']
          # when "focus"
          # when "color"
          # when "general_embedding"
          # end
          
        end
      end

    end

  end
end


