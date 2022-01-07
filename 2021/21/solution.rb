require 'pry'

def die_roll(last_roll)
  if last_roll >= 100
    1
  else
    last_roll + 1
  end
end

def update_position(positions, player_index, roll)
  new_pos = (positions[player_index] + roll) % 10
  new_pos = 10 if new_pos == 0
  positions[player_index] = new_pos
end

# player_positions = [2, 10]
player_positions = [4, 8]
player_scores = [0, 0]
roll = 0
player_index = 0
num_rolls = 0

while player_scores.max < 1000
  sum = 0
  3.times do
    roll = die_roll(roll)
    sum += roll
  end
  update_position(player_positions, player_index, sum)
  player_scores[player_index] += player_positions[player_index]
  player_index = (player_index + 1) % player_positions.size
  num_rolls += 3
  # binding.pry
end

# binding.pry
p player_scores
p num_rolls * player_scores.min