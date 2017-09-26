module Clarification
  class Objectifier

    attr_reader :response_json, :status, :concepts, :error

    def initialize(response)
      @response_json = JSON.parse(response)
      @status = OpenStruct.new(@response_json["status"])
      @concepts = []
      @error = nil

      
      build_concept_objects
      

    end

    def build_concept_objects
      
      begin
        concepts = @response_json.fetch("outputs").fetch(0).fetch("data", nil).fetch("concepts", nil)
      rescue StandardError => e
        @error = e
        return
      end

      if concepts  
        concepts.each do |concept|
          @concepts << OpenStruct.new(concept) # conecept = tag?
        end
      else
        data = @response_json.fetch("outputs").fetch(0).fetch("data", nil)
        unless data.empty?
          case @response_json['outputs'][0]['model']['name']
          when "focus"
            # concept.class = concept::focus
            focus = OpenStruct.new(data["focus"])
            regions = []
            data["regions"].each do |region|
              regions << OpenStruct.new(region)
            end
            focus_hash = {focus: focus, regions: regions}
            @concepts << OpenStruct.new(focus_hash)
            @concepts.first.name = "focus"
          when "color"
            # concept.class = concept::color
            data["colors"].each do |color|
              @concepts << OpenStruct.new(color)
            end
          when "general_embedding"
            # concept.class = concept::embedding
            @concepts << OpenStruct.new(data["embeddings"][0])
            @concepts.first.name = "embedding"
          end
        end
      end

    end

  end
end


