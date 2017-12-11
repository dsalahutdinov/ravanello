# frozen_string_literal: true

require 'ravanello'
require 'thor'

module Ravanello
  # Redis analyze command
  class Analyze
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def call
      router = YamlLoader.new(File.read(options.fetch('rules'))).call
      cursor = Redis::Cursor.new(redis, limit: redis_fetch_limit)
      statistics = Analyzer.new(router, cursor).call
      print(statistics)
      print_samples(statistics)
    end

    private

    def print(statistics)
      Ravanello::Formatter.new(statistics).call.each { |line| puts line }
    end

    def print_samples(statistics)
      return if statistics.data['*'].nil?
      puts 'Discard sample keys:'
      samples = (1..10).map { statistics.data['*'].samples.sample.name }.uniq
      samples.each { |sample| puts "\t#{sample}" }
    end

    def redis
      @redis ||= ::Redis.new(url: ENV['REDIS'])
    end

    def redis_fetch_limit
      fetch_limit = ENV['FETCH_LIMIT']
      fetch_limit.nil? || fetch_limit == '' ? nil : fetch_limit.to_i
    end
  end
end
