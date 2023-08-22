require './lib/play_mastermind'
require './lib/game_intro'
require './lib/pretty_display'

require 'pry-byebug'

# TODO rename class, I don't like SpyRole. Maybe CodeBreaker...
# TODO refactor - do we want to keep these all as class methods?
class SpyRole
  def self.set_codebreaker
    PrettyDisplay.puts_pause("Do you want to set the code or break the code?", 2)
    PrettyDisplay.puts_pause("(1 = set the code, 2 = break the code)", 2)

    answer = gets.chomp
    self.evaluate_choice(answer)
  end

  def self.evaluate_choice(choice)
    case choice
    when "1"
      self.computer_code_breaker
    when "2"
      self.player_code_breaker
    when "3"
      self.test_mode
    else
      PrettyDisplay.puts_pause("\nHm, I don't have a game mode for that. Let's try that again.")
      self.set_codebreaker
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def self.computer_code_breaker
    PrettyDisplay.animated_text("\ncode maker it is! First, you'll be prompted to create a 4-item code, 1 color at a time. \nThen, the computer will try to break it.\n\n")
    @code_maker = :player
    @code_breaker = :computer
  end

  def self.player_code_breaker
    PrettyDisplay.puts_pause("\ncode breaker it is! The computer has created a 4-'place' code. \nYOUR goal is to crack a 4-color code set by the computer.", 2)
    @code_maker = :computer
    @code_breaker = :player
  end

  def self.test_mode
    PrettyDisplay.puts_pause("\ntest mode it is! The computer plays both parts\n")
    @code_maker = :computer
    @code_breaker = :computer
  end
end
