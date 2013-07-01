#!/usr/bin/env ruby

load 'binary_tree.rb'

def assert_equal(first, second)
  unless first == second
    raise RuntimeError.new("#{first} is not equal to #{second}")
  end
end

# this will go ALL THE WAY DOWN to the left, and then back up and handle the
# child nodes on the right, basically going down and left and then up and right
def depth_traversal(node, &block)
  yield node.value # print the current block

  # recurse down to the left child
  depth_traversal(node.left, &block) if node.left

  # recurse down to the right child
  depth_traversal(node.right, &block) if node.right
end

# this will print out all of the nodes in the order they are
# in terms of depth in the tree : eg, all nodes 1 deep, all nodes 2 deep, etc
def breadth_traversal(top_node)
  # start with the first nodes
  nodes = [top_node]
  nodes_to_iterate = [top_node]

  # while we have more nodes to print
  while (!nodes_to_iterate.empty?)
    next_nodes = [] # start with an empty list
    # for each node we iterate over in this, find their children
    nodes_to_iterate.each do |n|
      # add the next nodes we iterate
      next_nodes.concat(n.children)
    end

    #
    nodes.concat(next_nodes)
    nodes_to_iterate = next_nodes
  end

  # print them out in order
  # nb: (this could be a nested structure so you could print out
  #      each row on a separate line, which might be cool)
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
