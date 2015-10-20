#kata11
require 'pry'

class Sort
  attr_accessor :list

  def initialize
    @list = Array.new
  end
  
  def sort_str(str)
    s = str.downcase.scan(/\w/)
    s.each { |e| add(e) }
    @list
  end

  private
  def add(n)
    index = @list.index { |i| i >= n }
    index ||= @list.length
    @list.insert(index, n)
  end
end

a = Sort.new
p a.sort_str('This ,,, is fucking AWESOME!').join
# binding.pry