# frozen_string_literal: true

module Ravanello
  module Routing
    # Root routing tree element
    class Root < Base
      def routable?(*)
        true
      end

      def route(path_parts)
        path_parts
      end

      def to_s
        ''
      end
    end
  end
end
