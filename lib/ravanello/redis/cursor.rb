# frozen_string_literal: true

require 'redis'
module Ravanello
  module Redis
    # Redis key cursor enumarable type
    class Cursor
      SIZE_REGEX = /serializedlength:(\d*)/

      include Enumerable
      attr_reader :redis

      KEYS_BATCH_SIZE = 2_000

      def initialize(redis, limit: nil)
        @redis = redis
        @limit = limit
      end

      def each
        counter = 0
        cursor = 0
        while cursor != '0'
          cursor, keys = redis.scan(cursor, count: KEYS_BATCH_SIZE)
          keys.each do |key|
            break if !@limit.nil? && counter >= @limit
            counter += 1
            yield(Key.new(key, size(key)))
          end
        end
      end

      private

      def size(key)
        debug_data = redis.debug('object', key)
        SIZE_REGEX.match(debug_data)[1].to_i
      end
    end
  end
end
