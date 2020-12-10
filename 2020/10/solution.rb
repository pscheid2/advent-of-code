
def joltage_distribution(joltages)

    dist = {0 => 0, 1 => 0, 2 => 0, 3 => 0}
    last_joltage = 0
    joltages.each do |joltage|
        dist[joltage - last_joltage] += 1
        last_joltage = joltage
    end
    dist
end

def arrangements(joltages, memo)
    if joltages.size == 1
        return 1
    end

    cur_joltage = joltages.first
    joltages_in_range = joltages.select{|joltage| joltage > cur_joltage && joltage <= cur_joltage + 3}
    paths = 0
    joltages_in_range.each do |next_start_joltage|
        if memo[next_start_joltage]
            paths += memo[next_start_joltage]
        else
            subpaths = arrangements(joltages.select{|joltage| joltage >= next_start_joltage}, memo)
            paths += subpaths
            memo[next_start_joltage] = subpaths
        end
    end
    paths
end


joltages = []
File.open("input").each do |line|
    joltages << line.to_i
end

joltages << joltages.max + 3
joltages << 0
joltages = joltages.sort

puts dist = joltage_distribution(joltages)

puts dist[1] * dist[3]

memo = {}
puts arrangements(joltages, memo)