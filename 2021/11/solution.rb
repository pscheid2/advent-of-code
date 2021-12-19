require 'pry'

def print(lines)
  puts "---------------"
  lines.each { |line| puts line.join(",") }
end

lines = File.open("input.txt").readlines().map { |line| line.tr("\n", "").chars.map(&:to_i) }

count = 0

100.times do
  # increase by one
  lines.map do |octos|
    octos.map! { |octo| octo+1 }
  end
  
  flashes = []
  lines.size.times do |i|
    lines.first.size.times do |j|
      flashes << [i, j] if lines[i][j] == 10
    end
  end

  while flashes.size > 0
    i, j = flashes.pop
    # To prevent double flashing!
    lines[i][j] += 1

    # Increase adjacents
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        next if x == 0 && y == 0
        next if i+x < 0 || i+x > lines.size-1 || j+y < 0 || j+y > lines.first.size-1
        lines[i+x][j+y] += 1
        flashes << [i+x, j+y] if lines[i+x][j+y] == 10
      end
    end
  end

  lines.each do |line|
    line.each do |octo|
      count += 1 if octo > 9
    end
  end
  
  lines.map do |octos|
    octos.map! { |octo| octo > 9 ? 0 : octo }
  end
  print(lines)
end

puts count
