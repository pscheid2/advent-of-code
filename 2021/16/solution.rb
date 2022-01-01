require 'pry'

def parse(line)
  line = line.rstrip
  bin_string = line.hex.to_s(2).rjust(line.size*4, '0').chars
  puts bin_string.join

  ptr, value = parse_operator(bin_string, 0)
  puts value
end

def parse_literal(string, ptr)
  group_count = 0
  while string[ptr] == "1"
    ptr +=5
    group_count += 1
    # don't do anything with this for now
  end

  ptr += 5 # one more
end

def parse_operator(string, ptr)
  # Parsing the common header
  value = string[ptr...ptr+3].join.to_i(2)
  ptr += 3
  type_id = string[ptr...ptr+3].join.to_i(2)
  ptr += 3

  if type_id == 4
    ptr = parse_literal(string, ptr)
  else
    length_type_id = string[ptr]
    ptr += 1
    if length_type_id == "0"
      length_in_bits = string[ptr...ptr+15].join.to_i(2)
      ptr += 15
      orig_ptr = ptr
      while orig_ptr + length_in_bits > ptr
        ptr, result_value = parse_operator(string, ptr)
        value += result_value
      end
    else
      num_sub_packets = string[ptr...ptr+11].join.to_i(2)
      ptr += 11
      num_sub_packets.times do
        ptr, result_value = parse_operator(string, ptr)
        value += result_value
      end
    end
  end
  [ptr, value]
end

lines = File.open("test.txt").readlines()
# parse(lines.first)

parse(lines[0])
parse(lines[1])
parse(lines[2])
parse(lines[3])
parse(lines[4])
parse(lines[5])