# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents regex match routing rule
    class Match < Root
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
        new_path_parts = path_parts.dup
        new_path_parts.shift

        new_path_parts
      end

      def to_s
        "#{parent.to_s}#{regex}#{children.empty? ? '' : ':'}"
      end
    end
  end
end
