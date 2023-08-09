require 'pry-byebug'


class PlayMasterMind
  def initialize
    @encoded_colors = SetCode.all_colors
  end
  
  def get_code_guess
    @guessed_code = GuessCode.player_attempts_to_break_the_code
  end

  def run_through_turns(turns_done=0)
    if turns_done <= 12
      guess_count = IncrementGuess.new(turns_done)
      next_turn = guess_count.increment_turn_counter
      get_code_guess
      assess_the_payers_attempt_to_break_the_code
      run_through_turns(next_turn)
    else
      EndGame.better_luck_next_time
    end
  end

  def assess_the_payers_attempt_to_break_the_code
    best, next_best = [0, 0]
    rating = {}
    for index in (0...4)
      if @guessed_code[index] == @encoded_colors[index]
        best += 1
      elsif
        @encoded_colors.any?(@guessed_code[index])
        next_best += 1
      else
        next
      end
    end

    rating = KeyPegs.new(best, next_best)
    puts "you guessed #{@guessed_code}"
    score = { best: "#{rating.fully_correct_qty}", next_best: "#{rating.partly_correct_qty}" }
    puts "your score: #{score}"
    EndGame.we_have_a_winner if best == 4
  end
end

class IncrementGuess
  def initialize(guess_count=0)
    @guess_count = guess_count
  end

  def increment_turn_counter
    @guess_count += 1
  end
end

class KeyPegs
  def initialize(fully_correct_qty=0, partly_correct_qty=0)
    @fully_correct_qty = fully_correct_qty
    @partly_correct_qty = partly_correct_qty
  end

  def fully_correct_qty
    @fully_correct_qty
  end

  def partly_correct_qty
    @partly_correct_qty
  end
end

class SetCode
  COLOR_BANK = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]

  def self.all_colors
    colors = []
    4.times do
      colors << COLOR_BANK.shuffle.last
    end
    # colors
    [:red, :red, :orange, :yellow]  # for testing. Otherwise uncomment colors and remove this line
  end
end

class GuessCode
  def self.player_attempts_to_break_the_code
    puts "pick 4 colors"
    counter = 0
    colors = []
    until colors.count == 4
      puts "state your choice for color #{counter + 1}."
      color = gets.chomp
      colors << color.strip.to_sym
      counter += 1
    end
    colors
  end
end

class EndGame
  def self.we_have_a_winner
    puts "whoohoo!!!"
    exit
  end

  def self.better_luck_next_time
    puts "Your 12 turns are up. Better luck next time!"
    exit
  end
end
