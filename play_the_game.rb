require './lib/play_mastermind'
require 'pry-byebug'

guesses_remaining = 12

new_game = PlayMasterMind.new(guesses_remaining)
new_game.play_game(guesses_remaining)


# @color_bank = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]

