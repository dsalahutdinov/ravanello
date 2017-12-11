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

      def match(name, &blk)
        namespace = Ravanello::Routing::Match.new(name.to_s, self, &blk)
        children.push(namespace)
        namespace
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
