# frozen_string_literal: true

require_relative 'play_mastermind'
require_relative 'pretty_display'

# End game scripts for win/loss and logic to play again
class EndGame
  GAME_CHOICE = {
    '1' => :play_again,
    '2' => :exit_game
  }.freeze

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
    congratulate_the_winner
    invite_player_to_another_game
    play_again?
  end

  def congratulate_the_winner
    PrettyDisplay.puts_pause('whoohoo, you win, you codebreaker, you!!!', 2)
    PrettyDisplay.puts_pause(
      "you got it right in #{12 - @guesses_remaining} attempts. Impressive!", 2
    )
  end

  def better_luck_next_time
    print_losing_message
    invite_player_to_another_game
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

  # Prompts the player to play again or exit based on user input.
  # Recursively calls itself until a valid answer ('1' for play again, '2' for exit) is provided.
  def play_again?
    send((GAME_CHOICE[answer]).to_s)
  rescue NoMethodError
    PrettyDisplay.animated_elipses
    PrettyDisplay.puts_pause(
      "Hm... I don't know that one. " \
      "Choose '1' to play again or '2' to exit."
    )
    retry
  end

  def invite_player_to_another_game
    PrettyDisplay.puts_pause(
      'Would you like to play again? (1 = yes, 2 = no)', 2
    )
  end

  def play_again
    queueing_new_game = [
      "\nSweet! Queueing up a new game...\n\n",
      "\nYou already know how to play, so we'll get to it!\n\n",
      "Do you want to set the code or break the code?\n\n",
      "(1 = set the code, 2 = break the code)\n\n"
    ]

    PrettyDisplay.print_animated_texts(queueing_new_game)

    PlayMasterMind.new.begin_new_game
  end

  def exit_game
    PrettyDisplay.puts_pause("\nok, another time then!")
    exit
  end

  def answer
    gets.chomp
  end
end
