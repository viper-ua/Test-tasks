require 'yaml'

class YAMLConverter
  class << self
    def to_yml(simple_yaml)
      lines = simple_yaml.split("\n")
      parsed_hash = {}
      lines.each { |line| parsed_hash.merge!(YAML.safe_load(line) || {}) }
      final_hash = {}
      parsed_hash.each do |k, v|
        final_hash = merge_nested(final_hash, nest(k.split('.'), v))
      end
      puts YAML.dump(final_hash)[4..-1]
    end

    protected

    def nest(keys, value)
      return Hash[keys[0], value] if keys.length <= 1
      Hash[keys[0], nest(keys[1..-1], value)]
    end

    def merge_nested(h1, h2)
      merge_func = lambda do |oldval, newval|
        return merge_nested(oldval, newval) \
          if oldval.is_a?(Hash) && newval.is_a?(Hash)
        return oldval unless newval.is_a?(Hash)
        newval
      end

      h1.merge(h2) { |_, oldval, newval| merge_func.call(oldval, newval) }
    end
  end
end
