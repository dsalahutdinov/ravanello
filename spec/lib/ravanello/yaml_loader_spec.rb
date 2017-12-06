# rubocop:disable BlockLength
# frozen_string_literal: true

require 'yaml'

RSpec.describe Ravanello::YamlLoader do
  let(:router) do
    described_class.new(File.read('spec/fixtures/rules.yml')).call
  end

  it 'should load properly' do
    expect(router.root).not_to be_nil

    rules = router.root.children.map(&:regex)
    expect(rules).to eq [
      'resque',
      'company_statistics',
      'denormalization',
      'companies',
      'models',
      'Redis',
      'RedisSiteRedirect',
      'RedisRedirect',
      'showcase_order_*',
      'mail_deliveries',
      'seealso_stat',
      '*'
    ]

    resque = router.root.children.find { |s| s.regex == 'resque' }
    resque_rules = resque.children.map(&:regex)
    expect(resque_rules).to eq [
      'delayed',
      'resque-retry',
      'timestamps',
      'lock',
      'meta',
      '*'
    ]
  end
end
