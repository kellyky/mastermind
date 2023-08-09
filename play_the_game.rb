require './lib/mm'
require 'pry-byebug'

this_many_guesses = 1

new_game = PlayMasterMind.new
new_game.play_game(this_many_guesses)
