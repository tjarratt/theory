#!/usr/bin/env ruby

def levenshtein(str1, str2)
  return str2.size if str1.size == 0
  return str1.size if str2.size == 0

  cost = 0
  if str1[-1] == str2[-1]
    cost = 0
  else
    cost += 1
  end

  return [
    levenshtein(str1.slice(0, str1.size - 1), str2) + 1,
    levenshtein(str1, str2.slice(0, str2.size - 1)) + 1,
    levenshtein(str1.slice(0, str1.size - 1), str2.slice(0, str2.size - 1)) + cost,
  ].min
end

puts "I will compute the Levenshtein distance between two strings for you now."
puts "What is the first string?"
first = gets.strip

puts "... and the second string?"
second = gets.strip

distance = levenshtein(first, second)

puts "The Levenshtein distance between #{first} and #{second} is #{distance}"
