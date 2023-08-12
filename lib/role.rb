require './lib/mastermind'
require 'pry-byebug'

# TODO rename class, I don't like Role. Maybe CodeBreaker...
# TODO refactor - do we want to keep these all as class methods?
class Role
  # TODO Refactor - consider NewGame or similar class for this method
  # Picking codemaker doesn't need to know about the welcome text
  def self.welcome_to_mastermind
    puts "\n"
    puts "=============================================================="
    self.new_line_pause
    print "     >>>>>>>>>>     Welcome to Mastermind!     <<<<<<<<<<     "
    self.new_line_pause
    self.new_line_pause
    print "#{self.animated_elipses}a text-based version of the classic 2-player code-breaking game, " 
    puts "\nwhere 1 player sets a code, and the other player attempts to break it."
    self.new_line_pause
    puts "In this version, you play against the computer."
    self.new_line_pause(0.4)
    self.determine_roles
  end

  def self.determine_roles
    puts "Do you want to set the code or break the code?"
    pause
    print "(1 = set the code, 2 = break the code, 3 = test mode)"
    self.new_line_pause
    self.new_line_pause

    answer = gets.chomp

    case answer
    when "1"
      self.computer_code_breaker
    when "2"
      self.player_code_breaker
    when "3"
      self.test_mode
    else
      "TODO: add validation of some sort"
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def self.computer_code_breaker
    self.new_line_pause
    puts "code maker it is! You set the code and the computer will try to break it."
    self.new_line_pause
    @code_maker = :player
    @code_breaker = :computer
  end

  def self.player_code_breaker
    self.new_line_pause
    puts "code breaker it is! The computer sets the code and you try to break it."
    self.new_line_pause
    puts "Before we get started, these are the colors to choose from:"
    self.new_line_pause
    @code_maker = :computer
    @code_breaker = :player
  end

  def self.test_mode
    self.new_line_pause
    puts "test mode it is! The computer plays both parts"
    @code_maker = :computer
    @code_breaker = :computer
  end

  # TODO Refactor to move formatting / prettying methods 
  def self.animated_elipses
    print "."
    pause
    print "."
    pause
    print "."
  end

  def self.new_line_pause(seconds=0.2)
    puts "\n"
    sleep(seconds)
  end

  def self.pause(seconds=0.2)
    sleep(seconds)
  end
end
