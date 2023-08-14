require './lib/pretty_display'
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
      Computer.new(guesses_left).set_code
    when :player
      Player.new.set_code
    end
  end

  def break_code(guesses_left)
    case @@code_breaker
    when :computer
      Computer.new(guesses_left).break_code
    when :player
      Player.break_code
    end
  end

  def show_color_bank
    print "\nColors to choose from: \n>> | "
    @@color_bank.each do |color|
      print "#{color.to_s} | "
    end
    print " <<\n\n\n"
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
      show_color_bank

      selected_colors = []
      4.times do
        selected_colors << @@color_bank.shuffle.last
      end
      selected_colors
    end

    def show_color_bank
      super
    end
  end

  class Player < ColorSelector
    def initialize
      @selected_colors = []
      @color_counter = 0
    end

    def set_code
      PrettyDisplay.animated_text("You can repeat colors if you'd like, but be sure to choose colors the computer knows. \n")
      PrettyDisplay.animated_text("You can type just the first 3 letters of the color - I'll understand! :D\n\n")

      show_color_bank
      Player.new.select_colors
    end

    def show_color_bank
      super
    end

    def self.break_code
      Player.new.select_colors
    end

    def select_colors
      until @selected_colors.count == 4
        select_color
        @color_counter += 1
      end
      @selected_colors
    end

    def select_color(color = "")
      tell_user_to_select_color
      color = gets.chomp
      puts ""
      # PrettyDisplay.new_line_pause
      formatted_color = format_color(color)
      if validate_color?(color)
        @selected_colors << get_full_color_name(formatted_color)
      else
        PrettyDisplay.puts_pause("Please choose an available color. The first 3 letters should be enough!")
        # puts "Please choose an available color. The first 3 letters should be enough!"
        select_color(color)
      end
    end


    def get_full_color_name(color)
      @@color_bank.each do |bank_color|
        if bank_color.match?(color.slice(0..2)) || bank_color.to_s.chars.sort == color.to_s.chars.sort
          return bank_color
        end
      end
    end

    def validate_color?(color)
      @@color_bank.any? do |bank_color|
        color.match?(bank_color.slice(0..2)) || bank_color.to_s.chars.sort == color.to_s.chars.sort
      end
    end

    def tell_user_to_select_color
      print "#{PrettyDisplay.animated_elipses}state your choice for color #{@color_counter + 1}: "
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end
  end
end
