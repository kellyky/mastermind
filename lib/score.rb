# frozen_string_literal: true

require 'pry-byebug'

require_relative 'play_mastermind'

class Score
  attr_reader :correct

  def initialize(code_length, guessed_code, encode_colors)
    @code_length = code_length
    @guessed_code = guessed_code
    @encode_colors = encode_colors
    @correct = 0
    @partly_correct = 0
  end

  def wins_game?
    @correct == @code_length
  end

  def parse_guesses
    (0...@code_length).to_a.each do |place|
      @correct += 1 if fully_correct_guess?(place)
      @partly_correct +=1 if partly_correct_guess?(place)
    end
  end

  def fully_correct_guess?(place)
    @guessed_code[place] == @encode_colors[place]
  end

  def partly_correct_guess?(place)
    !fully_correct_guess?(place) && @encode_colors.any?(@guessed_code[place])
  end

  def display_results
    print_code
    print_score
    print_border
  end

  def print_code
    print '>>>>>>> You guessed: >> | '
    color_print_guessed_code
    print " <<\n"
  end

  def color_print_guessed_code
    @guessed_code.each do |color|
      PrettyDisplay.color_text(color)
    end
  end

  def print_score
    print_fully_correct_score
    print_partly_correct_score
  end

  def print_fully_correct_score
    PrettyDisplay.puts_pause(
      "\n >> Black: #{@correct} | "\
      'space(s) with the RIGHT color'
    )
  end

  def print_partly_correct_score
    PrettyDisplay.puts_pause(
      " >> White: #{@partly_correct_guess} | " \
      'space(s) with partly_correct color / but you do need this color', 2
    )
  end

  def print_border
    PrettyDisplay.puts_pause(
      "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^", 3, 0.3
      )
  end
end
