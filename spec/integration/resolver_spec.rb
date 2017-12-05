# rubocop:disable BlockLength
# frozen_string_literal: true

RSpec.describe Ravanello do
  let(:resolver) { Ravanello::Resolver.new(router) }
  let(:router) do
    Ravanello::Router.new do
      namespace :mail_deliveries do
        match '*'
      end
      namespace :seealso_stat do
        match '*'
      end
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
        namespace :company_statistics do
          match '*'
        end
        match '*'
      end
      namespace :resque do
        namespace :delayed do
          match '[0-9]+'
        end
        namespace 'resque-retry' do
          match '*'
        end
        namespace 'timestamps' do
          match '*'
        end
        namespace :lock do
          match '*'
        end
        namespace :meta do
          match '*'
        end
      end

      namespace :companies do
        namespace :domains do
          match '*'
        end
        namespace :current do
          match '*'
        end
        match '*'
      end
      namespace :models do
        namespace :apress do
          match '*'
        end
        match '*'
      end
      namespace "Redis" do
        match '*'
      end
      namespace :RedisSiteRedirect do
        match '*'
      end
      namespace :RedisRedirect do
        match '*'
      end
      namespace 'offer_statistics' do
        match '*'
      end
      match 'showcase_order_*'
      single
      match '*'
    end
  end
  let(:data) do
    filename = File.expand_path('spec/fixtures/redis_keys.yml')
    lines = File.read(filename).split("\n")
    lines.map do |key|
      Ravanello::Redis::Key.new(key, double(size: 1))
    end
  end

  it do
    analyzer = Ravanello::Analyzer.new(router, data)
    analyzer.call

    Ravanello::Formatter.new(analyzer).call
  end
end
