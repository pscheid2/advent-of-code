require 'pry'

def parse(line)
  line = line.rstrip
  bin_string = line.hex.to_s(2).rjust(line.size*4, '0').chars
  puts bin_string.join

  ptr, value = parse_operator(bin_string, 0)
  puts value
end

def parse_literal(string, ptr)
  value = ""
  while string[ptr] == "1"
    value += string[ptr+1...ptr+5].join
    ptr +=5
  end

  value += string[ptr+1...ptr+5].join
  ptr += 5 # one more
  # binding.pry
  [ptr, value.to_i(2)]
end

def parse_operator(string, ptr)
  # Parsing the common header
  ptr += 3
  type_id = string[ptr...ptr+3].join.to_i(2)
  ptr += 3

  if type_id == 4
    ptr, value = parse_literal(string, ptr)
    return [ptr, value]
  else
    length_type_id = string[ptr]
    ptr += 1
    if length_type_id == "0"
      length_in_bits = string[ptr...ptr+15].join.to_i(2)
      ptr += 15
      orig_ptr = ptr
      values = []
      while orig_ptr + length_in_bits > ptr
        ptr, result_value = parse_operator(string, ptr)
        values << result_value
      end

    else
      num_sub_packets = string[ptr...ptr+11].join.to_i(2)
      ptr += 11
      values = []
      num_sub_packets.times do
        ptr, result_value = parse_operator(string, ptr)
        values << result_value
      end
    end
  end
  value = values_to_value(values, type_id)
  [ptr, value]
end

def values_to_value(values, type_id)
  case type_id
  when 0
    values.sum
  when 1
    values.inject(:*)
  when 2
    values.min
  when 3
    values.max
  when 5
    values.first > values.last ? 1 : 0
  when 6
    values.first < values.last ? 1 : 0
  when 7
    values.first == values.last ? 1 : 0
  else
    raise "invalid type_id"
  end
end

lines = File.open("input.txt").readlines()
parse(lines.first)

# parse(lines[0])
# parse(lines[1])
# parse(lines[2])
# parse(lines[3])
# parse(lines[4])
# parse(lines[5])
# parse(lines[6])
# parse(lines[7])