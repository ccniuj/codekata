#kata05

require 'digest'
require 'pry'

#Output 3 numbers to map to a bit array
def bloom_filter(msg, length)
  md5 = Digest::MD5.new
  md5.update msg
  m = md5.hexdigest.to_i(16).to_s(2)  #hex=>dec=>binary

  [12, 52, 102].map do |i|
    m.slice(i, length).to_i(2)
  end
end

@bitmap = []
@bit_length = 4
#1. Load the dictionary and apply the bloom filter
def load_dic(path)
  File.open(path, "r") do |f|
    f.each_line do |line|
      bloom_filter(line.strip, @bit_length).map do |i| #Need to remove \n
        @bitmap[i] = true
        # binding.pry
      end
    end
  end
end

def check(word)
  # bloom_filter(word, @length).inject(true) { |is_real, i| is_real && @bitmap[i] }
  bloom_filter(word, @bit_length).map do |i|
    return false if !@bitmap[i]
  end
  # @bitmap.zip(bloom_filter(word, 20)).map {|x, y| x.nil? & y}
  #a = load_dic('test.dat').zip(bloom_filter(word).split(//)).map {|x, y| x == '1' and y == '1'}
  return true
end

load_dic('/usr/share/dict/words')

while 1
  puts 'Type a word (type "q" to exit):'
  w = gets.strip
  break if w == 'q'
  puts w + ' is' + (check(w) ? '' : ' not') + ' in the dictionary'
end
