# frozen_string_literal: true

require 'pry-byebug'
require 'rainbow'

# Methods to add color to text, to animate text, etc.
class PrettyDisplay
  def self.puts_pause(text = "\n", newlines = 1, seconds = 0.00) # update seconds to 0.02 for animation
    sleep(seconds.to_i)
    lines = ''
    newlines.times { lines += "\n" }
    puts "#{text}#{lines}"
  end

  def self.animated_elipses(seconds = 0.00) # update seconds to 0.02 for animation
    print '.'
    sleep(seconds)
    print '.'
    sleep(seconds)
    print '.'
  end

  def self.animated_text(text = '...', seconds = 0.00) # update seconds to 0.02 for animation
    text.split('').each do |word|
      print word
      sleep(seconds)
    end
  end

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
