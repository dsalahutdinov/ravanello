# frozen_string_literal: true

module Ravanello
  module Redis
    # Redis key with debug info (holding key size)
    class Key
      attr_reader :name, :size

      def initialize(name, size)
        @name = name
        @size = size
      end
    end
  end
end
