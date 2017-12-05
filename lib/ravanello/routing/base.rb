# frozen_string_literal: true

module Ravanello
  module Routing
    # Base key routing class
    class Base
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
        raise StandardError, 'Not implemented'
      end

      def route(*)
        raise StandardError, 'Not implemented'
      end

      def to_s
        raise StandardError, 'Not implemented'
      end
    end
  end
end
