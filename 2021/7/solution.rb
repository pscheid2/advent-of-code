
lines = File.open("input.txt").readlines()

line = lines.first.split(",").map(&:to_i)

min_gas = 500000000
(line.min..line.max).each do |n|
  gas = 0
  line.each do |pos|
    i = (pos - n).abs()
    gas += i*(i+1)/2
  end
  min_gas = [min_gas, gas].min
end

puts min_gas