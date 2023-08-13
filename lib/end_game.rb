require './lib/pretty_display'
require './lib/mastermind'
require 'pry-byebug'

class EndGame
  def self.we_have_a_winner
    puts "whoohoo, you win, you codebreaker, you!!!"
    sleep(0.2)
    self.play_again?
  end

  def self.better_luck_next_time(colors)
    # puts "The code was #{colors}"
    print ">> The code was: >> | "
    colors.each do |color|
      print "#{color.to_s} | "
    end
    print " <<\n"
    puts "\n\n"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"


    sleep(0.2)
    self.play_again?
  end

  def self.play_again?
    print "\n\n."
    sleep(0.2)
    print "."
    sleep(0.2)
    print "."
    print "Select 1 to play again and any other alphanumeric key to quit.\n\n"
    sleep(0.2)
    answer = gets.chomp
    if answer == "1"
      new_game = PlayMasterMind.new(12)
      new_game.play_game(12)
    else
      "ok, another time then!"
      sleep(0.2)
      exit
    end
  end
end