require './lib/mastermind'
require 'pry-byebug'

class ColorSelector
  def initialize(code_maker, code_breaker, guesses_left=12)
    @guesses_left = guesses_left
    @@code_maker = code_maker
    @@code_breaker = code_breaker
    @@color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
  end

  def guesses_left
    @guesses_left
  end

  def get_code
    case @@code_maker
    when :computer
      c = Computer.new(guesses_left)
      .set_code
    when :player
      Player.new.set_code
    end
  end

  def break_code(guesses_left)
    case @@code_breaker
    when :computer
      c = Computer.new(guesses_left)
      c.break_code
    when :player
      Player.break_code
    end
  end

  class Computer < ColorSelector
    def initialize(guesses_left)
      @guesses_left = guesses_left
    end

    def guesses_left
      super
    end

    def set_code
      select_colors
    end

    def break_code
      select_colors
    end

    def select_colors
      puts ">>>>>>>>>>>>>>>>>>>>>>"
      puts "#{guesses_left} guess left"
      puts "Colors to choose from: #{@@color_bank}"
      puts ">>>>>>>>>>>>>>>>>>>>>>"

      selected_colors = []
      4.times do
        selected_colors << @@color_bank.shuffle.last
      end
      selected_colors
    end
  end

  class Player < ColorSelector
    def initialize
    end

    def set_code
      puts "You can repeat colors if you'd like,"
      sleep(0.2)
      puts "but please choose from colors the computer knows: :D"
      sleep(0.2)
      puts "#{colors}"
      sleep(0.2)
      Player.new.set_colors
    end

    def self.break_code
      Player.new.guess_colors
    end

    def set_colors
      counter = 0
      selected_colors = []
      until selected_colors.count == 4
        tell_user_to_select_color(counter)
        color = gets.chomp
        formatted_color = format_color(color)
        if !@@color_bank.include?(formatted_color )
          @@color_bank << formatted_color
        end
        selected_colors << formatted_color
        counter += 1
      end
      selected_colors
    end

    def guess_colors  # might re-combine later? the difference is whether colors can be added
      counter = 0
      selected_colors = []
      until selected_colors.count == 4
        tell_user_to_select_color(counter)
        color = gets.chomp
        formatted_color = format_color(color)
        selected_colors << formatted_color
        counter += 1
      end
      selected_colors
    end

    def tell_user_to_select_color(counter)
      puts "state your choice for color #{counter + 1}."
      sleep(0.2)
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end
  end
end
