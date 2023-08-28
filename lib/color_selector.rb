require './lib/pretty_display'
require './lib/play_mastermind'
require 'pry-byebug'

class ColorSelector
  
  def initialize(code_maker, code_breaker, difficulty=:standard, guesses_left=12)
    @@difficulty = difficulty
    @guesses_left = guesses_left
    @@code_maker = code_maker
    @@code_breaker = code_breaker
    @@color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
  end



  def color_bank
    if @@difficulty == :easy
      @@color_bank.slice(0..4)
    else
      @@color_bank
    end
    # case @@difficulty
    # when :easy
    #   @@color_bank = @@color_bank.shuffle.slice(0..4)
    # else
    #   @@color_bank
    # end

  end

  def guesses_left
    @guesses_left
  end

  def difficulty
    difficulty
  end

  def get_code
    case @@code_maker
    when :computer
      Computer.new(guesses_left).set_code
    when :player
      Player.new(guesses_left).set_code
    end
  end

  def break_code(guesses_left)
    case @@code_breaker
    when :computer
      Computer.new(guesses_left).break_code
    when :player
      Player.new(guesses_left).break_code
    end
  end

  def show_color_bank
    print "\nColors to choose from: \n>> | "
    color_bank.each do |color|
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

    def color_bank
      super
    end

    def set_code
      select_colors
    end

    def break_code
      show_color_bank
      select_colors
    end

    def select_colors
      selected_colors = []
      4.times do
        selected_colors << color_bank.shuffle.last
      end
      selected_colors
    end

    def show_color_bank
      super
    end
  end

  class Player < ColorSelector
    def initialize(guesses_left)
      @guesses_left = guesses_left
      @selected_colors = []
      @color_counter = 0
    end

    def set_code
      Player.new(guesses_left).select_colors
    end

    def color_bank
      super
    end

    def show_color_bank
      super
    end

    def guesses_left
      @guesses_left
    end

    def print_guesses_left
      if guesses_left == 0
        "This is your last guess. Make it count!"
      else
        "You have #{guesses_left} guesses left."
      end
    end

    def round
      12 - guesses_left
    end

    def break_code
      PrettyDisplay.puts_pause("*** Round #{round} - #{print_guesses_left}")
      Player.new(guesses_left).select_colors
    end

    def select_colors
      show_color_bank
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
      formatted_color = format_color(color)
      if validate_color?(formatted_color)
        @selected_colors << get_full_color_name(formatted_color)
      else
        PrettyDisplay.puts_pause("Hm, I don't know that one. Please choose an available color. The first 3 letters should be enough!")
        select_color(color)
      end
    end


    def get_full_color_name(color)
      color_bank.each do |bank_color|
        if bank_color.match?(color.slice(0..2)) || bank_color.to_s.chars.sort == color.to_s.chars.sort
          return bank_color
        end
      end
    end

    def validate_color?(color)
      color_bank.any? do |bank_color|
        if color.length >= 3
          bank_color.match?(color.slice(0..2)) || bank_color.to_s.chars.sort == color.to_s.chars.sort
        end
      end
    end

    def tell_user_to_select_color
      print "#{PrettyDisplay.animated_elipses}select a color for 'place' #{@color_counter + 1}: "
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end
  end
end
