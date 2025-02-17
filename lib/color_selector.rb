# frozen_string_literal: true

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

  # TODO: use attr_accessor in future refactor to replace class variables
  def code_length
    @@code_length
  end

  # TODO: use attr_accessor in future refactor to replace class variables
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
      "You have #{guesses_left + 1} guesses left."
    end
  end

  def computer_select_colors
    selected_colors = []
    code_length.times { selected_colors << color_bank.sample }
    selected_colors
  end

  # Logic to support player-selected colors whether setting or guessing the code
  class Player < ColorSelector
    # TODO: refactor to use only relavent key/value pairs (e.g. beginner mode should only use red through green)
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
      show_guessing_round_intro
      select_color until @selected_colors.size == code_length
      @selected_colors
    end

    def show_guessing_round_intro
      PrettyDisplay.puts_pause("*** Round #{12 - guesses_left} - #{print_guesses_left}")
      show_color_bank
    end

    def select_color
      print "#{PrettyDisplay.animated_elipses}select a color for 'place' #{@color_counter + 1}: \n\n"
      raw_color = player_choice
      color = standardized_color(raw_color)

      return handle_invalid_color if color.nil?

      @color_counter += 1
      @selected_colors << color
    end

    def handle_invalid_color
      PrettyDisplay.puts_pause(
        "Hm, I don't know that one. Please choose an available color."
      )
      select_color
    end

    def standardized_color(color)
      COLORS[color.strip.downcase.slice(0..2).to_sym]
    end

    def player_choice
      gets.chomp
    end
  end
end
