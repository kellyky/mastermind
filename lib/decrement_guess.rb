require './lib/mastermind'
require 'pry-byebug'

class DecrementGuess
  def initialize(guess_count=0)
    @guess_count = guess_count
  end

  def decrement_turn_counter
    @guess_count -= 1
  end
end