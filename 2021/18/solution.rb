require 'JSON'
require 'pry'

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
      new_string = string.clone

      # left
      left_index = index
      while !new_string[left_index].match?(/[0-9]/)
        left_index -= 1
        break if left_index < 0
      end
      if left_index > 0
        left_end_index = left_index
        while left_end_index-1 > 0 && new_string[left_end_index-1].match?(/[0-9]/)
          left_end_index -= 1
        end
        old = new_string.slice!(left_end_index..left_index).to_i
        new_string.insert(left_end_index, (old+left).to_s)
        end_index += (old+left).to_s.size - old.to_s.size
      end

      # right
      right_index = end_index
      while !new_string[right_index].match?(/[0-9]/)
        right_index += 1
        break if right_index >= new_string.size
      end
      if right_index < new_string.size
        right_end_index = right_index
        while right_end_index+1 < new_string.size && new_string[right_end_index+1].match?(/[0-9]/)
          right_end_index += 1
        end
        old = new_string.slice!(right_index..right_end_index).to_i
        new_string.insert(right_index, (old+right).to_s)
      end

      new_string.sub!(to_explode, "0")

      return new_string
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

lines = File.open("test.txt").readlines

cur = lines.first.rstrip
lines.drop(1).each do |line|
  cur = "[#{cur},#{line.rstrip}]"
  new_string = nil
  while new_string != cur
    cur = new_string if new_string
    p cur
    new_string = reduce(cur)
  end
end


p cur
