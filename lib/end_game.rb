require './lib/mastermind'
require 'pry-byebug'

class EndGame
  def self.we_have_a_winner
    puts "whoohoo, you win, you codebreaker, you!!!"
    sleep(0.2)
    self.play_again?
  end

  def self.better_luck_next_time(colors)
    puts "Your 12 turns are up."
    sleep(0.2)
    puts "The code to crack was #{colors}."
    sleep(0.2)
    puts "Better luck next time!"
    sleep(0.2)
    self.play_again?
  end

  def self.play_again?
    puts "would you like to play again? (1=yes, 2=no)"
    sleep(0.2)
    answer = gets.chomp
    if answer == "1"
      new_game = PlayMasterMind.new(12)
      new_game.play_game(12)
    else
      "ok, another time then!"
      sleep(0.2)
      exit
    end
  end
end