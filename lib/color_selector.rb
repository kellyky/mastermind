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

  def show_color_bank
    print ">> | "
    @@color_bank.each do |color|
      print "#{color.to_s} | "
    end
    print " <<\n"
    puts "\n"
  
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
    end

    def set_code
      print "You can repeat colors if you'd like,"
      sleep(0.2)
      puts "but please choose from colors the computer knows: :D"
      puts "\n"
      sleep(0.2)
      show_color_bank
      sleep(0.2)
      Player.new.select_colors
    end

    def show_color_bank
      super
    end

    def self.break_code
      Player.new.select_colors
    end

    def select_colors
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
      sleep(0.4)
      print "\n."
      sleep(0.2)
      print "."
      sleep(0.2)
      print "."
      print "state your choice for color #{counter + 1}: "
      puts "\n\n"
      sleep(0.2)
    end

    def format_color(color)
      color.strip.downcase.to_sym
    end
  end
end
