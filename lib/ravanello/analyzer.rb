# frozen_string_literal: true

module Ravanello
  # Analyzes data by router
  class Analyzer
    attr_reader :data, :router

    def initialize(router, data)
      @data = data
      @router = router
    end

    def call
      data.each do |redis_key|
        end_point = resolver.call(redis_key.name)
        add_statisics(end_point, redis_key)
      end
    end

    def statistics
      @statistics ||= {}
    end

    private

    def add_statisics(end_point, redis_key)
      statistics[end_point] = Statistics.new if statistics[end_point].nil?
      statistics[end_point].size += redis_key.object.size
      statistics[end_point].samples.push(redis_key) if statistics[end_point].samples.length < 100
    end

    def resolver
      @resolver ||= Ravanello::Resolver.new(router)
    end

    class Statistics
      attr_reader :size, :samples
      attr_writer :size

      def initialize
        @size = 0
        @samples = []
      end
    end
  end
end
