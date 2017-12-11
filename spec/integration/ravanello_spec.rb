# frozen_string_literal: true

require 'yaml'
RSpec.describe Ravanello do
  describe './ravanello' do
    let(:redis) { Redis.new(url: ENV['REDIS']) }
    let(:yaml) { YAML.safe_load(File.read('spec/fixtures/keys.yml')) }

    before do
      redis.flushall
      yaml['fixtures']['keys'].each { |key| redis.set key, 'value' }
    end
    after { redis.flushall }

    it do
      formatted = `./bin/ravanello analyze --rules "spec/fixtures/rules.yml"`

      expect(formatted).to include 'denormalized:companies:*'
      expect(formatted).to include 'denormalized:orders:*'
      expect(formatted).to include 'denormalized:users:*'
      expect(formatted).to include 'resque:resque-retry:*'
      expect(formatted).to include 'resque:delayed:*'
      expect(formatted).to include 'resque:timestamps:*'
    end
  end
end
