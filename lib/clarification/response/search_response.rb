module Clarification

  class SearchResponse < Response

    attr_reader :hits, :raw_response, :concept

    def initialize(raw_response, concept)
      @hits = []
      @concept = concept
      @raw_response = JSON.parse(raw_response)

      parse_raw_response
    end

    private
    def parse_raw_response
      @raw_response['hits'].each do |hit|
        score = hit["score"]
        url = hit["input"]["data"]["image"]["url"]
        created_at = hit["input"]["created_at"]
        @hits << Hit.new(score, url, created_at)
      end
    end

  end
end

