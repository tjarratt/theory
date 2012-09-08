class Node
  attr_accessor :next
  attr_reader :value

  def initialize(v)
    @value = v
  end
end

class LinkedList
  attr_reader :root
  def initialize(nodes)
    @root = nodes.shift
    iter = @root
    while node = nodes.shift
      iter.next = node
      iter = node
    end
  end

  def walk
    node = @root
    puts node.value
    while node.next && node = node.next
      puts node.value
    end
  end
end

nodes = [1,2,3,4,5].map {|v| Node.new(v) }
ll = LinkedList.new(nodes)
puts "walking foward"
ll.walk

def reverse(list)
  a = []
  node = list.root
  while node = node.next
    n = node.clone
    n.next = a.first
    a.unshift(n)
  end

  last = list.root.clone
  last.next = nil
  a.push(last)
  LinkedList.new(a)
end

rl = reverse(ll)
puts "walking reverse"
rl.walk
