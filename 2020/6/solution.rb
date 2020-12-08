
def count_customs(group)
    num_people = group.split("\n").size
    count = 0
    ("a".."z").each do |letter|
        if group.count(letter) == num_people
            count += 1
        end
    end
    count
end


groups = []
cur_group = ""
File.open("input1").each do |line|
    if line == "\n"
        groups << cur_group
        cur_group = ""
    else
        cur_group += line
    end
end
groups << cur_group

counts = []
groups.each do |group|
    counts << count_customs(group)
end

puts counts.sum