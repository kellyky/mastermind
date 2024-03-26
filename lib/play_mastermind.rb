# frozen_string_literal: true

require './lib/pretty_display'
require './lib/game_intro'
require './lib/end_game'
require './lib/spy_role'
require './lib/color_selector'
require './lib/difficulty'
require 'rainbow'
require 'pry-byebug'

# Responsible for actual game play logic
class PlayMasterMind
  attr_reader :remaining_guesses

  def self.play_new_game
    GameIntro.run_intro
    PrettyDisplay.puts_pause('Do you want to set the code or break the code?', 2)
    PrettyDisplay.puts_pause('(1 = set the code, 2 = break the code)', 2)
    new.begin_new_game
  end

  # def initialize(guesses_allowed = 12, guesses_remaining = 1)
  def initialize(guesses_allowed = 12, guesses_remaining = 12)
    @guesses_allowed = guesses_allowed
    @remaining_guesses = guesses_remaining
    @code_length = 4
    @spy_roles = SpyRole.new
  end

  def begin_new_game
    @spy_roles.assign_roles
    adapt_game_to_player
    @color_selector = ColorSelector.new(code_maker, code_breaker, @difficulty, @code_length, remaining_guesses)
    encode_colors
    play_game
  end

  def adapt_game_to_player
    update_difficulty if code_breaker == :player
    update_code_length if @difficulty == :beginner
  end

  def update_code_length
    @code_length = 2
  end

  def encode_colors
    @encode_colors ||= @color_selector.encode_colors
  end

  def update_difficulty
    @difficulty = Difficulty.assign
  end

  def code_maker
    @code_maker ||= @spy_roles.code_maker
  end

  def code_breaker
    @spy_roles.code_breaker
  end

  def play_game
    if @remaining_guesses.positive?
      play_turn
    else
      EndGame.declare_loser(@remaining_guesses, @encode_colors)
    end
  end

  def play_turn
    @remaining_guesses -= 1
    guess_code
    evaluate_guess
    play_game
  end

  def evaluate_guess
    correct = 0
    wrong = 0
    (0...@code_length).to_a.each do |place|
      merits_correct_peg?(place) ? correct += 1 : wrong += 1
    end

    score_turn(correct, wrong)
    print_code
    print_score
    PrettyDisplay.puts_pause("\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^", 3, 0.3)

    EndGame.declare_winner(remaining_guesses) if correct == @code_length
  end

  def print_code
    print '>>>>>>> You guessed: >> | '
    @guessed_code.each do |color|
      PrettyDisplay.color_text(color)
    end
    print " <<\n"
  end

  def print_score
    PrettyDisplay.puts_pause("\n >> Black: #{@score[:right_placement]} | space(s) with the RIGHT color")
    PrettyDisplay.puts_pause(" >> White: #{@score[:wrong_placement]} | space(s) with wrong color / but you do need this color")
    # PrettyDisplay.puts_pause("| space(s) have the WRONG color - BUT the color is in the code")
  end

  def merits_correct_peg?(place)
    @guessed_code[place] == @encode_colors[place]
  end

  def merits_wrong_peg?(place)
    @encode_colors.any?(@guessed_code[place])
  end

  def score_turn(correct, wrong)
    @score = { right_placement: correct.to_s, wrong_placement: wrong.to_s }
  end

  def guess_code
    @guessed_code = @color_selector.break_code(@remaining_guesses)
  end
end
