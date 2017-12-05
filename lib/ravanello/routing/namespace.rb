# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents namespace routing element
    class Namespace < Root
      attr_reader :name

      def initialize(name, parent, &blk)
        @name = name
        super(parent, &blk)
      end

      def routable?(path_parts)
        path_parts.first == name
      end

      def route(path_parts)
        return path_parts unless routable?(path_parts)

        new_path_parts = path_parts.dup
        new_path_parts.shift

        new_path_parts
      end

      def to_s
        "#{parent.to_s}#{name}#{children.empty? ? '' : ':'}"
      end
    end
  end
end
