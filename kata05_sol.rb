require "digest/md5"

class SpellChecker
  # num_bits is how many bits the hash function should produce.
  def initialize(dictionary_name, num_bits)
    @num_bits = num_bits
    @bitmap = []
    load_dictionary(dictionary_name)
  end

  # Returns true if the word is a real word. False otherwise.
  def check(word)
    bloom_filter(word).inject(true) { |is_real, i| is_real && @bitmap[i] }
  end

  private

  # Takes a word and generates an array of indices.
  def bloom_filter(word)
    # Generate the digest then translate it to binary.
    binary = Digest::MD5.hexdigest(word).to_i(16).to_s(2)
    # Grab arbitrary sections to generate a number.
    [10, 43, 81].map do |i|
      binary.slice(i, @num_bits).to_i(2)
    end
  end

  # Loads the given dictionary and uses the bloom filter to fill out the
  # bitmap.
  def load_dictionary(filename)
    File.open(filename, "r").each_line do |line|
      bloom_filter(line.strip).each do |i|
        @bitmap[i] = true
      end
    end
  end
end

checker = SpellChecker.new("/usr/share/dict/words", 20)
while true
  print "Type in a word (q to quit): "
  word = gets.strip
  break if word == "q"
  print ">>> #{word} is #{checker.check(word) ? "" : "NOT "}a word\n"
end