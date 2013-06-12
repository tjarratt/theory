#!/usr/bin/env ruby

puts "I will tell you if a word is a palindrome, ignoring spaces"
puts "What is the word?"
word = gets.strip.gsub(/\s/, '')

# this is CHEATING
# palindromic = word == word.reverse

palindromic = true
pivot_point = word.size.to_f / 2
first_half = word[0..pivot_point.floor]
second_half = word[0..pivot_point.ceil]

first_half.split('').zip(second_half.split('')).each do |a, b|
  palindromic = false if a != b
end

if palindromic
  puts "Cool!, a palindrome!"
else
  puts "Not a palindrome, dude."
end
