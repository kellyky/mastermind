require './lib/play_mastermind'
require './lib/game_intro'
require './lib/pretty_display'

require 'pry-byebug'

class SpyRole
  attr_reader :code_breaker, :code_maker
  def initialize
    @code_breaker = :player
    @code_maker = :computer
  end

  def assign_roles
    begin
      player_choice = player_answer

      case player_choice
      when '1' then computer_code_breaker
      when '2' then player_code_breaker
      else
        raise "\n\n#{player_choice} is not one of the choices. Please enter either '1' to set the code or '2' to break the code."
      end
    rescue StandardError => e
      puts e.message
      retry
    end

    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def player_answer
    # abstracted out to make it easier to write the test coverage
    gets.chomp
  end

  def computer_code_breaker
    PrettyDisplay.animated_text("\ncode maker it is! First, you'll be prompted to create a 4-item code, 1 color at a time. \nThen, the computer will try to break it.\n\n")
    @code_maker = :player
    @code_breaker = :computer
  end

  def player_code_breaker
    PrettyDisplay.puts_pause("\ncode breaker it is! The computer has created a 4-'place' code. \nYOUR goal is to crack a 4-color code set by the computer.", 2)
  end
end
