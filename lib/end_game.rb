require './lib/pretty_display'
require './lib/mastermind'
require 'pry-byebug'

class EndGame
  def self.we_have_a_winner
    PrettyDisplay.puts_pause("whoohoo, you win, you codebreaker, you!!!", 2)
    self.play_again?
  end

  def self.better_luck_next_time(colors)
    PrettyDisplay.puts_pause("Ope, your 12 guesses are up.", 2)
    print ">> The code was: >> | "
    colors.each do |color|
      print "#{color.to_s} | "
    end
    PrettyDisplay.puts_pause(" <<", 3)

    self.play_again?
  end

  def self.play_again?
    PrettyDisplay.puts_pause("Would you like to play again? (1 = yes, 2 = no)")
    answer = gets.chomp
    case answer
    when "1"
      new_game = PlayMasterMind.new(12)
      new_game.play_game(12)
    when "2"
      PrettyDisplay.puts_pause("\nok, another time then!")
      exit
    else
      PrettyDisplay.animated_elipses
      PrettyDisplay.puts_pause("Hm, I don't know that one. I'm going to bed though. Another time!")
      exit
    end
  end
end