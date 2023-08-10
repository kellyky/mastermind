require './lib/mastermind'
require 'pry-byebug'

class EndGame
  def self.we_have_a_winner
    puts "whoohoo, you win, you codebreaker, you!!!"
    self.play_again?
  end

  def self.better_luck_next_time
    puts "Your 12 turns are up. Better luck next time!"
    self.play_again?
  end

  def self.play_again?
    puts "would you like to play again? (1=yes, 2=no)"
    answer = gets.chomp
    if answer == "1"
      PlayMasterMind.start_new_game # FIXME
    else
      "ok, another time then!"
      exit
    end
  end
end