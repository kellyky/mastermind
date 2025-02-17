# frozen_string_literal: true

require_relative 'color_selector'
require_relative 'difficulty'
require_relative 'end_game'
require_relative 'game_intro'
require_relative 'pretty_display'
require_relative 'score'
require_relative 'spy_role'

# Responsible for game play logic
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
    score_turn
    check_for_winner
    play_game
  end

  def score_turn
    @turn_score ||= Score.new(@code_length, @guessed_code, @encode_colors)
    @turn_score.parse_guesses
    @turn_score.print_score
  end

  def check_for_winner
    EndGame.declare_winner(@remaining_guesses) if @turn_score.wins_game?
  end

  def guess_code
    @guessed_code = @color_selector.break_code(@remaining_guesses)
  end
end
