require './lib/mastermind'
require './lib/role'
require 'pry-byebug'

class GameIntro
  def self.welcome
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
    Role.set_codebreaker
  end

  def self.new_line_pause(seconds=0)
    puts "\n"
    sleep(seconds)
  end

  def self.pause(seconds=0)
    sleep(seconds)
  end

  def self.animated_elipses
    print "."
    pause
    print "."
    pause
    print "."
  end
end