# frozen_string_literal: true

module Ravanello
  # Routes redis keys to the counting endpoints
  class Router
    attr_reader :root

    def initialize(&blk)
      @root = Ravanello::Routing::Root.new(&blk)
    end
  end
end
