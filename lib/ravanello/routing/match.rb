# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents regex match routing rule
    class Match < Base
      attr_reader :regex

      def initialize(regex, parent, &blk)
        @regex = regex
        super(parent, &blk)
      end

      def routable?(path_parts)
        regex == '*' ? !path_parts.empty? : !path_parts.first.match(regex).nil?
      end

      def route(path_parts)
        return [] if regex == '*'
        path_parts[1..path_parts.length - 1]
      end

      def to_s
        "#{parent}#{regex}#{children.empty? ? '' : ':'}"
      end
    end
  end
end
