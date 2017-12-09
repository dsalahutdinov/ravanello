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
        data_item = @statistics.data[path]
        format(
          '%-5s %-5s %s (%s)',
          data_item.count.to_s,
          data_item.size.to_s,
          path.to_s,
          data_item.samples.sample.name
        )
      end
    end

    private

    def data
      # @statistics.data.keys.sort_by { |k| @statistics.data[k].size }.reverse
      @statistics.data.keys.sort_by(&:to_s)
    end
  end
end
