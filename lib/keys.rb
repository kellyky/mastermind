require './lib/mastermind'
require 'pry-byebug'

class Keys
  def initialize(red=0, white=0)
    @red = red  # right color/right placement
    @white = white  # right color / wrong placement
  end

  def red
    @red
  end

  def white
    @white
  end
end