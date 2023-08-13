require './lib/pretty_display'

class GameIntro
  def self.welcome
    PrettyDisplay.new_line_pause(0,1)
    puts "=============================================================="
    PrettyDisplay.new_line_pause
    print "     >>>>>>>>>>     Welcome to Mastermind!     <<<<<<<<<<     "
    PrettyDisplay.new_line_pause(0.2, 2)
    print "#{PrettyDisplay.animated_elipses}a text-based version of the classic 2-player code-breaking game, " 
    puts "\nwhere 1 player sets a code, and the other player attempts to break it."
    PrettyDisplay.new_line_pause
    puts "In this version, you play against the computer."
    PrettyDisplay.new_line_pause(0.4)
  end
end