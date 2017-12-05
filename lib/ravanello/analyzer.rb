# frozen_string_literal: true

module Ravanello
  # Analyzes data by router
  class Analyzer
    def initialize(router, data)
      @data = data
      @router = router
    end

    def call
      statistics = Ravanello::Statistics.new

      @data.each do |redis_key|
        end_point = resolver.call(redis_key.name)
        statistics.append(end_point.to_s, redis_key)
      end

      statistics
    end

    private

    def resolver
      @resolver ||= Ravanello::Resolver.new(@router)
    end
  end
end
