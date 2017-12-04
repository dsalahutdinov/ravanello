# frozen_string_literal: true

module Ravanello
  module Redis
    # Contains redis debugging information
    class Object
      LENGTH_REGEX = /serializedlength:(\d*)/

      def initialize(debug_info)
        @debug_info = debug_info
      end

      def size
        @size ||= LENGTH_REGEX.match(@debug_info)[1].to_i
      end
    end
  end
end
