# rubocop:disable LineLength
# frozen_string_literal: true

RSpec.describe Ravanello::Redis::Object do
  describe '#size' do
    let(:test_data) do
      {
        'Value at:0x7fa230e048d0 refcount:1 encoding:int serializedlength:5 lru:1512455 lru_seconds_idle:906271' => 5,
        'Value at:0x7fa61180fc70 refcount:2147483647 encoding:int serializedlength:2 lru:2418726 lru_seconds_idle:0' => 2,
        'Value at:0x7fa0c39172f0 refcount:1 encoding:int serializedlength:5 lru:1512455 lru_seconds_idle:906271' => 5,
        'Value at:0x7fa27fe37310 refcount:1 encoding:int serializedlength:5 lru:1512455 lru_seconds_idle:906271' => 5,
        'Value at:0x7fa065d137a0 refcount:1 encoding:int serializedlength:5 lru:1512455 lru_seconds_idle:906271' => 5,
        'Value at:0x7fa068034b80 refcount:1 encoding:int serializedlength:5 lru:1512455 lru_seconds_idle:906271' => 5,
        'Value at:0x7fa15836add0 refcount:1 encoding:hashtable serializedlength:20 lru:1512455 lru_seconds_idle:906271' => 20,
        'Value at:0x7fa57014f660 refcount:1 encoding:hashtable serializedlength:20 lru:1898713 lru_seconds_idle:520013' => 20,
        'Value at:0x7fa1ef169ec0 refcount:1 encoding:ziplist serializedlength:53 lru:1512455 lru_seconds_idle:906271' => 53,
        'Value at:0x7fa3f47d03a0 refcount:1 encoding:embstr serializedlength:2 lru:1512455 lru_seconds_idle:906271' => 2
      }
    end

    context do
      it do
        test_data.each do |data, size|
          expect(described_class.new(data).size).to eq size
        end
      end
    end
  end
end
