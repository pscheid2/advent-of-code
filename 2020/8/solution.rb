
def acc_before_loop(lines, flip_index)
    i = 0
    lines_visited = Array.new(lines.size, false)

    acc = 0
    while true do
        if i == lines.size
            puts flip_index
            puts acc
            return true
        end
        if lines_visited[i]
            return false
        end
        line = lines[i]
        lines_visited[i] = true
        inst, num = line.split(" ")
        
        if i == flip_index
            if inst == "jmp"
                inst = "nop"
            elsif inst == "nop"
                inst = "jmp"
            end
        end

        case inst            
        when "acc"
            acc += num.to_i
        when "jmp"
            i += num.to_i
            next
        end
        
        i += 1
    end
end


lines = []
File.open("input").each do |line|
    lines << line
end

lines.size.times.each do |flip_index|
    acc_before_loop(lines, flip_index)
end