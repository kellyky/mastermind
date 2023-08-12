require './lib/mastermind'
require 'pry-byebug'

class Role
  def self.determine_roles
    puts "\n"
    puts "=============================================================="
    puts "\n"
    sleep(0.2)
    print "     >>>>>>>>>>     "
    print "Welcome to Mastermind!" 
    print "     <<<<<<<<<<     "
    puts "\n"
    sleep(0.2)
    puts "\n"
    sleep(0.2)
    print "."
    sleep(0.2)
    print "."
    sleep(0.2)
    print "."
    print "a text-based version of the classic 2-player code-breaking game, " 
    puts "\nwhere 1 player sets a code, and the other player attempts to break it."
    sleep(0.2)
    puts "\n"
    puts "In this version, you play against the computer."
    sleep(0.2)
    sleep(0.2)
    puts "\n"
    puts "Do you want to set the code or break the code?"
    sleep(0.2)
    print "(1 = set the code, 2 = break the code, 3 = test mode)"
    puts "\n"
    sleep(0.2)
    puts "\n"
    sleep(0.2)
    answer = gets.chomp
    case answer
    when "1"
      puts "\n"
      sleep(0.2)
      puts "code maker it is! You set the code and the computer will try to break it."
      sleep(0.2)
      puts "\n"
      @code_maker = :player
      @code_breaker = :computer
    when "2"
      puts "\n"
      sleep(0.2)
      puts "code breaker it is! The computer sets the code and you try to break it."
      puts "\n"
      sleep(0.2)
      puts "Before we get started, these are the colors to choose from:"
      puts "\n"
      sleep(0.2)
      @code_maker = :computer
      @code_breaker = :player
    when "3"
      puts "\n"
      sleep(0.2)
      puts "test mode it is! The computer plays both parts"
      @code_maker = :computer
      @code_breaker = :computer
    else
      "something I guess"
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end
end
