# frozen_string_literal: true

RSpec.describe Ravanello::Routing::Namespace do
  describe 'routes' do
    let(:path_parts) { %w[resque delayed] }
    let(:root) { Ravanello::Routing::Root.new }

    it 'matches the same path part' do
      namespace = described_class.new('resque', root)

      expect(namespace.routes?(path_parts)).to eq true
      expect(namespace.route(path_parts)).to eq ['delayed']
    end

    it 'does not matches different namespace' do
      namespace = described_class.new('unknown', root)

      expect(namespace.routes?(path_parts)).to eq false
      expect(namespace.route(path_parts)).to eq path_parts
    end
  end
end
