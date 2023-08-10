require './lib/mastermind'
require 'pry-byebug'

class ColorSelector
  def initialize(role)
    @role = role
  end

  def get_code
    if @role == :computer
      Computer.new.set_code
    else
      Player.new.set_code
    end
  end

  class Computer
    def initialize
      @color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]
    end

    def set_code
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
    def initialize; end

    def set_code
      puts "Time to set the code.\n"
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
  end
end