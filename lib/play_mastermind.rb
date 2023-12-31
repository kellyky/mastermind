require './lib/score'
require './lib/pretty_display'
require './lib/game_intro'
require './lib/end_game'
require './lib/spy_role'
require './lib/color_selector'
require './lib/difficulty'
require 'rainbow'
require 'pry-byebug'

class PlayMasterMind
  def initialize(guesses_allowed=12, guesses_remaining=12)
    @guesses_allowed = guesses_allowed
    @remaining_guesses = guesses_remaining
    @code_length = 4
    # @game_roles = game_roles
  end

  def start_new_game
    GameIntro.welcome
    GameIntro.rules
    @game_roles = SpyRole.set_codebreaker
    set_game_difficulty if @game_roles[:code_breaker] == :player
    update_code_length if @difficulty == :beginner
    @color_selector = ColorSelector.new(code_maker, code_breaker, @difficulty, @code_length, remaining_guesses)
    set_encoded_colors

  end

  def update_code_length
    @code_length = 2
  end

  def set_encoded_colors
    @encoded_colors ||= @color_selector.get_code
  end

  def set_game_difficulty
    @difficulty = Difficulty.new.set_mode
  end

  def code_maker
    @game_roles[:code_maker]
  end

  def code_breaker
    @game_roles[:code_breaker]
  end

  def remaining_guesses
    @remaining_guesses
  end

  def play_game
    if @remaining_guesses == @guesses_allowed
      start_new_game
    end
    if @remaining_guesses > 0
      play_turn(@remaining_guesses)
    else
      EndGame.new(@remaining_guesses, @encoded_colors).better_luck_next_time
    end
  end

  def play_turn(remaining_guesses)
    @remaining_guesses -= 1
    guess_code
    evaluate_guess
    play_game
  end

  def evaluate_guess
    correct, wrong = [0, 0]
    for place in (0...@code_length)
      if merits_correct_peg?(place)
        correct += 1
      elsif merits_wrong_peg?(place)
        wrong += 1
      end
    end

    get_rating(correct, wrong)
    print_code
    print_score
    PrettyDisplay.puts_pause("\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^", 3, 0.3)

    EndGame.new(remaining_guesses).we_have_a_winner if correct == @code_length
  end

  def print_code
    print ">>>>>>> You guessed: >> | "
    @guessed_code.each do |color|
      PrettyDisplay.color_text(color)
    end
    print " <<\n"
  end

  def print_score
    PrettyDisplay.puts_pause("\n >> Black: #{score[:right_placement]} - i.e. #{score[:right_placement]} space(s) have the RIGHT color in its space")
    PrettyDisplay.puts_pause(" >> White: #{score[:wrong_placement]} - i.e. #{score[:wrong_placement]} space(s) have the WRONG color - BUT the color does belong somewhere else in the code")
  end

  def merits_correct_peg?(place)
    @guessed_code[place] == @encoded_colors[place]
  end

  def merits_wrong_peg?(place)
    @encoded_colors.any?(@guessed_code[place])
  end

  def score
    @score = { right_placement: "#{@rating.correct_place}", wrong_placement: "#{@rating.wrong_place}" }
  end

  def get_rating(correct, wrong)
    @rating = Score.new(correct, wrong)
  end
  
  def remaining_guesses
    @remaining_guesses
  end

  def guess_code
    @guessed_code = @color_selector.break_code(@remaining_guesses)
  end
end
