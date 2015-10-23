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
  attr_accessor :nodes, :head

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

  	# if p.nil? && n then #delete head
  	#   @nodes[n].prev = nil
  	# elsif p && n.nil? then #delete tail
  	#   @nodes[p].next = nil
  	# else
  	#   @nodes[n].prev = prev
  	#   @nodes[p].next = _next
  	# end
  	# @nodes[c].prev, @nodes[c].data, @nodes[c].next = nil, nil, nil
  	return nil
  end

  def find(data)
    c = traverse(data)
    return (c ? c : nil)
  end

  def values(n=nil)
  	return @head.nodes()
  end

  private

  def traverse(find=nil)
    if @head then
      current = @head
      while current.next do
        _next = current.next
        find ? ((current.data == find) ? (return current) : 
          ( (_next.data == find) ? (return _next) : nil ) ) : nil
        current = current.next
      end
      return (find ? nil : current)
    else
      return nil
    end
  end

end
