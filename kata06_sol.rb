module Anagrams
  def find(filename)
    anagrams = {}
    File.open(filename, "r").each_line do |line|
      line.strip!
      # Use the sorted letters of the word to form the key.
      # All anagrams will have the same sorted word.
      # Remember to downcase and remove non-alphanumeric characters.
      sorted_word = line.downcase.gsub(/[^a-z0-9]/, "").chars.sort.join
      anagrams[sorted_word] ||= []
      anagrams[sorted_word].push(line)
    end
    anagrams
  end
end

include Anagrams

File.open("anagrams.txt", "w") do |f|
  find("wordlist.txt").each do |digest, anagrams|
    if anagrams.length > 1
      f.write anagrams.join(" ")
      f.write "\n"
    end
  end
end
Raw