require './lib/keys'
require './lib/pretty_display'
require './lib/game_intro'
require './lib/end_game'
require './lib/role'
require './lib/color_selector'
require 'pry-byebug'

class PlayMasterMind
  def initialize(guesses_allowed)
    @guesses_allowed = guesses_allowed
    @remaining_guesses = guesses_allowed
  end

  def start_new_game
    GameIntro.welcome
    GameIntro.rules
    @game_roles = Role.set_codebreaker
    @color_selector = ColorSelector.new(code_maker, code_breaker)
    @encoded_colors ||= ColorSelector.new(code_maker, code_breaker).get_code
  end

  def code_maker
    @game_roles[:code_maker]
  end

  def code_breaker
    @game_roles[:code_breaker]
  end

  def play_game(guesses_remaining)
    if guesses_remaining == @guesses_allowed
      start_new_game
    end
    if guesses_remaining > 0
      play_turn(guesses_remaining)
    else
      EndGame.new(@guesses_remaining, @encoded_colors).better_luck_next_time
    end
  end

  def play_turn(guesses_remaining)
    @remaining_guesses -= 1
    guess_code
    evaluate_guess
    play_game(@remaining_guesses)
  end

  def evaluate_guess
    correct, wrong = [0, 0]
    for place in (0...4)
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

    EndGame.new(remaining_guesses).we_have_a_winner if correct == 4
  end

  def print_code
    print ">>>>>>> You guessed: >> | "
    @guessed_code.each do |color|
      print "#{color.to_s} | "
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
    @rating = Keys.new(correct, wrong)
  end
  
  def remaining_guesses
    @remaining_guesses
  end

  def guess_code
    @guessed_code = @color_selector.break_code(@remaining_guesses)
  end
end
