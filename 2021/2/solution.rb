
horizontal = 0
depth = 0
aim = 0
File.open("input.txt").each do |line|
  line.tr("\n", "")
  puts line
  action, amount = line.split(" ")
  amount = amount.to_i
  case action
  when "forward"
    horizontal += amount
    depth += aim * amount
  when "up"
    aim -= amount
  when "down"
    aim += amount
  else
    throw "Unknown action type"
  end
end

puts "horizontal #{horizontal} depth #{depth}"
puts horizontal * depth