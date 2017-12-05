# frozen_string_literal: true

require 'logger'

module Ravanello
  # Formats analyzed statistics and render it as string arrays
  class Formatter
    def initialize(statistics)
      @statistics = statistics
    end

    def call
      data.map do |path|
        size = @statistics.data[path].size
        sample = @statistics.data[path].samples.sample.name
        format('%-5s: %s (%s)', size.to_s, path.to_s, sample)
      end
    end

    private

    def data
      @statistics.data.keys.sort_by { |k| @statistics.data[k].size }.reverse
    end
  end
end
