# frozen_string_literal: true

RSpec.describe Ravanello::Statistics do
  let(:statistics) { described_class.new }

  describe '#append' do
    it do
      statistics.append('path1', Ravanello::Redis::Key.new('k1', 100))
      statistics.append('path2', Ravanello::Redis::Key.new('k2', 200))

      expect(statistics.data.count).to eq 2
      expect(statistics.data.values.first.samples.count).to eq 1
    end

    it 'do not overlimit samples' do
      101.times do
        statistics.append('path1', Ravanello::Redis::Key.new('k1', 100))
      end

      expect(statistics.data['path1'].samples.count).to eq 100
    end
  end
end
