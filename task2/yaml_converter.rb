require 'yaml'

module YAMLConverter
  class << self
    def convert(simple_file, result_file)
      simple_hash = YAML.load_file(simple_file)
      raise ArgumentError, "Input shouldn't be empty" unless simple_hash
      result = convert_to_nested(simple_hash)
      File.open(result_file, 'w') do |f|
        f.write(result.to_yaml)
      end
    end

    private

    def convert_to_nested(simple_hash)
      simple_hash.each_with_object({}) do |(key, value), result|
        keys = key.split('.')
        last_idx = keys.size - 1
        h = result
        keys.each_with_index do |k, idx|
          h[k] = {} unless h[k].is_a?(Hash)
          if idx != last_idx
            h = h[k]
          else
            h[k] = value
          end
        end
      end
    end
  end
end
