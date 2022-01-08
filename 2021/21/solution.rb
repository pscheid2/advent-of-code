require 'pry'

# Part 1
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

player_positions = [2, 10]
# player_positions = [4, 8]
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
end

p player_scores
p num_rolls * player_scores.min

# Part 2
RF = [[3,1],[4,3],[5,6],[6,7],[7,6],[8,3],[9,1]]

## if p1 is about to move, return (w1,w2) where
## wj is the number of universes where player j wins
def wins(p1,t1,p2,t2)
  return [0,1] if t2 <= 0  # p2 has won (never p1 since p1 about to move)

  w1,w2 = 0,0
  RF.each do |r, f|
    c2,c1 = wins_cached(p2,t2,(p1+r)%10,t1 - 1 - (p1+r)%10) # p2 about to move
    w1,w2 = w1 + f * c1, w2 + f * c2
  end
  return [w1,w2]
end

def wins_cached(p1, t1, p2, t2)
  @cache ||= {}
  @cache["#{p1}, #{t1}, #{p2}, #{t2}"] ||= wins(p1, t1, p2, t2)
end

p "Bigger winner universes:", wins_cached(3,21,7,21).max
# p "Bigger winner universes:", part2.wins_cached(1,21,9,21).max