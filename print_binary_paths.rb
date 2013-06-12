#!/usr/bin/env ruby

load 'binary_tree.rb'

def print_all_paths(node, ancestors=[])
  if node.children.empty?
    puts [*ancestors, node.value].join(', ')
  else
    node.children.each do |child|
      print_all_paths(child, [*ancestors, node.value])
    end
  end
end

a_random_tree = Node.new(1,
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

print_all_paths(a_random_tree)
