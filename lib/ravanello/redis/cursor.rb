# frozen_string_literal: true

module Ravanello
  module Redis
    # Redis key cursor enumarable type
    class Cursor
      include Enumerable
      attr_reader :redis

      KEYS_BATCH_SIZE = 2_000

      def initialize(redis, query: nil, limit: nil)
        @redis = redis
        @query = query
        @limit = limit
      end

      def each
        loop do
          cursor = 0
          cursor, keys = redis.scan(cursor, count: KEYS_BATCH_SIZE)
          keys.each do |key|
            debug_data = redis.debug('object', key)

            yield(Key.new(key, Object.new(debug_data)))
          end
          break if cursor == '0'
        end
      end

      private

      def query
        @query || '*'
      end
    end
  end
end
