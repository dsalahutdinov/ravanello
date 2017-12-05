# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents single item route
    class Single < Base
      def routable?(path_parts)
        path_parts.length == 1
      end

      def route(*)
        []
      end

      def to_s
        "#{parent}ANY#{children.empty? ? '' : ':'}"
      end
    end
  end
end
