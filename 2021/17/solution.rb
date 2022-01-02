require 'pry'
target = [(48..70), (-189..-148)]
# target = [(20..30), (-10..-5)]


working = []
(0..70).each do |start_xd|
  (-189..189).each do |start_yd|
    xd = start_xd
    yd = start_yd
    x = 0; y = 0
    while y >= target.last.first do
      x += xd
      y += yd
      yd -= 1
      if xd > 0
        xd -= 1
      elsif xd < 0
        xd += 1
      end
      if target.last.include?(y) && target.first.include?(x)
        working << [start_xd, start_yd]
      end
    end
  end
end

# binding.pry
puts working.uniq.size