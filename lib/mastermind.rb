require './lib/decrement_guess'
require './lib/keys'
require './lib/end_game'
require './lib/role'
require './lib/color_selector'
require 'pry-byebug'

class PlayMasterMind
  def initialize(guesses_remaining)
    @guesses_remaining = guesses_remaining
  end

  def start_new_game
    @game_roles = Role.determine_roles
    @color_selector = ColorSelector.new(code_maker)
    @encoded_colors ||= ColorSelector.new(code_maker).get_code
  end

  def code_maker
    @game_roles[:code_maker]
  end

  def play_game(guesses_remaining)
    if guesses_remaining == @guesses_remaining
      start_new_game
    end
    if guesses_remaining > 0
      play_turn(guesses_remaining)
    else
      EndGame.better_luck_next_time
    end
  end

  def play_turn(guesses_remaining)
    guess_count = DecrementGuess.new(guesses_remaining)
    next_turn = guess_count.decrement_turn_counter
    guess_code
    evaluate_guess
    play_game(next_turn)
  end

  def evaluate_guess
    red, white = [0, 0]
    for place in (0...4)
      if merits_red_peg?(place)
        red += 1
      elsif merits_white_peg?(place)
        white += 1
      end
    end

    get_rating(red, white)

    sleep(0.5)
    puts "\n======================\n"
    puts "\nyour score: #{score}"
    puts "you guessed #{@guessed_code}"
    puts "\n======================\n"
    sleep(0.5)

    nil_score?

    EndGame.we_have_a_winner if red == 4
  end

  def merits_red_peg?(place)
    @guessed_code[place] == @encoded_colors[place]
  end

  def merits_white_peg?(place)
    @encoded_colors.any?(@guessed_code[place])
  end

  def nil_score?  # working towards using this to narrow color range for computer
    @score[:red] == "0" && @score[:white] == "0"
  end

  def score
    @score = { red: "#{@rating.red}", white: "#{@rating.white}" }
  end

  def get_rating(red, white)
    @rating = Keys.new(red, white)
  end
  
  def guess_code
    @guessed_code = @color_selector.break_code
  end
end
