require './lib/mastermind'
require 'pry-byebug'

class Role
  def self.determine_roles
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
    sleep(0.2)
    self.new_line_pause
    puts "Do you want to set the code or break the code?"
    sleep(0.2)
    print "(1 = set the code, 2 = break the code, 3 = test mode)"
    self.new_line_pause
    self.new_line_pause
    answer = gets.chomp

    case answer
    when "1"
      self.new_line_pause
      puts "code maker it is! You set the code and the computer will try to break it."
      self.new_line_pause
      @code_maker = :player
      @code_breaker = :computer
    when "2"
      self.new_line_pause
      puts "code breaker it is! The computer sets the code and you try to break it."
      self.new_line_pause
      puts "Before we get started, these are the colors to choose from:"
      self.new_line_pause
      @code_maker = :computer
      @code_breaker = :player
    when "3"
      self.new_line_pause
      puts "test mode it is! The computer plays both parts"
      @code_maker = :computer
      @code_breaker = :computer
    else
      "something I guess"
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end

  def self.animated_elipses
    print "."
    sleep(0.2)
    print "."
    sleep(0.2)
    print "."
  end

  def self.new_line_pause(seconds=0.2)
    puts "\n"
    sleep(seconds)
  end
end
