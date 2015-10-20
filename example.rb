class A
  def self.b
    b = new()
    b.c
  end

  def c
    puts 'instance method!!'
  end
end

A.b
A.singleton_class