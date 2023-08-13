require 'pry-byebug'

class PrettyDisplay
  def self.new_line_pause(seconds=0, newlines=1)
    newlines.times do
      puts "\n"
    end
    sleep(seconds)
  end

  def self.pause(seconds=0)
    sleep(seconds)
  end

  def self.animated_elipses
    print "."
    pause
    print "."
    pause
    print "."
  end
end
