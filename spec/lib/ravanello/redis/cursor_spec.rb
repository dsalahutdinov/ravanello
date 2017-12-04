# frozen_string_literal: true

RSpec.describe Ravanello::Redis::Cursor do
  describe '#size' do
    context do
      it do
        require 'redis'
        redis = Redis.new(url: ENV['REDIS'])
        redis.set 'foo', Oj.dump([1, 2, 3])
        redis.set 'bar', 12
        redis.set 'hey', 'you'
        cursor = Ravanello::Redis::Cursor.new(redis)

        expect(cursor.map(&:name)).to match_array %w[foo bar hey]
      end
    end
  end
end
