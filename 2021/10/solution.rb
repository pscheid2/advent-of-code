
require 'pry'

lines = File.open("input.txt").readlines().map { |line| line.tr("\n", "") }

pairs = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">",
}

points = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137,
}

incomplete_points = {
  "(" => 1,
  "[" => 2,
  "{" => 3,
  "<" => 4,
}


pushes = ["(", "[", "{", "<"]
pops = [")", "]", "}", ">"]

incomplete_scores = []
invalids = []

lines.each do |line|
  stack = []
  incomplete = true
  line.chars.each do |char|
    if pushes.include?(char)
      stack.push(char)
    elsif pops.include?(char)
      popped = stack.pop
      if pairs[popped] != char
        incomplete = false
        invalids << char
        break
      end
    else
      raise "Error not valid char"
    end
  end
  if incomplete
    score = 0
    stack.reverse.each do |el|
      score = score * 5 + incomplete_points[el]
    end
    incomplete_scores << score
  end
end

puts "Invalids score"
puts invalids.map { |invalid| points[invalid] }.sum

puts "Incomplete scores"
puts incomplete_scores.join(",")

puts "Middle score"
puts incomplete_scores.sort[incomplete_scores.size / 2]