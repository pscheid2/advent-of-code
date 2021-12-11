require 'pry'

def print_boards(boards)
  boards.each { |board| print_board(board); puts " " }
end

def print_board(board)
  board.each { |x| puts x.join(" ")}
end

def check_for_loser(boards)
  count = 0
  loser = []
  boards.each do |board|
    if !check_for_winner(board)
      loser = board
      count += 1
    end
    if count > 1
      return nil
    end
  end
  return loser
end

def check_for_winner(board)
  # check rows
  board.each do |row|
    if row.select { |el| el.include?("*") }.size == 5
      return true
    end
  end

  # check columns
  board.first.size.times do |i|
    flag = false
    board.first.size.times do |j|
      if !board[j][i].include?("*")
        flag = true
        break
      end
    end
    if !flag
      return true
    end
  end

  false
end

lines = File.open("input.txt").readlines()

drawings = lines.first.split(",").map(&:to_i)

boards = []
cur_board = []
lines.drop(2).each do |line|
  if line == "\n"
    boards << cur_board
    cur_board = []
    next
  end
  cur_board << line.split(" ")
end

puts drawings.join(",")
print_boards(boards)


loser = nil
last_draw = 0
drawings.each do |drawing|
  puts drawing
  boards.each do |board|
    board.each do |row|
      row.map! do |el|
        if el.to_i == drawing
          el + "*"
        else
          el
        end
      end
    end
  end

  if !loser
    loser = check_for_loser(boards)
  end
  if loser && check_for_winner(loser)
    last_draw = drawing
    break
  end
end

print_boards(boards)
puts "loser!"
print_board(loser)

sum = 0
loser.each do |row|
  row.each do |el|
    if !el.include?("*")
      sum += el.to_i
    end
  end
end

puts sum*last_draw