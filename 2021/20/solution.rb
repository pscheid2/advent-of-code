require 'set'
require 'pry'

GRID = [[-1,-1], [-1, 0], [-1, 1], [0, -1], [0, 0], [0, 1], [1,-1], [1, 0], [1,1]]

def enhance(input, algorithm, is_even)
  min_r = input.min_by { |el| el.first }.first
  max_r = input.max_by { |el| el.first }.first
  min_c = input.min_by { |el| el.last }.last
  max_c = input.max_by { |el| el.last }.last
  new_set = Set.new
  (min_r-1..max_r+1).each do |r|
    (min_c-1..max_c+1).each do |c|
      key = ""
      GRID.each do |rd, cd|
        if input.include?([r+rd, c+cd]) || (is_even && (r+rd > max_r || r+rd < min_r || c+cd > max_c || c+cd < min_c))
          key << "1"
        else
          key << "0"
        end
      end
      if algorithm[key.to_i(2)] == "#"
        new_set << [r, c]
      end
    end
  end
  new_set
end

lines = File.open("input.txt").readlines

algorithm = lines.first

input = Set.new
lines[2..-1].each.with_index do |line, r|
  line.chars.each.with_index do |char, c|
    input << [r, c] if char == "#"
  end
end

(1..50).each do |index|
  input = enhance(input, algorithm, index % 2 == 0)
end
p input.size
