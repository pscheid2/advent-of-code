
require 'pry'
seed = File.open("input.txt").readlines().first

lanterns = Hash.new(0)
seed.split(",").each do |start|
  lanterns[start.to_i] += 1
end

puts "Seed #{lanterns}"

256.times do
  new_hash = Hash.new(0)
  count = 0
  lanterns.each do |key, value|
    if key == 0
      count += value
      new_hash[6] += value
    else
      new_hash[key - 1] += value
    end
  end
  new_hash[8] = count
  lanterns = new_hash
end

puts "Final #{lanterns}"
puts "Count #{lanterns.values.sum}"