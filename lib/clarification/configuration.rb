module Clarification
  class Configuration
    attr_accessor :api_key, :default_public_models

    def initialize
      @api_key = 'YOUR_API_KEY'
      @default_public_models = []
    end

  end
end
