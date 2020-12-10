
def is_valid_number(previous_numbers, number)
    previous_numbers.each do |num1|
        previous_numbers.each do |num2|
            if num1 == num2
                next
            elsif num1 + num2 == number
                return true
            end
        end
    end
    puts number
    false
end

def contiguous_sum_to(number, numbers)
    group = []
    numbers.each do |num1|
        group << num1
        if group.sum == number
            return group
        end
        while group.sum > number
            group.shift
            if group.sum == number
                return group
            end
        end
    end
end

numbers = []
File.open("input").each do |line|
    numbers << line.to_i
end

# i = 25
# while i < numbers.size
#     is_valid_number(numbers[i-25...i], numbers[i])
#     i += 1
# end

group = contiguous_sum_to(50047984, numbers)

puts group.min + group.max