require_relative 'shrinker'
RSpec.configure do |config|
  config.formatter = :documentation
end

describe 'Test Shrinker module' do
  context 'with valid data' do
    it "shrinks ['cat', 'cat', 'dog', 'dog', 'dog'] to ['cat', 'cat', 'dog (3)']" do
      input_array = %w[cat cat dog dog dog]
      expect(Shrinker.process(input_array)).to eq(%w[cat cat dog\ (3)])
    end

    it "shrinks ['cat', 'cat', 'dog', 'dog', 'dog', 'cat', 'cat', 'cat', 'cat'] to ['cat (6)', 'dog (3)']" do
      input_array = %w[cat cat dog dog dog cat cat cat cat]
      expect(Shrinker.process(input_array)).to eq(%w[cat\ (6) dog\ (3)])
    end
  end

  context 'with invalid data' do
    it 'raises ArgumentError if input is not of type Array' do
      input_array = "It's not an Array"
      expect { Shrinker.process(input_array) }.to raise_error(ArgumentError, 'Expect argument to be an array')
    end

    it 'tolerates empty array as input' do
      input_array = []
      expect(Shrinker.process(input_array)).to eq([])
    end

    it 'tolerates any data type inside input array' do
      input_array = ['cat', 'cat', 'dog', 'dog', 'dog', 1, { key: 'value' }, [], nil]
      expect(Shrinker.process(input_array)).to eq(['cat', 'cat', 'dog (3)', 1, { key: 'value' }, [], nil])
    end

    it 'tolerates empty words at input' do
      input_array = ['', '', '', 'dog', 'dog', 'dog']
      expect(Shrinker.process(input_array)).to eq(%w[\ (3) dog\ (3)])
    end
  end
end
