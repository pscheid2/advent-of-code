
def acc_before_loop(lines)
    i = 0
    lines_visited = Array.new(lines.size, false)

    acc = 0
    while true do
        if lines_visited[i]
            return acc
        end
        line = lines[i]
        lines_visited[i] = true
        inst, num = line.split(" ")

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

puts acc_before_loop(lines)