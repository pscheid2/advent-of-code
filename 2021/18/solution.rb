require 'JSON'
require 'pry'
require 'set'

def parse_list(line)
  JSON.parse(line.rstrip)
end

def reduce(string)
  depth = 0
  string.chars.each.with_index do |char, index|
    if char == '['
      depth += 1
    elsif char == ']'
      depth -= 1
    end

    if depth > 4
      # If any pair is nested inside four pairs, the leftmost such pair explodes.
      end_index = string.index(']', index)
      
      to_explode = string[index..end_index]
      left, right = JSON.parse(to_explode)

      # left
      left_string = string[0...index]
      flipped = left_string.reverse
      m = flipped.match(/\d+/)
      if m
        left_num = m[0].reverse
        new_num = left_num.to_i + left
        flipped.sub!(m[0], new_num.to_s.reverse)
        left_string = flipped.reverse
      end

      # right
      right_string = string[end_index+1..-1]
      m = right_string.match(/\d+/)
      if m
        right_num = m[0]
        new_num = right_num.to_i + right
        right_string.sub!(right_num, new_num.to_s)
      end

      return "#{left_string}0#{right_string}"
    end
  end

  string.chars.each.with_index do |char, index|
    # TODO doesnt work for > 99
    if char.match?(/[0-9]/) && string[index+1].match?(/[0-9]/)
      num = string[index..index+1]
      # If any regular number is 10 or greater, the leftmost such regular number splits.
      new_string = string.clone
      new_string.sub!(num, "[#{(num.to_i/2.0).floor},#{(num.to_i/2.0).ceil}]")
      return new_string
    end
  end

  string
end

def magnitude(string)
  while string.count(",") > 1
    string.scan(/\[\d+,\d+\]/).each do |m|
      left_digit, right_digit = m[1...-1].split(",")
      string = "#{string[0...string.index(m)]}#{left_digit.to_i * 3 + right_digit.to_i * 2}#{string[string.index(m)+m.size..-1]}"
    end
  end
  left_digit, right_digit = string[1...-1].split(",")
  return left_digit.to_i * 3 + right_digit.to_i * 2

end

lines = File.open("input.txt").readlines.map(&:rstrip)

# part 1
cur = lines.first
lines.drop(1).each do |line|
  cur = "[#{cur},#{line}]"
  new_string = nil
  while new_string != cur
    cur = new_string if new_string
    new_string = reduce(cur)
  end
end
p cur
p magnitude(cur)

# part 2
magnitudes = Set.new
pairs = lines.combination(2).to_a
pairs.each do |pair|
  cur = "[#{pair.first},#{pair.last}]"
  new_string = nil
  while new_string != cur
    cur = new_string if new_string
    new_string = reduce(cur)
  end
  magnitudes << magnitude(cur)
end
p magnitudes.max
