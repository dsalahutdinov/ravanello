# frozen_string_literal: true

RSpec.describe Ravanello::Routing::Root do
  describe 'routes' do
    let(:path_parts) { %w[resque delayed] }
    let(:root) { described_class.new }

    it do
      expect(root.routable?(path_parts)).to eq true
      expect(root.route(path_parts)).to eq path_parts
    end
  end
end
