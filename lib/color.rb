require './lib/mastermind'
require 'pry-byebug'

class ComputerColorSelector
  COLOR_BANK = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]

  def self.set_code
    colors = []
    4.times do
      colors << COLOR_BANK.shuffle.last
    end
    # colors
    [:red, :red, :orange, :yellow]  # for testing. Otherwise uncomment colors and remove this line
  end

  # def self.player
end

class PlayerColorSelector
  def self.player_attempts_to_break_the_code
    puts "pick 4 colors"
    counter = 0
    colors = []
    until colors.count == 4
      puts "state your choice for color #{counter + 1}."
      color = gets.chomp
      colors << color.strip.to_sym
      counter += 1
    end
    colors
  end

  def self.set_code
    puts "Time to set the code."
    puts "pick 4 colors"
    counter = 0
    colors = []
    until colors.count == 4
      puts "state your choice for color #{counter + 1}."
      color = gets.chomp
      colors << color.strip.to_sym
      counter += 1
    end
    puts "Here's the code you set: #{colors}"
    colors
  end
end