require './lib/decrement_guess'
require './lib/keys'
require './lib/end_game'
require './lib/role'
require './lib/color_selector'
require 'pry-byebug'

class PlayMasterMind
  def initialize(guesses_remaining=12)
    @guesses_remaining = guesses_remaining
  end

  def start_new_game
    @game_roles = Role.determine_roles
    set_code
  end

  def set_code
    @encoded_colors ||= if @game_roles[:code_maker] == :computer
      ComputerColorSelector.set_code
    else
      PlayerColorSelector.set_code
    end
  end

  # I think this can stay as-is regardless of roles
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

    puts "\nyour score: #{score}"
    puts "you guessed #{@guessed_code}"
    EndGame.we_have_a_winner if red == 4
  end

  def merits_red_peg?(place)
    @guessed_code[place] == @encoded_colors[place]
  end

  def merits_white_peg?(place)
    @encoded_colors.any?(@guessed_code[place])
  end

  def score
    { red: "#{@rating.red}", white: "#{@rating.white}" }
  end

  def get_rating(red, white)
    @rating = Keys.new(red, white)
  end
  
  def guess_code
    @guessed_code = PlayerColorSelector.player_attempts_to_break_the_code
  end
end
