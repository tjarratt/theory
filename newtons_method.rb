#!/usr/bin/env ruby

puts "I will calculate the square root of any number (to some degree of accuracy)"
puts "What number would you like the root of? (Integer, decimal is okay)"
n = gets.strip.to_f

# f(x) = x^2 - n => find the roots of (x^2 = n)
# f'(x) = 2x
# by newton's method, iterate with x(i) = x(i - 1) - f(x(i-1)) / f'(x(i-1))

# reasonable guess, but clearly very wrong for n > 2
next_guess = 0
guess = n / 2
100.times do
  next_guess = guess - ( (guess**2 - n) / (2 * guess))
  break if next_guess == guess
  guess = next_guess
end

puts "The square root should be around #{next_guess}"
