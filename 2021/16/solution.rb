require 'pry'

def parse(line)
  line = line.rstrip
  bin_string = line.hex.to_s(2).rjust(line.size*4, '0').chars
  puts bin_string.join

  ptr, version_sum = parse_operator(bin_string, 0, 0)
  puts version_sum
end

def parse_literal(string, ptr, version_sum)
  group_count = 0
  while string[ptr] == "1"
    ptr +=5
    group_count += 1
    # don't do anything with this for now
  end

  ptr += 5 # one more

  ptr += ((group_count*5+6) % 4)
  [ptr, version_sum]
end

def parse_operator(string, ptr, version_sum)
  # Parsing the common header
  version_sum += string[ptr...ptr+3].join.to_i(2)
  puts version_sum
  ptr += 3
  type_id = string[ptr...ptr+3].join.to_i(2)
  ptr += 3

  if type_id == 4
    ptr, version_sum = parse_literal(string, ptr, version_sum)
  else
    length_type_id = string[ptr]
    ptr += 1
    if length_type_id == "0"
      length_in_bits = string[ptr...ptr+15].join.to_i(2)
      ptr += 15
      orig_ptr = ptr
      while orig_ptr + length_in_bits >= ptr
        ptr, version_sum = parse_operator(string, ptr, version_sum)
      end
    else
      num_sub_packets = string[ptr...ptr+11].join.to_i(2)
      ptr += 11
      num_sub_packets.times do
        ptr, version_sum = parse_operator(string, ptr, version_sum)
      end
    end
  end
  [ptr, version_sum]
end

lines = File.open("test.txt").readlines()

parse(lines[0])
# parse(lines[1])
# parse(lines[2])
# parse(lines[3])