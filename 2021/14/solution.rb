require 'pry'
lines = File.open("input.txt").readlines()

polymer = Hash.new(0)
lines.first.rstrip.chars.each_cons(2) do |pair|
  polymer[pair] += 1
end
polymer.each { |k,v| puts "#{k} -> #{v}"}

map = {}
lines[2..-1].each do |line|
  key, value = line.rstrip.split(" -> ")
  map[key] = value
end

40.times do 
  new_polymer = Hash.new(0)

  polymer.each do |key, value|
    lookup = map[key.join]
    new_polymer[[key.first, lookup]] += value
    new_polymer[[lookup, key.last]] += value
  end
  polymer = new_polymer
  polymer.each { |k,v| puts "#{k} -> #{v}"}
end

freq = polymer.inject(Hash.new(0)) do |hash, el|
  k, v = el
  hash[k.first] += v
  hash[k.last] += v
  hash
end
freq.each { |k,v| puts "#{k} -> #{v}"}

quantities = freq.values.map { |item| ((item + 1) / 2).floor }.sort

puts quantities[-1] - quantities[0]
