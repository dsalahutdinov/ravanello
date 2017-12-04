# frozen_string_literal: true

module Ravanello
  module Routing
    # Root routing tree element
    class Root
      attr_reader :children

      def initialize(parent = nil, &blk)
        @parent = parent
        define(&blk)
      end

      def define(&blk)
        instance_eval(&blk) if block_given?
      end

      def namespace(name, &blk)
        append_child(Ravanello::Routing::Namespace.new(name.to_s, self, &blk))
      end

      def match(regex, &blk)
        append_child(Ravanello::Routing::Match.new(regex.to_s, self, &blk))
      end

      def routes?(*)
        true
      end

      def route(path_parts)
        path_parts
      end

      private

      def append_child(child)
        @children ||= []
        @children << child
      end
    end
  end
end
