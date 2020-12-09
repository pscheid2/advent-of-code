def create_bag_map(lines)
    map = {}
    lines.each do |line|
        line = line.tr("\n", "")
        split1 = line.split(" bags contain ")
        split2 = split1[1].split(", ")
        split2.each do |bag|
            next if bag == "no other bags."
            bag = bag.match(/[0-9] (.*) bag/).captures.first
            puts bag
            if map[split1[0]].nil?
                map[split1[0]] = []
            end
            map[split1[0]] << bag
        end
    end

    puts map
    map
end

def find_gold_bag(map, bag_type)
    if bag_type == "shiny gold"
        return true
    end
    if map[bag_type].nil?
        return false
    end
    results = []
    map[bag_type].each do |bag_type2|
        results << find_gold_bag(map, bag_type2)
    end
    return results.any?
end

lines = []
File.open("input1").each do |line|
    lines << line
end

map = create_bag_map(lines)
count = 0
map.keys.each do |bag_type|
    count += 1 if find_gold_bag(map, bag_type)
end

puts count-1