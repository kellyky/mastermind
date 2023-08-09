require 'pry-byebug'

# code for counting & tallying the guesses
class IncrementGuess
  def initialize(guess_count=0)
    @guess_count = guess_count
  end

  def increment_turn_counter
    @guess_count += 1
  end
end

class CountTurns  # rename or break up this class; it's a bit hodgepodge
  def initialize
    @encoded_colors = SetCode.all_colors
    # @guessed_colors = GuessCode.new(a, b, c, d).all_colors
  end
  

  def run_through_turns(turns_done=0)
    if turns_done <= 12
      guess_count = IncrementGuess.new(turns_done)
      next_turn = guess_count.increment_turn_counter
      @guessed_code = GuessCode.player_attempts_to_break_the_code
      assess_the_payers_attempt_to_break_the_code
      run_through_turns(next_turn)
    else
      puts "12th turn!, game over" # placeholder for end game
    end
  end

  def assess_the_payers_attempt_to_break_the_code
    best = 0
    next_best = 0
    rating = {}
    for place in (0...4)      
      if @guessed_code[place] == @encoded_colors[place]
        best += 1
      elsif
        @encoded_colors.any?(@guessed_code[place])
        next_best += 1
      else
        next
      end
    end

    rating = KeyPegs.new(best, next_best)
    score = { best: "#{rating.fully_correct_qty}", next_best: "#{rating.partly_correct_qty}" }
    puts "you guessed #{@guessed_code}; code was #{@encoded_colors}" # temp
    display_rating(score)
  end

  def display_rating(rating)
    puts rating.to_s
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
    COLOR_BANK.shuffle.first(4)
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
      colors << color.to_sym
      counter += 1
    end
    colors
  end

end
