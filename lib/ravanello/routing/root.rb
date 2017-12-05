# frozen_string_literal: true

module Ravanello
  module Routing
    # Root routing tree element
    class Root
      attr_reader :children, :parent

      def initialize(parent = nil, &blk)
        @parent = parent
        @children = []
        instance_eval(&blk) if block_given?
      end

      def namespace(name, &blk)
        children.push(
          Ravanello::Routing::Namespace.new(name.to_s, self, &blk)
        )
      end

      def match(regex, &blk)
        children.push(
          Ravanello::Routing::Match.new(regex.to_s, self, &blk)
        )
      end

      def single(&blk)
        children.push(
          Ravanello::Routing::Single.new(self, &blk)
        )
      end

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
