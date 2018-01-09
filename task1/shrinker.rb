module Shrinker
  class << self
    def process(input_arr)
      raise ArgumentError, 'Expect argument to be an array' unless input_arr.is_a?(Array)
      word, count = nil, 0
      input_arr.each_with_object([]) do |item, res|
        if word == item
          count += 1
        else
          res.concat(shrink_word(word, count))
          word, count = item, 1
        end
      end
      .concat(shrink_word(word, count))
    end

    private

    def shrink_word(word, count)
      return ["#{word} (#{count})"] if count > 2
      Array.new(count, word)
    end
  end
end
