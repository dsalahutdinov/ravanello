#!/usr/bin/env ruby

require "bundler/setup"
require "ravanello"

class Ravanello::Application
  def run
    router = Ravanello::YamlLoader.new(STDIN.read).call
    cursor = Ravanello::Redis::Cursor.new(redis, limit: redis_fetch_limit)
    statistics = Ravanello::Analyzer.new(router, cursor).call
    print(statistics)
  end

  private

  def print(statistics)
    puts
    puts '-' * 80
    Ravanello::Formatter.new(statistics).call.each do |line|
      puts line
    end
    puts '-' * 80

    if statistics.data['*']
      puts "SAMPLES FOR *:"
      puts (1..10).to_a.map { statistics.data['*'].samples.sample.name }.join("\n")
    end
  end

  def redis
    @redis ||= Redis.new(url: ENV['REDIS'])
  end

  def redis_fetch_limit
    fetch_limit = ENV['FETCH_LIMIT']
    (fetch_limit.nil? || fetch_limit == '') ?  nil : fetch_limit.to_i
  end
end

Ravanello::Application.new.run
