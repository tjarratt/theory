# string, string
# eg: "a*b", "aaab" => true
# eg: "a*b", "b" => true
# eg: "a+b", "b" => false
# regexp can contain *, + and .
def match?(expr, string)
  previous = nil
  expression = expr.chars.to_a
  escape_char = expression.shift
  return false if escape_char == '+' #invalid regexp

  match_count = 0
  # puts "matching #{string} against #{expr}"

  index = 0
  while index < string.size
    c = string[index]
    # puts "at char #{c} with match count #{match_count}"
    # puts "comparing #{c} to #{escape_char}"

    if c == escape_char
      index += 1
      match_count += 1
      previous = escape_char
      escape_char = expression.shift
    elsif escape_char == '.'
      index += 1
      match_count += 1
      previous = escape_char
      escape_char = expression.shift
    elsif escape_char == '*' # check for zero or more
      if previous == c || previous == '.'
        index += 1
        match_count += 1
      else
        index += 1
        match_count = 0
        previous = nil
        escape_char = expression.shift
      end
    elsif escape_char == '+' # check for one or more
      if previous == c || previous == '.'
        index += 1
        match_count += 1
        # puts "in +, incremented  match count to #{match_count}"
      else
        if match_count > 0
          # puts "end of match with prev #{previous} and escape_char #{escape_char}"
          match_count = 0
          previous = nil
          escape_char = expression.shift
          # puts "now previous is nil and escape_char is #{escape_char}"
        else
          # puts "returning false with escape char +"
          # puts "char: #{c}"
          # puts "previous: #{previous}"
          return false
        end
      end
    else
      # puts "returning false because #{c} != #{escape_char}"
      return false
    end
  end

  if string.empty?
    unless expr == '.*' || expr == '*'
      return false
    end
  end

  return true
end

puts "should pass:"
# puts match?('abc', 'abc')
# puts match?('a..', 'abc')
# puts match?('a*', 'aaa')
# puts match?('aa+', 'aaa')
# puts match?('a.*', 'abc')
# puts match?('.*g', 'abcdefg')
# puts match?('a.*', 'abcdefg')
# puts match?(".*", "")

# from glass door
puts match?("a+b+c+", "abc")
puts match?("a*b*c*", "abc")
# puts match?("abc*", "abc")
# puts match?("a..", "abc")
# puts match?("...", "abc")
puts match?("abcf*h", "abcffffffffffh")
puts match?("abcf?e", "abce")
puts match?("abcf*", "abc")
puts match?("a*b*c*e+f+g+", "efg")


puts "\nshould fail"
puts match?('abc', 'aaa')
puts match?('+jkdljkd', 'aaa')
puts match?(".+", "")

# # from glass door
puts match?("def", "abc")
puts match?("d+ef", "abc")
# puts match?("d*ef", "abc")
# puts match?("acdf+", "abc")
# puts match?("abcf*", "abcffffffffffh")
# puts match?("a*b*c*e+f+g+", "ef")

puts "\n\nend\n\n\n"
