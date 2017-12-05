# rubocop:disable BlockLength
# frozen_string_literal: true

require 'redis'

RSpec.describe Ravanello::Redis::Cursor do
  let(:redis) { Redis.new(url: ENV['REDIS']) }
  before { redis.flushall }
  after { redis.flushall }

  describe 'Enumerable' do
    let(:test_data) do
      {
        'key1' => 123,
        'key2' => 'hello',
        'key3' => ''
      }
    end

    context 'scan without limit' do
      let(:cursor) { Ravanello::Redis::Cursor.new(redis) }

      it do
        test_data.each { |key, data| redis.set key, data }

        expect(cursor.map(&:name)).to match_array %w[key1 key2 key3]
        expect(cursor.map(&:size)).to match_array [1, 6, 2]
      end
    end

    context 'scan with limit' do
      let(:cursor) { Ravanello::Redis::Cursor.new(redis, limit: 100) }

      context 'redis has more keys than passed limit' do
        it do
          (1..111).to_a.each { |i| redis.set i.to_s, i }

          expect(cursor.to_a.size).to eq 100
        end
      end

      context 'redis has less keys than passed limit' do
        it do
          (1..90).to_a.each { |i| redis.set i.to_s, i }

          expect(cursor.to_a.size).to eq 90
        end
      end
    end
  end
end
