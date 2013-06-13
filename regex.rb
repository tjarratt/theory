class TJRegex
  def self.match?(regex, string)
    return string.empty? if regex.empty? #       if the regex is empty
    r = regex[0]
    s = string[0]
    if regex[1] != '*'
      raise RuntimeError if regex[0] == '*'
      return (r == s || r == '.') && match?(regex[1..regex.size], string[1..string.size])
    end
    index = 0
    while r == s || (r == '.' && !s.nil?)
      return true if match?(regex[2..regex.size], string[index..string.size])
      index += 1
      s = string[index]
    end
    return match?(regex[2, regex.size], string[index, string.size])
  end
end

should_pass = proc do |expression, string,|
  unless TJRegex.match?(expression, string)
    puts "FAIL: regex (#{expression}) string (#{string}) (False Negative)"
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
should_pass.('a.*', 'abc')
should_pass.('.*g', 'abcdefg')
should_pass.('a.*', 'abcdefg')
should_pass.(".*", "") # fail fail fail;
should_pass.("x*xxxxxxxx*x*xxx*x", "xxxxxxxxxxxxxxxxxxxxxxxxx")
should_fail.('abc', 'aaa')

# from glass door
should_pass.("a*b*c*", "abc")
should_pass.("abc*", "abc")
should_pass.("a..", "abc")
should_pass.("...", "abc")
should_pass.("...", "zyx")
should_pass.("abcf*h", "abcffffffffffh")
should_pass.("abcf*h", "abch")

should_pass.("abcf*", "abc") # this also fails wtf

should_pass.("a*b*c*e*f*g*", "efg")
should_fail.("def", "abc")
should_fail.("d*ef", "abc")
should_fail.("abcf*", "abcffffffffffh")
