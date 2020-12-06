
forest = []
File.open("input1").each do |line|
    forest << line.tr("\n", "")
end


def num_collisions(forest, down, right)
    i = 0; j = 0;
    tree_count = 0
    forest_width = forest[0].size()

    while i < forest.size()
        if forest[i][j % forest_width] == "#"
            tree_count += 1
        end

        i += down
        j += right
    end
    tree_count
end

collisions = []
collisions << num_collisions(forest, 1, 1)
collisions << num_collisions(forest, 1, 3)
collisions << num_collisions(forest, 1, 5)
collisions << num_collisions(forest, 1, 7)
collisions << num_collisions(forest, 2, 1)

puts collisions

puts collisions.inject(:*)