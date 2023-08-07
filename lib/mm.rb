require 'pry-byebug'

# code for counting & tallying the guesses
class Guess
  def initialize(guess=0)
    @guess = guess
  end

  def increment_turn_counter
    @guess += 1
  end

  def guesses_done
    @guess
  end
end

# runs through turns... feels redundant, like we're counting twice... 
# We'd also need to call code in between that actually runs the game bits
def run_through_turns(turn=0)
  if turn < 12
    guess = Guess.new(turn)
    turn = guess.increment_turn_counter
    puts "turn: #{turn}, guess: #{guess.guesses_done}"
    run_through_turns(turn)
  else
    puts "12th turn!, game over"
  end

end

puts run_through_turns
