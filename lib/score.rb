require './lib/pretty_display'
require './lib/play_mastermind'
require 'pry-byebug'

class Score
  def initialize(correct_place=0, wrong_place=0)
    @correct_place = correct_place
    @wrong_place = wrong_place
  end

  def correct_place
    @correct_place
  end

  def wrong_place
    @wrong_place
  end
end