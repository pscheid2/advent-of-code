
measurements = []
count = 0
File.open("input.txt").each do |line|
  measurements << line.to_i
end

measurements.each_with_index do |measure, index|
  next if index > measurements.count - 4
  window_one = measurements[index...index+3]
  window_two = measurements[index+1...index+4]
  puts "one #{window_one} two #{window_two}"
  if window_one.sum < window_two.sum
    count += 1
  end

end

puts count