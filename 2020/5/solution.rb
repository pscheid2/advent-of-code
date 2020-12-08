
def get_seat_id(line)
    row = line[0...7]
    col = line[7...10]
    row_id = 0
    row.each_char.with_index do |char, index|
        if char == "B"
            row_id += 2**(6-index)
        end
    end
    
    col_id = 0
    col.each_char.with_index do |char, index|
        if char == "R"
            col_id += 2**(2-index)
        end
    end

    row_id * 8 + col_id
end

ids = []
File.open("input1").each do |line|
    ids << get_seat_id(line)
end

# puts ids.sort

6.upto(813) do |num|
    if !ids.include?(num)
        puts num
    end
end
