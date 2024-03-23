require './lib/play_mastermind'
require './lib/game_intro'
require './lib/pretty_display'

require 'pry-byebug'

class SpyRole
  attr_reader :code_breaker, :code_maker

  ROLES = {
    '1' => :computer,
    '2' => :player
  }

  def initialize
    @code_breaker = :player
    @code_maker = :computer
  end

  def assign_roles
    begin
      self.send("#{ROLES[player_answer]}_code_breaker")
    rescue NoMethodError => e
      PrettyDisplay.puts_pause("\nHm, I don't know that one. Please choose '1' to set the code or '2' to break the code.", 2)
      retry
    end

    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def player_answer
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
