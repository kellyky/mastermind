require './lib/mastermind'
require 'pry-byebug'

class ColorSelector
  def initialize(code_maker)
    @@code_maker = code_maker
    @@color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
  end

  def get_code
    if @@code_maker == :computer
      Computer.new.set_code
    else
      Player.new.set_code
    end
  end

  def break_code
    if @@code_maker == :computer
      Player.break_code
    else
      Computer.new.break_code
    end
  end

  def colors
    @@color_bank
  end
  
  class Computer < ColorSelector
    def initialize
    end

    def set_code
      select_colors
    end

    def break_code
      select_colors
    end

    def select_colors
      puts ">>>>>>>>>>>>>>>>>>>>>>"
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
