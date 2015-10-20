#kata18
require 'pry'

class Dependency
  attr_accessor :dependencies

  def initialize
    @dependencies = Hash.new { |h,k| h[k] = [] }
  end

  def add_direct(obj, str_of_dependencies)
    @dependencies[obj] << str_of_dependencies.chars
    @dependencies[obj].flatten!.sort!.uniq!
  end

  # implementing BSD (Breadth-First-Search)
  def dependencies_for(obj)
    queue = [obj]
    transitives = []
    while queue.any?
      q = queue.pop
      @dependencies[q].each { |o|
        transitives << o
        queue.unshift(o)
        }
    end
    transitives.sort!.uniq
  end
end

d = Dependency.new
d.add_direct('A', 'BC')
d.add_direct('B', 'CE')
d.add_direct('C', 'G')
d.add_direct('D', 'AF')
d.add_direct('E', 'F')
d.add_direct('F', 'H')

p d.dependencies_for('A')
p d.dependencies_for('B')
p d.dependencies_for('C')
p d.dependencies_for('D')
p d.dependencies_for('E')
p d.dependencies_for('F')