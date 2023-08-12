require './lib/mastermind'
require 'pry-byebug'

class Keys
  def initialize(correct_place=0, wrong_place=0)
    @correct_place = correct_place  # right color/right placement
    @wrong_place = wrong_place  # right color / wrong placement
  end

  def correct_place
    @correct_place
  end

  def wrong_place
    @wrong_place
  end
end