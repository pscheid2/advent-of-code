class Bag
    attr_accessor :color, :count
    def initialize(color, count)
        @color = color
        @count = count
    end
end

def create_bag_map(lines)
    map = {}
    lines.each do |line|
        line = line.tr("\n", "")
        split1 = line.split(" bags contain ")
        split2 = split1[1].split(", ")
        split2.each do |bag|
            next if bag == "no other bags."
            count, color = bag.match(/([0-9]) (.*) bag/).captures
            puts bag
            if map[split1[0]].nil?
                map[split1[0]] = []
            end
            map[split1[0]] << Bag.new(color, count.to_i)
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

def count_bags(map, bag_type)
    puts bag_type
    if map[bag_type].nil?
        return 0
    end

    count = 0
    map[bag_type].each do |bag_type2|
        puts bag_type2
        count += (count_bags(map, bag_type2.color) * bag_type2.count) + bag_type2.count
    end
    count
end

lines = []
File.open("input1").each do |line|
    lines << line
end

map = create_bag_map(lines)

puts count_bags(map, "shiny gold")
# count = 0
# map.keys.each do |bag_type|
#     count += 1 if find_gold_bag(map, bag_type)
# end

# puts count-1