#kata21

require 'pry'

class Node
  attr_accessor :data, :prev, :next

  def initialize(data, prev, _next=nil)
  	@data = data
  	@prev = prev
  	@next = _next
  end

  def value(data=nil)
  	@data
  end

  def nodes(n=nil)
  	n ||= 1
  	if @next then
  	  ary = @next.nodes(n+1)
  	  ary[n-1] = @data
  	  return ary
  	else
  	  v ||= []
  	  v[n-1] = @data
  	  return v
  	end
  end
end

class List
  attr_accessor :head

  def initialize(data=nil)
    @head = Node.new(data) if data
  end

  def add(data)
    c = traverse
    c ? (c.next = Node.new(data, c)) : (@head = Node.new(data, nil))
  end

  def delete(node)
    d = find(node.data)

    if d.prev == nil then #delete head
      @head = d.next
    elsif d.next == nil then #delete tail
      d.prev.next = nil
    else
      prev = d.prev
      _next = d.next
      prev.next = _next
      _next.prev = prev
    end

  	return nil
  end

  def find(data)
    c = traverse(data)
    return (c ? c : nil)
  end

  def values(n=nil)
    @head ? ( return @head.nodes() ) : []
  end

  private

  def traverse(find=nil)
    if @head then
      current = @head
      while current.next do
        find ? ( (current.data == find) ? (return current) : nil ): nil
        current = current.next
      end
      find ? ( (current.data == find) ? (return current) : nil ) : nil
      return (find ? nil : current)
    else
      return nil
    end
  end

end

# l = List.new
# l.add('a')
# p l.find('a')
# p l.values()
# l.delete(l.find('a'))
# p l.find('a')
# p l.values()
# l.add('b')
# p l.find('b')
# p l.values()