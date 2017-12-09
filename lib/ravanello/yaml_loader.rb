# frozen_string_literal: true

require 'yaml'
module Ravanello
  # Loads the router from yml file
  class YamlLoader
    def initialize(yaml)
      @source = YAML.safe_load(yaml)
    end

    def call
      router = Ravanello::Router.new
      process_group(router.root, @source['rules'])
      router
    end

    private

    def process_group(parent, yaml)
      case yaml
      when Hash
        process_hash_group(parent, yaml)
      when Array
        process_array_group(parent, yaml)
      end

      parent.match('*')
    end

    def process_hash_group(parent, yaml)
      yaml.each do |k, v|
        process_group(parent.match(k), v)
      end
    end

    def process_array_group(parent, yaml)
      yaml.each { |name| parent.match(name).match('*') }
    end
  end
end
