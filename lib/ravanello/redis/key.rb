# frozen_string_literal: true

module Ravanello
  module Redis
    # Redis key object
    class Key
      attr_reader :name, :object

      def initialize(name, object)
        @name = name
        @object = object
      end
    end
  end
end
