# frozen_string_literal: true

module Ravanello
  module Routing
    # Represents namespace routing element
    class Namespace < Base
      attr_reader :name

      def initialize(name, parent, &blk)
        @name = name
        super(parent, &blk)
        children.push(Match.new('*', self)) if children.empty?
      end

      def routable?(path_parts)
        path_parts.first == name
      end

      def route(path_parts)
        return path_parts unless routable?(path_parts)
        path_parts[1..path_parts.length - 1]
      end

      def to_s
        "#{parent}#{name}#{children.empty? ? '' : ':'}"
      end
    end
  end
end
