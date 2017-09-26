module Clarification
  class Search
  
    attr_reader :last_search

    def initialize
      @last_search = nil
    end

    def index_images(image_array)
      search_requester = Clarification::SearchRequester.new
      search_requester.index(image_array)
      # need some useful response here
    end

    def by_images(_image_array)
      raise "Not Implemented"
    end

    def by_concept(concept)
      search_requester = Clarification::SearchRequester.new
      raw_response = search_requester.get_results_for_concept(concept)
      structured_response = Clarification::SearchResponse.new(raw_response.body, concept)
      @last_search = structured_response
      return structured_response
    end

  end
end
