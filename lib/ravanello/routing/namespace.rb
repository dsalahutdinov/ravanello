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

      def routes?(path_parts)
        path_parts.first == name
      end

      def route(path_parts)
        return path_parts unless routes?(path_parts)

        new_path_parts = path_parts.dup
        new_path_parts.shift

        new_path_parts
      end
    end
  end
end
