# frozen_string_literal: true

require './lib/pretty_display'
require './lib/play_mastermind'
require 'pry-byebug'

# End game scripts for win/loss and logic to play again
class EndGame
  def self.declare_winner(guesses)
    new(guesses).we_have_a_winner
  end

  def self.declare_loser(guesses, colors)
    new(guesses, colors).better_luck_next_time
  end

  def initialize(guesses_remaining = 0, colors = [])
    @guesses_remaining = guesses_remaining
    @colors = colors
  end

  def we_have_a_winner
    print_winners_message
    print_play_again_message
    play_again?
  end

  def print_winners_message
    PrettyDisplay.puts_pause('whoohoo, you win, you codebreaker, you!!!', 2)
    PrettyDisplay.puts_pause("you got it right in #{12 - @guesses_remaining} attempts. Impressive!", 2)
  end

  def better_luck_next_time
    print_losing_message
    print_play_again_message
    play_again?
  end

  def print_losing_message
    PrettyDisplay.puts_pause('Ope, your 12 guesses are up.', 2)
    print '>> The code was: >> | '
    @colors.each do |color|
      print "#{color} | "
    end
    PrettyDisplay.puts_pause(' <<', 3)
  end

  def play_again?
    case answer
    when '1'
      PlayMasterMind.play_new_game
    when '2'
      PrettyDisplay.puts_pause("\nok, another time then!")
    else
      PrettyDisplay.animated_elipses
      PrettyDisplay.puts_pause("Hm... I don't know that one. Choose '1' to play again or '2' to exit.")
      play_again?
    end
  end

  def print_play_again_message
    PrettyDisplay.puts_pause('Would you like to play again? (1 = yes, 2 = no)')
  end

  def answer
    gets.chomp
  end
end
