module Clarification
  class Enrich

    attr_reader :results
    
    def initialize(response_array)
      @response_array = response_array
      @results = {}
    end

    def run
      @response_array.each do |model, raw_response |
        @results[model.name] = Objectifier.new(raw_response.body)
      end
      return @results
    end

  end

end
