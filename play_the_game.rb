require './lib/mastermind'
require 'pry-byebug'

guesses_remaining = 2

new_game = PlayMasterMind.new(guesses_remaining)
new_game.play_game(guesses_remaining)

# PlayMasterMind.new_game