# frozen_string_literal: true

RSpec.describe Ravanello::Resolver do
  let(:resolver) { described_class.new(router) }
  let(:router) do
    Ravanello::Router.new do
      match :resque do
        match 'resque-retry' do
          match '[0-9]+'
        end
      end
    end
  end

  it do
    expect(resolver.call('resque:resque-retry:654')).not_to be_nil
    expect { resolver.call('resque:resque-retry:-unknown') }.to(
      raise_error Ravanello::Resolver::Error
    )
  end
end
