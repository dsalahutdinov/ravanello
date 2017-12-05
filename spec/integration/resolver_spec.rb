# rubocop:disable BlockLength
# frozen_string_literal: true

RSpec.describe Ravanello do
  let(:resolver) { Ravanello::Resolver.new(router) }
  let(:router) do
    Ravanello::Router.new do
      namespace :mail_deliveries
      namespace :seealso_stat
      namespace :denormalization do
        namespace :users do
          match '[0-9]+'
        end
        namespace :companies do
          match '[0-9]+'
        end
        namespace :orders do
          match '[0-9]+'
        end
        namespace :tenders do
          match '[0-9]+'
        end
        namespace :company_statistics
        match '*'
      end
      namespace :resque do
        namespace :delayed
        namespace 'resque-retry'
        namespace 'timestamps'
        namespace :lock
        namespace :meta
      end

      namespace :companies do
        namespace :domains
        namespace :current
        match '*'
      end
      namespace :models do
        namespace :apress
        match '*'
      end
      namespace 'Redis'
      namespace :RedisSiteRedirect
      namespace :RedisRedirect
      namespace 'offer_statistics'
      match 'showcase_order_*'
      single
      match '*'
    end
  end
  let(:data) do
    filename = File.expand_path('spec/fixtures/redis_keys.yml')
    lines = File.read(filename).split("\n")
    lines.map { |key| Ravanello::Redis::Key.new(key, 1) }
  end

  it do
    statistics = Ravanello::Analyzer.new(router, data).call
    Ravanello::Formatter.new(statistics).call.each do |line|
      puts line
    end
  end
end
