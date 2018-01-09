require 'spec_helper'

RSpec.describe YAMLConverter do
  let(:result_file) { fixture_file('output', 'translations.yml') }
  let(:result) { YAML.load_file(result_file) }
  let(:convert) { described_class.convert(simple_file, result_file) }
  let(:expected_result) { YAML.load_file(fixture_file('expected_result.yml')) }

  context 'with valid data' do
    let(:simple_file) { fixture_file('translations_simple.yml') }

    it 'transforms file content from simple format and saves into resulting yml file' do
      convert
      expect(result).to eql(expected_result)
    end
  end

  context 'with invalid data' do
    context 'empty file' do
      let(:simple_file) { fixture_file('empty.yml') }

      it 'raises an exception when input file is empty' do
        expect { convert }.to raise_error(ArgumentError, "Input shouldn't be empty")
      end
    end

    context 'conflict keys' do
      let(:simple_file) { fixture_file('translations_simple_with_conflict_keys.yml') }

      it 'overrides conflict keys' do
        convert
        expect(result).to eql(expected_result)
      end
    end

    context 'some empty lines' do
      let(:simple_file) { fixture_file('translations_simple_with_some_empty_lines.yml') }

      it 'tolerates empty lines in input data' do
        convert
        expect(result).to eql(expected_result)
      end
    end

    context 'invalid format' do
      let(:simple_file) { fixture_file('translations_simple_with_invalid_content.yml') }

      it 'raises error when input data contains lines with invalid content' do
        expect { convert }.to raise_error Psych::SyntaxError
      end
    end
  end
end
