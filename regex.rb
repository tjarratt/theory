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

  string.chars.each do |c|
    if c == escape_char
      previous = escape_char
      escape_char = expression.shift
    elsif escape_char == '.'
      previous = escape_char
      escape_char = expression.shift
    elsif escape_char == '*' # check for zero or more
      if previous == c || previous == '.'
        match_count += 1
        next
      else
        match_count = 0
        previous = nil
        escape_char = expression.shift
      end
    elsif escape_char == '+' # check for one or more
      if previous == c || previous == '.'
        match_count += 1
        next
      else
        if match_count > 0
          match_count = 0
          previous = nil
          escape_char = expression.shift
        else
          return false
        end
      end
    else
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
puts match?('abc', 'abc')
puts match?('a..', 'abc')
puts match?('a*', 'aaa')
puts match?('aa+', 'aaa')
puts match?('a.*', 'abc')
puts match?('.*g', 'abcdefg')
puts match?('a.*', 'abcdefg')
puts match?(".*", "")

# from glass door
puts match?("abc", "abc")
puts match?("a+b+c+", "abc")
puts match?("a*b*c*", "abc")
puts match?("abc*", "abc")
puts match?("a..", "abc")
puts match?("...", "abc")
puts match?("abcf*h", "abcffffffffffh")
puts match?("abcf?e", "abce")
puts match?("abcf*", "abc")
puts match?("a*b*c*e+f+g+", "efg")


puts "\nshould fail"
puts match?('abc', 'aaa')
puts match?('+jkdljkd', 'aaa')
puts match?(".+", "")

# from glass door
puts match?("def", "abc")
puts match?("d+ef", "abc")
puts match?("d*ef", "abc")
puts match?("acdf+", "abc")
puts match?("abcf*", "abcffffffffffh")
puts match?("a*b*c*e+f+g+", "ef")

puts "\n\nend\n\n\n"
