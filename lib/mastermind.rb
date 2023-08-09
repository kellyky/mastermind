require 'pry-byebug'

class PlayMasterMind
  # def initialize
  #   # @encoded_colors = encoded_colors
  # end

  def self.start_new_game
    @game_roles = Roles.determine_roles

    if @game_roles[:code_maker] == :computer
      @encoded_colors ||= ComputerSelectColors.computer_set_code
      play_game # I think this could be used for either... 
    else
      @encoded_colors ||= PlayerSelectColors.player_set_code
      puts "code not written yet to kick off this verseion of the game"
    end
    
  end

  # I think this can stay as-is regardless of roles
  def play_game(turns_left=12)
    if turns_left > 0
      play_turn(turns_left)
    else
      EndGame.better_luck_next_time
    end
  end

  def play_turn(turns_left)
    guess_count = DecrementGuess.new(turns_left)
    next_turn = guess_count.decrement_turn_counter
    guess_code
    evaluate_guess
    play_game(next_turn)
  end

  def evaluate_guess
    red, white = [0, 0]
    for place in (0...4)
      if merits_red_peg?(place)
        red += 1
      elsif merits_white_peg?(place)
        white += 1
      end
    end

    get_rating(red, white)

    puts "\nyour score: #{score}"
    puts "you guessed #{@guessed_code}"
    EndGame.we_have_a_winner if red == 4
  end

  def merits_red_peg?(place)
    @guessed_code[place] == @encoded_colors[place]
  end

  def merits_white_peg?(place)
    @encoded_colors.any?(@guessed_code[place])
  end

  def score
    { red: "#{@rating.red}", white: "#{@rating.white}" }
  end

  def get_rating(red, white)
    @rating = Keys.new(red, white)
  end
  
  def guess_code
    @guessed_code = PlayerSelectColors.player_attempts_to_break_the_code
  end
end

class Roles
  def self.determine_roles
    puts "Welcome to Mastermind!" 
    puts "Do you want to set the code or break the code?"
    puts "(1 = set the code, 2 = break the code)"
    answer = gets.chomp
    case answer
    when "1"
      puts "code maker it is! You set the code and the computer will try to break it."
      @code_maker = :player
      @code_breaker = :computer
    when "2"
      puts "code breaker it is! The computer sets the code and you try to break it."
      @code_maker = :computer
      @code_breaker = :player
    else
      "something I guess"
    end
    { code_maker: @code_maker, code_breaker: @code_breaker }
  end
end

class DecrementGuess
  def initialize(guess_count=0)
    @guess_count = guess_count
  end

  def decrement_turn_counter
    @guess_count -= 1
  end
end

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

class ComputerSelectColors
  COLOR_BANK = [:red, :orange, :yellow, :green, :blue, :indigo, :violet]

  def self.computer_set_code
    colors = []
    4.times do
      colors << COLOR_BANK.shuffle.last
    end
    # colors
    [:red, :red, :orange, :yellow]  # for testing. Otherwise uncomment colors and remove this line
  end

  # def self.player
end

class PlayerSelectColors
  def self.player_attempts_to_break_the_code
    puts "pick 4 colors"
    counter = 0
    colors = []
    until colors.count == 4
      puts "state your choice for color #{counter + 1}."
      color = gets.chomp
      colors << color.strip.to_sym
      counter += 1
    end
    colors
  end

  def self.player_set_code
    puts "Time to set the code."
    puts "pick 4 colors"
    counter = 0
    colors = []
    until colors.count == 4
      puts "state your choice for color #{counter + 1}."
      color = gets.chomp
      colors << color.strip.to_sym
      counter += 1
    end
    puts "Here's the code you set: #{colors}"
    colors
  end
end

class EndGame
  def self.we_have_a_winner
    puts "whoohoo, you win, you codebreaker, you!!!"
    self.play_again?
  end

  def self.better_luck_next_time
    puts "Your 12 turns are up. Better luck next time!"
    self.play_again?
  end

  def self.play_again?
    puts "would you like to play again? (1=yes, 2=no)"
    answer = gets.chomp
    if answer == "1"
      PlayMasterMind.start_new_game
    else
      "ok, another time then!"
      exit
    end
  end
end
