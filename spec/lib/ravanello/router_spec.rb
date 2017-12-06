# rubocop:disable BlockLength
# frozen_string_literal: true

RSpec.describe Ravanello::Router do
  context 'tree with namespace' do
    let(:router) do
      Ravanello::Router.new do
        match :resque do
          match 'resque-retry'
        end
      end
    end

    it do
      resque_namespace = router.root.children.first
      expect(resque_namespace.regex).to eq 'resque'

      retry_namespace = resque_namespace.children.first
      expect(retry_namespace.regex).to eq 'resque-retry'
    end
  end

  context 'tree with match' do
    let(:router) do
      Ravanello::Router.new do
        match :resque do
          match '[0-9]'
        end
      end
    end
    it do
      resque_namespace = router.root.children.first
      expect(resque_namespace.regex).to eq 'resque'

      match_namespace = resque_namespace.children.first
      expect(match_namespace.regex).to eq '[0-9]'
    end
  end
end
