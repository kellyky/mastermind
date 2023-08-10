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

      colors = []
      4.times do
        colors << @@color_bank.shuffle.last
      end
      colors
    end

    def colors
      super
    end
  end

  class Player < ColorSelector
    def initialize; end

    def set_code
      puts "You can repeat colors if you'd like,"
      sleep(0.2)
      puts "but please choose from colors the computer knows: :D"
      sleep(0.2)
      puts "#{colors}"
      sleep(0.2)
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
        sleep(0.2)
        color = gets.chomp
        colors << color.strip.downcase.to_sym
        counter += 1
      end
      colors
    end

    def colors
      super
    end
  end
end