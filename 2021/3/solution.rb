
lines = []
File.open("input.txt").each do |line|
  lines << line.tr("\n", "")
end

by_pos = []
lines.first.size.times { by_pos << [] }

lines.each do |line|
  line.each_char.with_index do |char, index|
    by_pos[index] << char.to_i
  end
end

gamma = ""
by_pos.each do |pos_arr|
  puts "pos_arr #{pos_arr}"
  if pos_arr.sum > (pos_arr.size / 2)
    gamma << "1"
  else 
    gamma << "0"
  end
end

epsilon = gamma.chars.map { |char| char == "1" ? "0" : "1" }.join

puts gamma.to_i(2)
puts epsilon.to_i(2)

puts gamma.to_i(2) * epsilon.to_i(2)
