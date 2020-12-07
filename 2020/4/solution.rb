def create_passport_map(cur_passport)
    cur_passport = cur_passport.tr("\n", " ").split(" ")
    passport_map = {}
    cur_passport.each do |entry|
        result = entry.split(":")
        passport_map[result[0]] = result[1]
    end
    passport_map
end


def in_range(input, min, max)
    input >= min && input <= max
end

def validate_height(height)
    return false if height.nil?
    if height.include?("in")
        inches = height.tr("in", "").to_i
        in_range(inches, 59, 76)
    elsif height.include?("cm")
        cms = height.tr("cm", "").to_i
        in_range(cms, 150, 193)
    else
        false
    end
end

def validate_hair(hair)
    !(hair =~ /^#[A-Fa-f0-9]{6}$/i).nil?
end

def validate_eye(eye)
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(eye)
end

def validate_passport(pid)
    !(pid =~ /^[0-9]{9}$/i).nil?
end

def is_valid_passport(passport)
    return false if !in_range(passport["byr"].to_i, 1920, 2002)
    return false if !in_range(passport["iyr"].to_i, 2010, 2020)
    return false if !in_range(passport["eyr"].to_i, 2020, 2030)
    return false if !validate_height(passport["hgt"])
    return false if !validate_hair(passport["hcl"])
    return false if !validate_eye(passport["ecl"])
    return false if !validate_passport(passport["pid"])
    true
end

def count_valid_passports(passports)
    count = 0
    passports.each do |passport|
        if is_valid_passport(passport)
            count += 1
        else
            puts passport
        end
    end
    count
end

passports = []
cur_passport = ""
File.open("input1").each do |line|
    if line == "\n"
        passports << create_passport_map(cur_passport)
        cur_passport = ""
    else
        cur_passport << line
    end
end
passports << create_passport_map(cur_passport)

puts passports.to_s
puts passports.size()

puts count_valid_passports(passports)