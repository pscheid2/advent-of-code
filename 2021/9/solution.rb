
lines = File.open("input.txt").readlines().map { |line| line.tr("\n", "").chars.map(&:to_i) }

risk = 0

lines.each.with_index do |line, i|
  line.each.with_index do |digit, j|
    # puts "#{i},#{j}  #{digit}"
    if (i-1<0 || lines[i-1][j] > digit) && 
        (i+1 > lines.size-1 || lines[i+1][j] > digit) &&
        (j-1<0 || lines[i][j-1] > digit) &&
        (j+1 > lines.first.size-1 || lines[i][j+1] > digit)
      # puts digit
      risk += digit + 1
    end
  end
end

puts risk
