# frozen_string_literal: true

RSpec.describe Ravanello::Routing::Match do
  describe 'routes' do
    let(:path_parts) { %w[resque delayed] }
    let(:root) { Ravanello::Routing::Root.new }
    let(:namespace) { described_class.new('resque', root) }

    it do
      expect(namespace.routes?(path_parts)).to eq true
      expect(namespace.route(path_parts)).to eq ['delayed']
    end
  end
end
