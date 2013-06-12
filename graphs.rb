#!/usr/bin/env ruby

load 'binary_tree.rb'

def assert_equal(first, second)
  unless first == second
    raise RuntimeError.new("#{first} is not equal to #{second}")
  end
end

def depth_traversal(node, &block)
  yield node.value
  depth_traversal(node.left, &block) if node.left
  depth_traversal(node.right, &block) if node.right
end

def breadth_traversal(top_node)
  nodes = [top_node]
  nodes_to_iterate = [top_node]

  while (!nodes_to_iterate.empty?)
    puts "iterating over: #{nodes_to_iterate.size} nodes"

    next_nodes = []
    nodes_to_iterate.each do |n|
      puts "looking at the children of node #{n.value}"
      childs = n.children.reject(&:nil?)

      next_nodes.concat(childs)
    end

    puts "adding these nodes: #{next_nodes.map(&:value).inspect}"

    nodes.concat(next_nodes)
    nodes_to_iterate = next_nodes
  end

  nodes.each {|n| yield n.value }
end

# testing this code below, making sure traversal works as expected
tree = Node.new(1,
  [2,
    [3,
      [4,
        [5], [6]
      ]
    ],
  ],
  [7,
    [8], [9]
  ]
)

puts "depth"
depth_nodes = [].tap do |a|
  depth_traversal(tree) {|n| a << n }
end

breadth_nodes = [].tap do |a|
  breadth_traversal(tree) {|n| a << n }
end

assert_equal( [1, 2, 3, 4, 5, 6, 7, 8, 9], depth_nodes )
assert_equal( [1, 2, 7, 3, 8, 9, 4, 5, 6], breadth_nodes )
