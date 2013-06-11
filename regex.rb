#!/usr/bin/env ruby

class TJRegex
  # match? -> an implemention of matching input against a regex
  # args (string, string)
  # eg: "a*b", "aaab" => true
  # eg: "a*b", "b" => true
  # eg: "a+b", "b" => false
  # (regexp can contain *, +, . and [A-Za-z0-9])
  def self.match?(expression, string)
    regex = parse_regex(expression)
    regex.each do |operator|
      # puts operator.inspect
      # puts string.inspect
      unless (substring = operator.(string))
        return false
      else
        string = substring
      end
    end

    return true
  end

  private
  def self.regex_operators
    @regex_operators ||= regex_operators = ['*', '+']
  end

  def self.checks_matching_char(substring, char)
    # puts "comparing #{substring[0]} to #{char}"
    if char == '.' || substring[0] == char
      return substring[1, substring.size]
    end

    return false
  end

  def self.new_star_proc(character)
    return proc do |str|
      matches = true
      substring = str.clone
      matches_proc = new_matching_proc(character)

      while matches do
        if matches = matches_proc.(substring, character)
          str = substring
          substring = matches
          # puts "substring is now #{substring}"
        end
      end

      # puts "returning #{str.inspect}"
      str
    end
  end

  def self.new_plus_proc(character)
    return proc do |substring|
      matches = true
      matches_proc = new_matching_proc(character)
      substring = matches_proc.(substring, character)

      while substring && matches
        matches = matches_proc.(substring, character)
        substring = matches if matches
      end

      substring
    end
  end

  # takes a given regex expression string and turns it into an
  # array of operators to run on the string
  def self.parse_regex(expression)
    # valid regex can't start with * or +
    return [proc { false } ] if regex_operators.include?(expression[0])

    regex = []
    index = 0
    while index < expression.size do
      char = expression[index]
      next_char = expression[index + 1]

      if regex_operators.include?(next_char)
        index += 1

        if next_char == '*'
          regex << new_star_proc(char)
        elsif next_char == '+'
          regex << new_plus_proc(char)
        end
      else
        regex << new_matching_proc(char)
      end

      index += 1
    end

    return regex
  end

  def self.new_matching_proc(char)
    return proc {|substring| checks_matching_char(substring, char) }
  end
end

should_pass = proc do |expression, string,|
  unless TJRegex.match?(expression, string)
    puts "FAIL: regex (#{expression}) string #{string} (False Negative)"
  end
end

should_fail = proc do |expr, str|
  if TJRegex.match?(expr, str)
    puts "FAIL: regex (#{expr}) string (#{str}) (False Positive)"
  end
end

# of my own devising
should_pass.('abc', 'abc')
should_pass.('a..', 'abc')
should_pass.('a..b', 'azzb')
should_pass.('a*', 'aaa')
should_pass.('aa+', 'aaa')
should_pass.('a.*', 'abc')
should_pass.('.*g', 'abcdefg')
should_pass.('a.*', 'abcdefg')
should_pass.(".*", "")
should_fail.('abc', 'aaa')
should_fail.('+jkdljkd', 'aaa')
should_fail.(".+", "")

# from glass door
should_pass.("a+b+c+", "abc")
should_pass.("a*b*c*", "abc")
should_pass.("abc*", "abc")
should_pass.("a..", "abc")
should_pass.("...", "abc")
should_pass.("abcf+h", "abcffffffffffh")
should_pass.("abcf*h", "abcffffffffffh")
should_pass.("abcf*h", "abch")
should_pass.("abcf*", "abc")
should_pass.("a*b*c*e+f+g+", "efg")
should_fail.("def", "abc")
should_fail.("d+ef", "abc")
should_fail.("d*ef", "abc")
should_fail.("acdf+", "abc")
should_fail.("abcf*", "abcffffffffffh")
should_fail.("a*b*c*e+f+g+", "ef")
