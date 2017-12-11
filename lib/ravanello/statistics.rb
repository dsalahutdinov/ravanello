# frozen_string_literal: true

module Ravanello
  # Contains statistics result for the matched groups
  class Statistics
    attr_reader :data

    def initialize
      @data = {}
    end

    def append(path, redis_key)
      data[path] = Item.new if data[path].nil?

      data[path].inc(redis_key)
    end

    # Holds information about size and count of matched key group
    class Item
      attr_reader :count, :size, :samples

      def initialize
        @count = 0
        @size = 0
        @samples = []
      end

      def inc(redis_key)
        @count += 1
        @size += redis_key.size
        @samples.push(redis_key) if @samples.count < 100
      end
    end
  end
end
