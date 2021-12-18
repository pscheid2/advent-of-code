require 'pry'
# 1, 4, 7, 8
# 2, 4, 3, 7

lines = File.open("test.txt").readlines()


count = 0
[lines.first].each do |line|
  puts line
  segment_to_signal = {
    a: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    b: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    c: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    d: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    e: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    f: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    g: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
  }
  line.split(" | ").first.split(" ").each do |string|
    case(string.size)
    when 2 # 1
      # binding.pry  
      segment_to_signal[:c].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:f].select! { |entry| string.chars.include?(entry) }
    when 4 # 4
      segment_to_signal[:b].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:c].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:d].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:f].select! { |entry| string.chars.include?(entry) }
    when 3 # 7
      segment_to_signal[:a].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:c].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:d].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:f].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:g].select! { |entry| string.chars.include?(entry) }
    when 7 # 8
      segment_to_signal[:a].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:b].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:c].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:d].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:e].select! { |entry| string.chars.include?(entry) }
      segment_to_signal[:f].select! { |entry| string.chars.include?(entry) }
    end
  end
  puts segment_to_signal
end
