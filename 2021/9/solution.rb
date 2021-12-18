
lines = File.open("input.txt").readlines().map { |line| line.tr("\n", "").chars.map(&:to_i) }

risk = 0
low_points = []
lines.each.with_index do |line, i|
  line.each.with_index do |digit, j|
    # puts "#{i},#{j}  #{digit}"
    if (i-1<0 || lines[i-1][j] > digit) && 
        (i+1 > lines.size-1 || lines[i+1][j] > digit) &&
        (j-1<0 || lines[i][j-1] > digit) &&
        (j+1 > lines.first.size-1 || lines[i][j+1] > digit)
      # puts digit
      risk += digit + 1
      low_points << [i, j]
    end
  end
end

def calc_basin_size(lines, i, j, points)
  if i-1 >=0 && lines[i-1][j] < 9 && !points.include?([i-1, j])
    points << [i-1, j]
    calc_basin_size(lines, i-1, j, points) 
  end
  if i+1 < lines.size && lines[i+1][j] < 9 && !points.include?([i+1, j])
    points << [i+1, j]
    calc_basin_size(lines, i+1, j, points) 
  end
  if j-1 >=0 && lines[i][j-1] < 9 && !points.include?([i, j-1])
    points << [i, j-1]
    calc_basin_size(lines, i, j-1, points) 
  end
  if j+1 < lines.first.size && lines[i][j+1] < 9 && !points.include?([i, j+1])
    points << [i, j+1]
    calc_basin_size(lines, i, j+1, points) 
  end
end

basin_sizes = []
low_points.each do |low_point|
  i, j = low_point
  points = [low_point]
  calc_basin_size(lines, i, j, points)
  basin_sizes << points.size
end

puts risk
puts basin_sizes.sort.last(3).inject(&:*)
# points.each { |point| puts "#{point.first},#{point.last}"}
