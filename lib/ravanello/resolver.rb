# frozen_string_literal: true

module Ravanello
  # Resolves redis key to the endpoint
  class Resolver
    attr_reader :router

    def initialize(router, options = {})
      @router = router
      @separator = options.fetch(:separator, ':')
    end

    def call(path)
      path_parts = path.split(@separator)
      resolved = NodeResolver.new(router.root, *path_parts).call

      raise Error.new("Error resolving #{path}") if resolved.nil?

      resolved
    end

    # Resolves endpoint by node
    class NodeResolver
      attr_reader :node, :path

      def initialize(node, *path)
        @node = node
        @path = path
      end

      def call
        if node.routable?(path)
          new_path = node.route(path)
          return node if new_path.empty?

          node.children.each do |child|
            resolved = NodeResolver.new(child, *new_path).call
            return resolved unless resolved.nil?
          end
        end

        nil
      end
    end

    # Represents resolving path error
    class Error < ::StandardError
    end
  end
end
