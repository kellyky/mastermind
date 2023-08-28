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
    PrettyDisplay.puts_pause("Would you like to play standard difficulty or a slightly easier version of the game?")
    PrettyDisplay.puts_pause("(1 = standard difficulty, 2 = easy mode)", 2)
  end

  def evaluate_choice
    case @answer
    when "1"
      standard_mode
    when "2"
      easy_mode
    else
      PrettyDisplay.puts_pause("\nHm, I don't know that one.... Alrighty, I'll surprise you!", 2)
      mode = [:easy, :standard].shuffle.last
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

  def surprise_mode(mode)
    case mode
    when :easy
      easy_mode
    when :standard
      standard_mode
    end
  end
end
