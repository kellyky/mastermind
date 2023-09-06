require './lib/play_mastermind'
require './lib/pretty_display'
require './lib/color_selector'
require 'pry-byebug'

class Difficulty
  def initialize(mode=:standard)
    @mode = mode  # I think unnecessary
  end

  def set_mode
    print_difficulty_message
    @answer ||= gets.chomp
    evaluate_choice
  end

  def print_difficulty_message
    PrettyDisplay.puts_pause("Last question before we start:", 2)
    PrettyDisplay.puts_pause("Would you like to play standard difficulty or a slightly easier version of the game?", 2)
    PrettyDisplay.puts_pause("1 = standard mode: break a 4-color code with 7 possible colors")
    PrettyDisplay.puts_pause("2 = easy mode: break a 4-color code with 5 possible colors")
    PrettyDisplay.puts_pause("3 = beginner mode: break a 2-color code with 4 possible colors", 2)
  end

  def evaluate_choice
    case @answer
    when "1"
      standard_mode
    when "2"
      easy_mode
    when "3"
      beginner_mode
    else
      PrettyDisplay.puts_pause("\nHm, I don't know that one.... Alrighty, I'll surprise you!", 2)
      mode = [:easy, :standard, :beginner].shuffle.last
      surprise_mode(mode)
    end
  end

  def standard_mode
    PrettyDisplay.puts_pause("\nStandard mode it is! You'll have all 7 colors of the rainbow to choose from.", 3)
    @mode = :standard
  end

  def easy_mode
    PrettyDisplay.puts_pause("\nEasy mode it is! Instead of 7 possible colors to choose from, there are only 5.", 2)
    PrettyDisplay.puts_pause("You've got this!!", 3)
    @mode = :easy
  end

  def beginner_mode
    PrettyDisplay.puts_pause("\nbeginner mode it is! You'll break a code of 2 colors, and you 5.", 2)
    PrettyDisplay.puts_pause("You've got this!!", 3)
    @mode = :beginner
  end

  def surprise_mode(mode)
    case mode
    when :easy
      easy_mode
    when :standard
      standard_mode
    when :beginner
      beginner_mode
    end
  end
end
