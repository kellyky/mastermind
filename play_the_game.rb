require './lib/mm'
require 'pry-byebug'

start_on_this_round = 12

new_game = PlayMasterMind.new
new_game.play_game(start_on_this_round)
