require './lib/mastermind'
require 'pry-byebug'

class Role
  def self.determine_roles
    puts "Welcome to Mastermind!" 
    puts "Do you want to set the code or break the code?"
    puts "(1 = set the code, 2 = break the code, 3 = test mode)"
    answer = gets.chomp
    case answer
    when "1"
      puts "code maker it is! You set the code and the computer will try to break it."
      @code_maker = :player
      @code_breaker = :computer
    when "2"
      puts "code breaker it is! The computer sets the code and you try to break it."
      @code_maker = :computer
      @code_breaker = :player
    when "3"
      puts "test mode it is! The computer plays both parts"
      @code_maker = :computer
      @code_breaker = :computer
    else
      "something I guess"
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end
end