class Anagram
  attr_reader :letters

  def initialize(word)
    @word = word
    # letters is a count of each letter in the word.
    @letters = {}
    @word.each_char do |l|
      @letters[l] ||= 0
      @letters[l] += 1
    end
  end

  def each(&block)
    each_anagram("", @letters.clone, &block)
  end

  private

  def each_anagram(word, letters, &block)
    if letters.empty?
      # If there are no more letters, we have our final anagram word.
      yield(word)
    else
      # If there are still letters, go through each one and build an anagram
      # from it.
      letters.keys.each do |letter|
        # Add the letter to the word.
        w = word.clone
        w += letter.to_s
        # Prepare the next set of letters by removing the used up letter.
        ls = letters.clone
        ls[letter] -= 1
        ls.delete(letter) if ls[letter] == 0
        # Continue onto the next letter.
        each_anagram(w, ls, &block)
      end
    end
  end
end

# Get a dictionary to check potential anagrams against.
# I could use the bloom filter spell checker created in Code Kata 6, but I
# went for simplicity instead.
dict = {}
File.open("/usr/share/dict/words", "r").each_line do |line|
  dict[line.strip!] = true
end

# Find anagrams of the following words.
%w(kinship enlist boaster fresher sinks knits rots).each do |word|
  anagrams = []
  Anagram.new(word).each do |anagram|
    anagrams.push(anagram) if dict[anagram]
  end
  puts anagrams.join(" ")
end