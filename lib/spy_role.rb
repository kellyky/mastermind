# frozen_string_literal: true

require 'pry-byebug'

require_relative 'game_intro'
require_relative 'play_mastermind'
require_relative 'pretty_display'

# Logic setting the code breaker and code maker (computer or player)
class SpyRole
  attr_reader :code_breaker, :code_maker

  ROLES = {
    '1' => :computer,
    '2' => :player
  }.freeze

  def initialize
    @code_breaker = :player
    @code_maker = :computer
  end

  # Assigns roles to the code maker and code breaker based on player input
  def assign_roles
    begin
      send("#{ROLES[player_answer]}_code_breaker")
    rescue NoMethodError
      PrettyDisplay.puts_pause(
        "\nPlease choose '1' to set the code or '2' to break the code.", 2
        )
      retry
    end

    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def player_answer
    gets.chomp
  end

  # Sets computer as code breacker and player as code maker
  def computer_code_breaker
    PrettyDisplay.animated_text("\nCode maker it is!\m")
    PrettyDisplay.animated_text(
      "\n\nYou'll CREATE the code then the computer will try to break it.\n\n"
      )
    @code_maker = :player
    @code_breaker = :computer
  end

  # Confirms human as code maker and computer as code breaker
  def player_code_breaker
    PrettyDisplay.puts_pause(
      "\n\nThe computer creates the code - YOU need to break the code.", 2
      )
  end
end
