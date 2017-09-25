module Clarification
  class Hit < Struct.new(:score, :url, :created_at)
  end
end