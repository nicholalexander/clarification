module Clarification
  class Search
  
    def initialize
    end

    def index_images(image_array)
      search_requester = Clarification::SearchRequester.new
      search_requester.index(image_array)
      # need some useful response here
    end

    def by_images(image_array)
    end

    def by_concept(concept)
      search_requester = Clarification::SearchRequester.new
      search_requester.get_results_for_concept(concept)
    end


  end
end
