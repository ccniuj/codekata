#kata06
require 'pry'

def load_dic
  @anagram = {}
  File.open('/usr/share/dict/words', 'r') do |f|
    f.each_line do |line|
      line = line.strip.downcase
      sorted_word = line.gsub(/[^a-z0-9]/, '').chars.sort.join
      @anagram[sorted_word] ||= []  # initialize the value to emrty array if the key does not exist
      @anagram[sorted_word].push(line)
    end
  end
  @anagram
end

load_dic


@max_key, @max_value = '', 0
@anagram.each {|k, v|
  # puts v.join(' / ')
  if @max_value < v.length then 
    @max_value = v.length
    @max_key = k
  end  
}
puts 'The longest set of anagram:'
puts @anagram[@max_key].join(' / ')
