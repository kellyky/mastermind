require './lib/pretty_display'

class GameIntro
  def self.welcome
    PrettyDisplay.puts_pause(">>>==============================================================<<<", 2)
    PrettyDisplay.puts_pause("     >>>>>>>>>>     Welcome to Mastermind!     <<<<<<<<<<     ", 2)
    PrettyDisplay.animated_elipses
    PrettyDisplay.animated_text("a text-based version of the classic 2-player code-breaking game, \n")
    PrettyDisplay.animated_text("\nwhere 1 player sets a code, and the other player attempts to break it.")
    PrettyDisplay.animated_text("\nIn this version, you play against the computer.\n\n")
  end

  def self.rules
    PrettyDisplay.puts_pause(">>>==============================================================<<<", 2)
    PrettyDisplay.puts_pause("\n>>> Gameplay & Scoring:\n\n")
    PrettyDisplay.animated_text("The code maker creates a code.\n\n")
    PrettyDisplay.animated_text("To win the game, the code breaker must guess the code within 12 attempts.\n\n")
    PrettyDisplay.animated_text("Each attempt is scored to give the code breaker clues. Scoring works like this:\n")
    PrettyDisplay.animated_text("- Black point(s): 1 for each 'place' with the correct color\n")
    PrettyDisplay.animated_text("- White points(s): 1 for each 'place' whose color is in the code - but doesn't go in that 'place'\n")
    PrettyDisplay.animated_text("- No points: For 'places' with wrong color (and when that color is NOT in the code at all)\n\n")
    PrettyDisplay.animated_text("The code has 4 'places', and each place has a color. Colors may repeat.\n\n")
    PrettyDisplay.animated_text("You can repeat colors if you'd like, but be sure to choose colors the computer knows. \n")
    PrettyDisplay.animated_text("You can type just the first 3 letters of the color - I'll understand! :D\n\n")

  end
end