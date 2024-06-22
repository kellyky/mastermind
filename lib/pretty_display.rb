# frozen_string_literal: true

require 'pry-byebug'
require 'rainbow'

# Methods to add color to text, to animate text, etc.
class PrettyDisplay
  #  Puts optional animation and configurable precedning newlines
  #   - Update seconds to 0.02 for animation
  def self.puts_pause(text = "\n", newlines = 1, seconds = 0.00)
    sleep(seconds.to_i)
    lines = ''
    newlines.times { lines += "\n" }
    puts "#{text}#{lines}"
  end

  # Prints elipses with optional animation.
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
  # i.e. If color == :yellow, the text is printed in that color in the terminal.
  def self.color_text(color)
    case color
    when :red then print "#{Rainbow(color).red} | "
    when :orange then print "#{Rainbow(color).orangered} | "
    when :yellow then print "#{Rainbow(color).gold} | "
    when :green then print "#{Rainbow(color).green} | "
    when :blue then print "#{Rainbow(color).cyan} | "
    when :indigo then print "#{Rainbow(color).indigo} | "
    when :violet then print "#{Rainbow(color).webpurple} | "
    end
  end
end
