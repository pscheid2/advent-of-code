
cords = []
folds = []
File.open("input.txt").each do |line|
  if line.include?("fold along")
    folds << line.rstrip
  elsif line != "\n"
    cords << line.rstrip.split(",").map(&:to_i)
  end
end

def transform_points(cords, fold)
  axis, num = fold.split("=")
  axis = axis.split("fold along ").last
  num = num.to_i
  puts axis, num

  cords.map! do |cord|
    if axis == "x"
      dim = cord.first
      dim = num - (dim - num) if dim > num
      [dim, cord.last]
    else
      dim = cord.last
      dim = num - (dim - num) if dim > num
      [cord.first, dim]
    end
  end
  cords
end

puts "Initial cords"
cords.each { |cord| puts cord.join(",")}
puts "------------------"

folds.each do |fold|
  cords = transform_points(cords, fold)
  cords = cords.uniq
  cords.each { |cord| puts cord.join(",")}
  puts cords.uniq.size
end


max_x = 0
max_y = 0
cords.each do |cord|
  if cord.first > max_x
    max_x = cord.first
  end
  if cord.last > max_y
    max_y = cord.last
  end
end

(0..max_y).each do |y|
  string = ""
  (0..max_x).each do |x|
    if cords.include?([x, y])
      string += "#"
    else
      string += "."
    end
  end
  puts string
end
