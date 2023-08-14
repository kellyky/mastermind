require './lib/pretty_display'

class GameIntro
  def self.welcome
    PrettyDisplay.puts_pause("==============================================================", 2)
    PrettyDisplay.puts_pause("     >>>>>>>>>>     Welcome to Mastermind!     <<<<<<<<<<     ", 2)
    PrettyDisplay.animated_elipses

    # v1 no animation - not sure yet which way I want to go :D
    PrettyDisplay.puts_pause("a text-based version of the classic 2-player code-breaking game, ") 
    PrettyDisplay.puts_pause("\nwhere 1 player sets a code, and the other player attempts to break it.")
    PrettyDisplay.puts_pause("In this version, you play against the computer.", 2, 0.3)

    # v2 time-animated text
    # PrettyDisplay.animated_text("a text-based version of the classic 2-player code-breaking game, \n")
    # PrettyDisplay.animated_text("\nwhere 1 player sets a code, and the other player attempts to break it.")
    # PrettyDisplay.animated_text("\nIn this version, you play against the computer.\n\n")
  end
end