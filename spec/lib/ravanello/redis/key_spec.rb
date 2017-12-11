# frozen_string_literal: true

RSpec.describe Ravanello::Redis::Key do
  let(:key) { described_class.new('key', 123) }

  it do
    expect(key.name).to eq 'key'
    expect(key.size).to eq 123
  end
end
