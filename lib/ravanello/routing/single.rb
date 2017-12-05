# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents single item route
    class Single < Root
      def initialize(parent, &blk)
        super(parent, &blk)
      end

      def routable?(path_parts)
        path_parts.length == 1
      end

      def route(path_parts)
        []
      end

      def to_s
        "#{parent.to_s}ANY#{children.empty? ? '' : ':'}"
      end
    end
  end
end
