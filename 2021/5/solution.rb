

lines = File.open("input.txt").readlines()

cords = lines.map { |line| line.split(" -> ").map { |cord| cord.split(",").map(&:to_i) }.sort }

cords.each { |cord| puts "#{cord[0].join(",")} #{cord[1].join(",")}" }

count_map = Hash.new(0)
cords.each do |cord|
  if cord[0][0] == cord[1][0]
    x = cord[0][0]
    (cord[0][1]..cord[1][1]).each do |i|
      count_map["#{x},#{i}"] += 1
    end
  elsif cord[0][1] == cord[1][1]
    y = cord[0][1]
    (cord[0][0]..cord[1][0]).each do |i|
      count_map["#{i},#{y}"] += 1
    end
  else
    if cord[0][1] < cord[1][1] # if y is increasing
      start_x = cord[0][0]
      start_y = cord[0][1]
      (cord[1][0] - cord[0][0] + 1).times do |i|
        count_map["#{start_x+i},#{start_y+i}"] +=1
      end
    else # if y is decreasing
      start_x = cord[0][0]
      start_y = cord[0][1]
      (cord[1][0] - cord[0][0] + 1).times do |i|
        count_map["#{start_x+i},#{start_y-i}"] +=1
      end
    end
  end
end

puts count_map

count = 0
count_map.each do |key, val|
  count += 1 if val >=2
end
puts count