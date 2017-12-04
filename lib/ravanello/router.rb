# frozen_string_literal: true

module Ravanello
  # Routes redis keys to the counting endpoints
  class Router
    attr_reader :root
    def initialize(options = {}, &blk)
      @options = options

      @root = Ravanello::Routing::Root.new(&blk)
    end

    def namespace(name, &blk)
      Ravanello::Routing::Namespace.new(name, self, &blk)
    end

    def match(match_string)
      Ravanello::Routing::Match.new(match_string, self, &blk)
    end
  end
end
