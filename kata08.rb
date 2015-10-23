#kata08
require 'pry'
require './kata05.rb'

@checker = WordChecker.new('/usr/share/dict/words', 20)
@words = []
@composition_of_word = {}
@word_length = 6

def load_dic_of_fixed_length(path, length)
  File.open(path, 'r') do |f|
    f.each_line do |line|
      line.strip!
      @words << line if line.length == length
    end
  end
  @words
end

def composition_checker(word, length)
  # divide into 2 subsets
  (1..length-1).each do |i|
    w1 = word.chars.first(i).join
    w2 = word.chars.last(length - i).join
    if @checker.check(w1) and @checker.check(w2) then
      @composition_of_word[word] ||= []
      @composition_of_word[word].push([w1, w2])
    end
  end
  @composition_of_word
end

load_dic_of_fixed_length('/usr/share/dict/words', @word_length)

@words.each do |word|
  composition_checker(word, @word_length)
end

@composition_of_word.each do |k, v|
  vsum = ''
  v.each do |i|
    vsum << i.join(' + ') + ', '
  end
  puts k + ': ' + vsum
end

binding.pry
