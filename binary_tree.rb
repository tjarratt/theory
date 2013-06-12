class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = [], right = [])
    @value = value
    @left = Node.new(*left) unless left.empty?
    @right = Node.new(*right) unless right.empty?
  end

  def children
    [left, right].reject(&:nil?)
  end
end
