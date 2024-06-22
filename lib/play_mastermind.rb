# frozen_string_literal: true

require 'pry-byebug'

require_relative 'color_selector'
require_relative 'difficulty'
require_relative 'end_game'
require_relative 'game_intro'
require_relative 'pretty_display'
require_relative 'spy_role'

# Responsible for actual game play logic
class PlayMasterMind
  attr_reader :remaining_guesses

  def self.play_new_game
    GameIntro.run_intro
    PrettyDisplay.puts_pause('Do you want to set the code or break the code?', 2)
    PrettyDisplay.puts_pause('(1 = set the code, 2 = break the code)', 2)
    new.begin_new_game
  end

  def initialize(guesses_remaining = 12)
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
    partly_correct = 0
    (0...@code_length).to_a.each do |place|
      if fully_correct_guess?(place)
        correct += 1
      elsif partly_correct_guess?(place)
        partly_correct += 1
      end
    end

    score_turn(correct, partly_correct)
    print_code
    print_score
    PrettyDisplay.puts_pause("\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^", 3, 0.3)

    EndGame.declare_winner(remaining_guesses) if correct == @code_length
  end

  def print_code
    print '>>>>>>> You guessed: >> | '
    color_print_guessed_code
    print " <<\n"
  end

  def color_print_guessed_code
    @guessed_code.each do |color|
      PrettyDisplay.color_text(color)
    end
  end

  def print_score
    print_fully_correct_score
    print_partly_correct_score
  end

  def print_fully_correct_score
    PrettyDisplay.puts_pause(
      "\n >> Black: #{@score[:fully_correct_placement]} | "\
      'space(s) with the RIGHT color'
    )
  end

  def print_partly_correct_score
    PrettyDisplay.puts_pause(
      " >> White: #{@score[:partly_correct_placement]} | " \
      'space(s) with partly_correct color / but you do need this color'
    )
  end

  def fully_correct_guess?(place)
    @guessed_code[place] == @encode_colors[place]
  end

  def partly_correct_guess?(place)
    @encode_colors.any?(@guessed_code[place])
  end

  def score_turn(correct, partly_correct)
    @score = {
      fully_correct_placement: correct.to_s,
      partly_correct_placement: partly_correct.to_s
    }
  end

  def guess_code
    @guessed_code = @color_selector.break_code(@remaining_guesses)
  end
end
