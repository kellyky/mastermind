require './lib/mastermind'
require './lib/game_intro'
require './lib/pretty_display'

require 'pry-byebug'

# TODO rename class, I don't like Role. Maybe CodeBreaker...
# TODO refactor - do we want to keep these all as class methods?
class Role
  def self.set_codebreaker
    puts "Do you want to set the code or break the code?"
    PrettyDisplay.pause
    print "(1 = set the code, 2 = break the code)"
    PrettyDisplay.new_line_pause
    PrettyDisplay.new_line_pause

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
      puts "Hm#{PrettyDisplay.animated_elipses} I don\'t have a game mode for that. Let\'s try that again."
      PrettyDisplay.new_line_pause
      self.set_codebreaker
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def self.computer_code_breaker
    PrettyDisplay.new_line_pause
    puts "code maker it is! You set the code and the computer will try to break it."
    PrettyDisplay.new_line_pause

    @code_maker = :player
    @code_breaker = :computer
  end

  def self.player_code_breaker
    PrettyDisplay.new_line_pause
    puts "code breaker it is! The computer sets the code and you try to break it."
    PrettyDisplay.new_line_pause
    puts "Before we get started, these are the colors to choose from:"
    PrettyDisplay.new_line_pause

    @code_maker = :computer
    @code_breaker = :player
  end

  def self.test_mode
    PrettyDisplay.new_line_pause
    puts "test mode it is! The computer plays both parts"

    @code_maker = :computer
    @code_breaker = :computer
  end
end
