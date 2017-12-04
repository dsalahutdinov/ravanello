# frozen_string_literal: true

module Ravanello
  # Resolves redis key to the endpoint
  class Resolver
    attr_reader :router

    def initialize(router, options = {})
      @router = router
      @separator = options.fetch(:separator, ':')
    end

    def resolve(path)
      path_parts = path.split(@separator)
      resolve_by_parts(router.root, path_parts)
    end

    def resolve_by_parts(node, path_parts)
      if node.routable?(path_parts)
        new_path_parts = node.route(path_parts)
        return node if new_path_parts.empty?

        node.children.each do |child|
          r = resolve_by_parts(child, new_path_parts)
          return r unless r.nil?
        end
      end

      nil
    end
  end
end
