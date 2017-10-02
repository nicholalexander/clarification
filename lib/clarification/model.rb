module Clarification
  class Model

    attr_accessor :name, :id
    
    def initialize(name:, id:)
      @name = name
      @id = id
      @info = nil
    end

  end
end
