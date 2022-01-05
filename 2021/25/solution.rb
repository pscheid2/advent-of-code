require 'pry'
require 'set'

def step(lines)
  orig_lines = lines.clone.map(&:clone)
  # Move east
  (0...orig_lines.size).each do |y|
    (0...orig_lines.first.size).each do |x|
      east_x = (x+1) % orig_lines.first.size
      next if orig_lines[y][x] != ">" || orig_lines[y][east_x] != "."
      lines[y][x] = "."
      lines[y][east_x] = ">"
    end
  end
  orig_lines = lines.clone.map(&:clone)
  # Move south
  (0...orig_lines.size).each do |y|
    (0...orig_lines.first.size).each do |x|
      south_y = (y+1) % orig_lines.size
      next if orig_lines[y][x] != "v" || orig_lines[south_y][x] != "."
      lines[y][x] = "."
      lines[south_y][x] = "v"
    end
  end
  lines
end

def print(lines)
  lines.each { |line| p line }
  p "---------------"
end

lines = File.open("input.txt").readlines.map(&:rstrip)
print(lines)

count = 0
while true
  last = lines.clone.map(&:clone)
  count += 1
  step(lines)
  p count
  # print(lines)
  break if last == lines
end

p count
