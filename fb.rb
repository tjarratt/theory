#!/usr/bin/env ruby

def sqrt(n)
  #x**2 = value
  # ergo f(x) = x**2 - value
  # solve newton's method for f(x) and f'(x) = 2x
  # iteration(n) = last_value - f(last_value) / f'(last_value)

  # start with a guess of value / 2
  ret = n.to_f / 2

  10.times do |i|
    puts "#{i}: ret is #{ret.inspect}"
    ret = ret - (ret**2 - n) / (2 * ret)
    puts "ret is now #{ret.inspect}"
  end

  return ret
end

puts "what value should we take the square root of?"
n = gets.chomp.to_i

puts sqrt(n)




# Write a function that takes 2 arguments: a binary tree and an integer N, it should return the N-th element in the inorder traversal of the binary tree. I asked the interviewer if I could use a 3rd argument to store the result; he said okay.

# recursively walk through tree, maybe? if not, define a walk_node_inorder function, decrementing count to N in there


#Determine the 10 most frequent words given a terabyte of strings.

# bloom filters ahoy, maybe map reduce?

# A string s is said to be unique if no two characters of s are same.
# A string s1 is producible from s2 by removing some of the characters from s2.
# A string s1 is said to be more beautiful than s2 if length of s1 is more than s2 or if both have same length and s1 is lexicographically greater than s2( ex: ba is more beautiful than ab)
# Input: is a string which can be of maximum 10^6 characters, you have to produce the most beautiful unique string out of the given string.

# recursively build up the string by picking the most beautiful character in the string each time, possibly sort the string ahead of time, too
# protip: use a set to store characters, so you don't need to worry about uniqueness
