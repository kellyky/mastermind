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
    # check most specific
    for place in (0...4)
      binding.pry
      if @guessed_code[place] == @encoded_colors[place]
        # best - most specific color code
        best += 1
      elsif
        @encoded_colors.any?(@guessed_code[place])
        next_best += 1
        # next best - the general color peg
      else
        # no peg; I don't think there's a peg for this one
      end

      @best = KeyPegs.new(best).fully_correct_qty
      @next_best = KeyPegs.new(next_best).partly_correct_qty
      { best: "#{@best}", next_best: "#{@next_best}" }
    end
    binding.pry
  end


  def encoded_color_1
    @encoded_color_1 ||= @encoded_colors[0]
  end

  def encoded_color_2
    @encoded_color_2 ||= @encoded_colors[1]
  end

  def encoded_color_3
    @encoded_color_3 ||= @encoded_colors[2]
  end

  def encoded_color_4
    @encoded_color_4 ||= @encoded_colors[3]
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

  # hold off for when a user sets the code
  # def initialize(color_1, color_2, color_3, color_4)
  #   @color_1 = color_1
  #   @color_2 = color_2
  #   @color_3 = color_3
  #   @color_4 = color_4
  # end

  # def set_code
  #   # computer, later the user chooses colors
  # end

  # def color_1
  #   @color_1
  # end

  # def color_2
  #   @color_2
  # end

  # def color_3
  #   @color_3
  # end

  # def color_4
  #   @color_4
  # end

  def self.all_colors
    # [@color_1, @color_2, @color_3, @color_4]
    COLOR_BANK.shuffle.first(4)
  end
end

class GuessCode
 
  # def initialize(color_1, color_2, color_3, color_4)
  #   @color_1 = color_1
  #   @color_2 = color_2
  #   @color_3 = color_3
  #   @color_4 = color_4
  # end

  # def color_1
  #   @color_1
  # end

  # def color_2
  #   @color_2
  # end

  # def color_3
  #   @color_3
  # end

  # def color_4
  #   @color_4
  # end

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

  # def all_colors
  #   [@color_1, @color_2, @color_3, @color_4]
  # end
end
