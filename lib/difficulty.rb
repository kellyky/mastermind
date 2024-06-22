require 'pry-byebug'

require_relative 'color_selector'
require_relative 'play_mastermind'
require_relative 'pretty_display'

class Difficulty
  MODES = {
    '1' => :standard,
    '2' => :easy,
    '3' => :beginner
  }

  def self.assign
    print_difficulty_message
    new.set_mode
  end

  def self.print_difficulty_message
    PrettyDisplay.puts_pause('Would you like to play standard difficulty or a slightly easier version of the game?', 2)
    PrettyDisplay.puts_pause('1 = standard mode: break a 4-color code with 7 possible colors')
    PrettyDisplay.puts_pause('2 = easy mode: break a 4-color code with 5 possible colors')
    PrettyDisplay.puts_pause('3 = beginner mode: break a 2-color code with 4 possible colors', 2)
  end

  def initialize
    @mode = :standard
  end

  def set_mode
    update_difficulty(player_choice)
    @mode
  end

  def player_choice
    gets.chomp
  end

  def update_difficulty(choice)
    send("#{MODES[choice]}_mode")
  rescue StandardError => e
    PrettyDisplay.puts_pause("\nHm, I don't know that one.... ", 2)
    Difficulty.assign
  end

  def standard_mode
    PrettyDisplay.puts_pause("\nStandard mode it is! You'll have all 7 colors of the rainbow to choose from.", 3)
  end

  def easy_mode
    PrettyDisplay.puts_pause("\nEasy mode it is. You've got this!!", 3)
    @mode = :easy
  end

  def beginner_mode
    PrettyDisplay.puts_pause("\nbeginner mode it is! You'll break a code of 2 colors, and you 5.", 2)
    PrettyDisplay.puts_pause("You've got this!!", 3)
    @mode = :beginner
  end
end
