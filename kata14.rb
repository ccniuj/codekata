#kata14
require 'pry'

class Trigram
  attr_accessor :trigrams

  def initialize
    @trigrams = Hash.new{ |h, k| h[k] = [] }
  end

  def load(path)
    text = File.open(path, 'r').read
    text.each_sentence { |i|
      save_trigram(i)
    }
    # binding.pry
  end

  def generate_text
    sentence = String.new

    first_two_words = @trigrams.keys.sample
    sentence += first_two_words.join(' ')

    # binding.pry

    30.times { |i|
      word = @trigrams[first_two_words].sample
      if word.nil? then
        # binding.pry
        break
      else
        sentence += (' ' + word)
        first_two_words = [first_two_words[-1], word]
        # binding.pry
      end
    }
    # binding.pry
    sentence
  end

  private
  def save_trigram(sentence)
    words = sentence.split(' ')
    (0..words.length-3).each { |i|
      first_two_words = words[i, 2]
      last_word = words[i+2]
      @trigrams[first_two_words] << last_word
      @trigrams[first_two_words].uniq!
    }
  end
end

class String
  def each_sentence
    delimeters = %r(\.|!|\?|;)
    punctuations = %r('|"|,|\(|\))
    
    sentences = self.split(delimeters)
    sentences.each { |s|
      yield s.strip.gsub(punctuations, '')
    }
  end

end

t = Trigram.new
t.load('tom_swift.txt')
puts t.generate_text