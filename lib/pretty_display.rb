# frozen_string_literal: true

require 'pry-byebug'
require 'rainbow'

# Methods to add color to text, to animate text, etc.
class PrettyDisplay
  COLOR_MAP = {
    red: 'red',
    orange: 'orangered',
    yellow: 'gold',
    green: 'green',
    blue: 'cyan',
    indigo: 'indigo',
    violet: 'webpurple'
  }.freeze

  #  Puts optional animation and configurable precedning newlines
  #  Update seconds to 0.02 for animation
  def self.puts_pause(text = "\n", newlines = 1, seconds = 0.00)
    sleep(seconds.to_i)
    lines = ''
    newlines.times { lines += "\n" }
    puts "#{text}#{lines}"
  end

  # Prints elipses ... with animation if seconds is set as greater than 0
  # Update seconds to 0.02 for animation.
  def self.animated_elipses(seconds = 0.00)
    print '.'
    sleep(seconds)
    print '.'
    sleep(seconds)
    print '.'
  end

  # Print with optional animation from word to word.
  # Update seconds to 0.02 for animation.
  def self.animated_text(text = '...', seconds = 0.00)
    text.split('').each do |word|
      print word
      sleep(seconds)
    end
  end

  # Colorizes selected text using Rainbow gem.
  # Based on user input, calls singleton method - e.g. `orange`
  # Results in colored text in the terminal
  def self.color_text(color)
    send("#{color}")
  rescue NoMethodError
    raise ArgumentError, "Invalid color: #{color}"
  end

  # Define singleton methods for each color in COLOR_MAP.
  COLOR_MAP.each do |color, rainbow_color|
    define_singleton_method("#{color}") do
      print "#{Rainbow(color.to_s).send(rainbow_color)} | "
    end
  end
end
