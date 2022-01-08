require 'pry'
# lines = File.open("test.txt").readlines
# lines = lines[0...-2]
lines = File.open("input.txt").readlines
lines = lines[0..19]

cube = Hash.new("off")

lines.each do |line|
  op, coords = line.split(" ")
  x, y, z = coords.split(",")

  x0, x1 = x.tr("x=", "").split("..").map(&:to_i)
  y0, y1 = y.tr("y=", "").split("..").map(&:to_i)
  z0, z1 = z.tr("z=", "").split("..").map(&:to_i)

  (x0..x1).each do |x|
    (y0..y1).each do |y|
      (z0..z1).each do |z|
        cube[[x, y, z]] = op
      end
    end
  end
end

p cube.select { |k, v| v == "on" }.size