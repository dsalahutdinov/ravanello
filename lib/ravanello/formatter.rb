# frozen_string_literal: true

require 'logger'

module Ravanello
  # Formats analyzed statistics and render it to the logger
  class Formatter
    attr_reader :analyzer, :logger
    def initialize(analyzer, logger = nil)
      @analyzer = analyzer
      @logger = logger || Logger.new(STDOUT)
    end

    def call
      analyzer.statistics.keys.sort_by { |k| analyzer.statistics[k].size }.reverse.each do |endpoint|
        size = analyzer.statistics[endpoint].size
        samples = (1..3).to_a.map { analyzer.statistics[endpoint].samples.sample.name }.uniq.join(', ')
        # logger.info "#{size} - #{endpoint.to_s} (#{samples})"
        logger.info("%-5s: %s (%s)" % [size.to_s, endpoint.to_s, samples])
      end
    end
  end
end
