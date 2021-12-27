require 'pry'
require 'algorithms'
require 'set'

lines = File.open("input.txt").readlines().map { |line| line.rstrip.chars.map(&:to_i) }
lines.each { |line| puts line.join }

risk = 0

visited = Set.new([[0,0]]) # row, column
heap = Containers::MinHeap.new([[0,0,0]]) # risk, row, column
height = lines.size
width = lines.first.size

while heap
  risk, r, c = heap.pop
  if r == height - 1 && c == width -1
    puts risk
    break
  end

  [[r-1, c], [r+1, c], [r, c+1], [r, c-1]].each do |el|
    r_, c_ = el
    if r_.between?(0, height-1) && c_.between?(0, width-1) && !visited.include?(el)
      visited << el
      heap.push([risk + lines[r_][c_], r_, c_])
    end
  end
end