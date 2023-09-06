require 'rainbow'
require 'pry-byebug'

class PrettyDisplay
  def self.puts_pause(text="\n", newlines=1, seconds=0.1)
    sleep(seconds.to_i)
    lines = "" 
    newlines.times { lines += "\n" }
    puts "#{text}#{lines}"
  end

  def self.animated_elipses(seconds=0.0) # .05
    print "."
    sleep(seconds)
    print "."
    sleep(seconds)
    print "."
  end

  def self.animated_text(text="...", seconds = 0.0) # .08
    text.split("").each do |word|
      print word
      sleep(seconds)
    end
  end

  def self.color_text(color)
    case color
    when :red
      print "#{Rainbow(color).red}" + " | "
    when :orange
      print "#{Rainbow(color).orangered}" + " | "
    when :yellow
      print "#{Rainbow(color).gold}" + " | "
    when :green
      print "#{Rainbow(color).green}" + " | "
    when :blue
      print "#{Rainbow(color).cyan}" + " | "
    when :indigo
      print "#{Rainbow(color).indigo}" + " | "
    when :violet
      print "#{Rainbow(color).webpurple}" + " | "
    end
  end

  # TODO: pretty up the color for black/white scoring - maybe!
  def self.color_score(color)
    case color
    when :black

    when :white

    end
  end
end
