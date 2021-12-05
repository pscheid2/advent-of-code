
lines = []
File.open("input.txt").each do |line|
  lines << line.tr("\n", "")
end
puts lines


# part 1
# by_pos = []
# lines.first.size.times { by_pos << [] }

# lines.each do |line|
#   line.each_char.with_index do |char, index|
#     by_pos[index] << char.to_i
#   end
# end
# gamma = ""
# by_pos.each do |pos_arr|
#   puts "pos_arr #{pos_arr}"
#   if pos_arr.sum >= (pos_arr.size / 2)
#     gamma << "1"
#   else 
#     gamma << "0"
#   end
# end

# puts gamma

# epsilon = gamma.chars.map { |char| char == "1" ? "0" : "1" }.join

# puts gamma.to_i(2)
# puts epsilon.to_i(2)

# puts gamma.to_i(2) * epsilon.to_i(2)

# part 2
num_cols = lines.first.size
oxy_lines = lines.clone

num_cols.times do |index|
  sum = oxy_lines.map { |line| line[index].to_i }.sum
  puts "lines #{oxy_lines}"
  puts "sum #{sum}"
  if sum >= oxy_lines.size / 2.0
    oxy_lines.delete_if { |line| line[index] == "0" }
  else
    oxy_lines.delete_if { |line| line[index] == "1" }
  end
  break if oxy_lines.size < 2
end

puts "oxygen #{oxy_lines}"

co2_lines = lines.clone

num_cols.times do |index|
  sum = co2_lines.map { |line| line[index].to_i }.sum
  puts "lines #{co2_lines}"
  puts "sum #{sum}"
  if sum >= co2_lines.size / 2.0
    co2_lines.delete_if { |line| line[index] == "1" }
  else
    co2_lines.delete_if { |line| line[index] == "0" }
  end
  break if co2_lines.size < 2
end

puts "co2 #{co2_lines}"

puts oxy_lines.first.to_i(2)
puts co2_lines.first.to_i(2)

puts oxy_lines.first.to_i(2) * co2_lines.first.to_i(2)

