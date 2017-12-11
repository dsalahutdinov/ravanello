# frozen_string_literal: true

require 'yaml'

RSpec.describe Ravanello::Yaml do
  let(:router) do
    described_class.new(File.read('spec/fixtures/rules.yml')).call
  end

  it 'should load properly' do
    expect(router.root).not_to be_nil

    rules = router.root.children.map(&:regex)
    expect(rules).to eq [
      'resque',
      'denormalized',
      'companies',
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
