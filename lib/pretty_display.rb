require 'pry-byebug'

class PrettyDisplay
  def self.puts_pause(text="\n", newlines=1, seconds=0.1)
    sleep(seconds.to_i)
    lines = "" 
    newlines.times { lines += "\n" }
    puts "#{text}#{lines}"
  end

  def self.animated_elipses(seconds=0.05)
    print "."
    sleep(seconds)
    print "."
    sleep(seconds)
    print "."
  end

  def self.animated_text(text=[], seconds = 0.018)
    text.split("").each do |word|
      print word
      sleep(seconds)
    end
  end
end
