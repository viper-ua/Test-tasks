module Shrinker
  class << self
    def process(input_arr)
      raise ArgumentError, 'Expect argument to be an array' unless input_arr.is_a?(Array)
      input_arr.each_with_object(Hash.new(0)) { |w, h| h[w] += 1 }
               .each_with_object([]) do |(word, count), result|
        count > 2 ? result << "#{word} (#{count})" : result.concat(Array.new(count, word))
      end
    end
  end
end
