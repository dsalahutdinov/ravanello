# frozen_string_literal: true

RSpec.describe Ravanello::Resolver do
  let(:resolver) { described_class.new(router) }
  let(:router) do
    Ravanello::Router.new do
      namespace :resque do
        namespace :retry do
          match '[0-9]+'
        end
      end
    end
  end

  it do
    expect(resolver.resolve('resque:retry:654')).not_to be_nil

    r = resolver.resolve('resque:retry:-unknown')
    expect(r).to be_nil
  end
end
