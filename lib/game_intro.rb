# frozen_string_literal: true

require_relative 'pretty_display'

# Prints game intro and rules
class GameIntro
  DIVIDER = '>>>==============================================================<<<'
  WELCOME = '     >>>>>>>>>>     Welcome to Mastermind!     <<<<<<<<<<     '
  INTRODUCTION = [
    "a text-based version of the classic 2-player code-breaking game, \n",
    "\nwhere 1 player sets a code, and the other player attempts to break it.",
    "\nIn this version, you play against the computer.\n\n"
  ].freeze

  RULES = [
    ">>> Gameplay & Scoring:\n\n",
    "The code maker creates a code using colors.\n\n",
    "To win, guess the code within 12 attempts.\n",
    "Each attempt is scored to give the code breaker clues.\n\n"
  ].freeze

  SCORING = [
    "Scoring works like this:\n",
    "- Black point(s): 1 for each 'place' with the correct color\n",
    "- White points(s): 1 for each 'place' whose color is in the code - ",
    "but doesn't go in that 'place'\n",
    "- No points: For 'places' with wrong color ",
    "and when that color is NOT in the code at all)\n\n",
    "Each 'place' in the code is a color. Colors may repeat.\n\n"
  ].freeze

  def self.run_intro
    welcome
    rules
    explain_scoring
  end

  # Prints welcome message with brief introduction to the game
  def self.welcome
    puts "\n"
    PrettyDisplay.puts_pause(DIVIDER, 2)
    PrettyDisplay.puts_pause(WELCOME, 2)
    PrettyDisplay.animated_elipses
    PrettyDisplay.print_animated_texts(INTRODUCTION)
  end

  # Prints game rules
  def self.rules
    PrettyDisplay.puts_pause(DIVIDER, 2)
    PrettyDisplay.print_animated_texts(RULES)
  end

  # Explains scoring system
  def self.explain_scoring
    PrettyDisplay.print_animated_texts(SCORING)
  end
end
