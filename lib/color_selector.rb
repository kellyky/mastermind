# frozen_string_literal: true

require 'pry-byebug'
require 'rainbow'

require_relative 'play_mastermind'
require_relative 'pretty_display'

# Logic for encoding / decoding color
class ColorSelector
  attr_reader :guesses_left

  def initialize(code_maker, code_breaker, difficulty = :standard, code_length = 4, guesses_left = 12)
    @@difficulty = difficulty
    @@code_length = code_length
    @guesses_left = guesses_left
    @@code_maker = code_maker
    @@code_breaker = code_breaker
    @@color_bank = %i[red orange yellow green blue indigo violet]
  end

  def color_bank
    case @@difficulty
    when :beginner
      @@color_bank.first(4)
    when :easy
      @@color_bank.first(5)
    else
      @@color_bank
    end
  end

  def code_length
    @@code_length
  end

  def difficulty
    @@difficulty
  end

  def encode_colors
    case @@code_maker
    when :computer then computer_select_colors
    when :player then Player.new(guesses_left).select_colors
    end
  end

  def break_code(guesses_left)
    case @@code_breaker
    when :computer then computer_select_colors
    when :player then Player.new(guesses_left).select_colors
    end
  end

  def show_color_bank
    print "\nColors to choose from: \n>> | "
    color_bank.each { |color| PrettyDisplay.color_text(color) }
    print " <<\n\n\n"
  end

  def print_guesses_left
    if guesses_left.zero?
      'This is your last guess. Make it count!'
    else
      "You have #{guesses_left} guesses left."
    end
  end

  def computer_select_colors
    selected_colors = []
    code_length.times { selected_colors << color_bank.sample }
    selected_colors
  end

  # Logic to support player-selected colors whether setting or guessing the code
  class Player < ColorSelector
    COLORS = {
      red: :red,
      ora: :orange,
      yel: :yellow,
      gre: :green,
      blu: :blue,
      ind: :indigo,
      vio: :violet
    }.freeze

    def initialize(guesses_left)
      @guesses_left = guesses_left
      @selected_colors = []
      @color_counter = 0
    end

    def select_colors
      PrettyDisplay.puts_pause("*** Round #{12 - guesses_left} - #{print_guesses_left}")
      show_color_bank
      until @selected_colors.count == code_length
        select_color
        @color_counter += 1
      end
      @selected_colors
    end

    def select_color
      print "#{PrettyDisplay.animated_elipses}select a color for 'place' #{@color_counter + 1}: \n\n"

      color = gets.chomp
      formatted_color = color.strip.downcase.slice(0..2).to_sym

      if COLORS[formatted_color].nil?
        PrettyDisplay.puts_pause("Hm, I don't know that one. Please choose an available color.")
        select_color
      else
        @selected_colors << COLORS[formatted_color]
      end
    end
  end
end
