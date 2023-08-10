require './lib/mastermind'
require 'pry-byebug'

class ColorSelector
  def initialize(code_maker)
    @@code_maker = code_maker
  end

  def get_code
    if @@code_maker == :computer
      Computer.new.set_code
    else
      Player.new.set_code
    end
  end

  def self.break_code
    binding.pry
    if @@code_maker == :computer
      Player.break_code
    else
      Computer.new.break_code
    end
  end

  class Computer
    def initialize
      @color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
    end

    def set_code
      select_colors
    end

    def break_code
      binding.pry
      Computer.new.select_colors
    end

    def select_colors
      colors = []
      4.times do
        colors << @color_bank.shuffle.last
      end
      colors
    end

    def colors
      @color_bank
    end
  end

  class Player
    def initialize 
      @color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
    end

    def set_code
      puts "You can repeat colors if you'd like,"
      puts "but please choose from colors the computer knows: :D"
      puts "#{colors}"
      Player.new.select_colors  # feels a bit off but it works
    end

    def self.break_code
      Player.new.select_colors  # feels a bit off but it works
    end

    def select_colors
      counter = 0
      colors = []
      until colors.count == 4
        puts "state your choice for color #{counter + 1}."
        color = gets.chomp
        colors << color.strip.to_sym
        counter += 1
      end
      puts "Here's what you selected: #{colors}\n"
      colors
    end

    def colors
      @color_bank
    end
  end
end