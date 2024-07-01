# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/play_mastermind'

describe PlayMasterMind do
  describe '.play_new_game' do
    before { allow_any_instance_of(described_class).to receive(:begin_new_game) }
    it 'should call GameIntro.run_intro' do
      expect(GameIntro).to receive(:run_intro)
      described_class.play_new_game
    end
  end

  describe '#begin_new_game' do
    subject(:game) { described_class.new }

    before do
      allow(game).to receive(:play_game)
      allow(game).to receive(:update_difficulty).and_return('1')
      allow_any_instance_of(SpyRole).to receive(:player_answer).and_return('1')
      allow_any_instance_of(ColorSelector::Player).to receive(:player_choice).and_return('red')
    end

    it 'should assign code breaker and code maker' do
      instance_variable_set(:@spy_roles, SpyRole.new)
      expect(@spy_roles.code_breaker).to eq(:player)
      expect(@spy_roles.code_maker).to eq(:computer)
    end

    it 'should call adapt_game_to_player' do
      expect(game).to receive(:adapt_game_to_player)
      game.begin_new_game
    end

    it 'should create a new instance of ColorSelector with provided arguments' do
      allow(game).to receive(:encode_colors)

      expect(ColorSelector).to receive(:new).with(
        code_maker = :player,
        code_breaker = :computer,
        difficulty = game.instance_variable_set(:@difficulty, :easy),
        code_length = 4,
        remaining_guesses = 12
      )

      game.begin_new_game
    end

    it 'should call encode_colors' do
      expect(game).to receive(:encode_colors)
      game.begin_new_game
    end

    it 'should call play_game' do
      expect(game).to receive(:play_game)
      game.begin_new_game
    end
  end

  describe '#encode_colors' do
    subject(:game) { described_class.new }


  end

  describe '#update_difficulty' do
    subject(:game) { described_class.new }
    it 'should set @difficulty' do
      allow(Difficulty).to receive(:assign).and_return(:abc)
      game.update_difficulty
      expect(game.instance_variable_get(:@difficulty)).not_to be(nil)
    end
  end

  describe '#play_game' do
    subject { described_class.new }

    context 'when the player is NOT out of guesses' do
      it 'should call play_turn' do
        subject.instance_variable_set(:@remaining_guesses, 10)
        expect(subject).to receive(:play_turn)
        subject.play_game
      end
    end

    context 'when the player is out of guesses' do
      let(:remaining_guesses) { 0 }
      let(:encode_colors) { %i[red red red blue] }

      it 'should call EndGame.declare_loser' do
        subject.instance_variable_set(:@remaining_guesses, remaining_guesses)
        subject.instance_variable_set(:@encode_colors, encode_colors)
        expect(EndGame).to receive(:declare_loser).with(remaining_guesses, encode_colors)
        subject.play_game
      end
    end
  end

  describe '#play_turn' do
    before do
      subject.instance_variable_set(:@remaining_guesses, 10)
      allow(subject).to receive(:guess_code)
      allow(subject).to receive(:evaluate_color_choices)
      allow(subject).to receive(:play_game)
    end

    it 'should decrement the remaining guesses by 1' do

      subject.play_turn
      expect(subject.remaining_guesses).to eq(9)
    end

    it 'should call guess_code' do
      expect(subject).to receive(:guess_code)
      subject.play_turn
    end

    it 'should call evaluate_color_choices' do
      expect(subject).to receive(:evaluate_color_choices)
      subject.play_turn
    end

    it 'should call play_game' do
      expect(subject).to receive(:evaluate_color_choices)
      subject.play_turn
    end
  end

  describe '#evaluate_color_choices' do
    before do
      allow(subject).to receive(:print_code)
      allow(subject).to receive(:print_score)
      allow(subject).to receive(:fully_correct_guess?).and_return(false)
      allow(subject).to receive(:partly_correct_guess?).and_return(true)
    end

    it 'should log the score for the turn' do
      correct_guesses = 0
      partly_correct_guesses = 4

      expect(subject).to receive(:log_turn_score).with(correct_guesses, partly_correct_guesses)
      subject.evaluate_color_choices
    end

    it 'should display_results' do
      expect(subject).to receive(:display_results)
      subject.evaluate_color_choices
    end

    it 'should check for winner' do
      allow(subject).to receive(:print_code)
      expect(subject).to receive(:check_for_winner)
      subject.evaluate_color_choices
    end
  end

  describe '#parse_correct_guesses' do
    let(:correct) { 0 }
    let(:partly_correct) { 0 }

    # iterates through
  end

  describe '#display_results' do
    before do
      allow(subject).to receive(:print_score)
      allow(subject).to receive(:print_code)
    end

    it 'should call print_code' do
      expect(subject).to receive(:print_code)
      subject.display_results
    end

    it 'should call print_score' do
      expect(subject).to receive(:print_score)
      subject.display_results
    end

    it 'should display the border' do
      border= "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      expect(PrettyDisplay).to receive(:puts_pause).with(border, 3, 0.3)
      subject.display_results
    end
  end

  describe '#check_for_winner' do
    context 'when number of correct guesses matches length of code' do
      let(:correct_guesses) { 4 }
      it 'should declare winner' do
        remaining_guesses = subject.instance_variable_get(:@remaining_guesses)
        expect(EndGame).to receive(:declare_winner).with(remaining_guesses)
        subject.check_for_winner(correct_guesses)
      end
    end

    context 'when number of correct guesses matches length of code' do
      let(:correct_guesses) { 3 }
      it 'should declare winner' do
        remaining_guesses = subject.instance_variable_get(:@remaining_guesses)
        expect(EndGame).not_to receive(:declare_winner).with(remaining_guesses)
        subject.check_for_winner(correct_guesses)
      end
    end
  end

  describe '#fully_correct_guess?' do
    subject(:game) { described_class.new }

    context 'when the color is correct for this spot' do
      let(:place) { 0 }

      before do
        game.instance_variable_set(:@encode_colors, %i[red blue blue blue])
        game.instance_variable_set(:@guessed_code, %i[red blue blue blue])
      end

      it 'should return true' do
        expect(game.fully_correct_guess?(place)).to be(true)
      end
    end

    context 'when the color is correct for another spot' do
      let(:place) { 0 }

      before do
        game.instance_variable_set(:@encode_colors, %i[red blue blue blue])
        game.instance_variable_set(:@guessed_code, %i[blue blue blue blue])
      end

      it 'should return true' do
        expect(game.fully_correct_guess?(place)).to be(false)
      end
    end

    context 'when the color is correct for no spot' do
      let(:place) { 0 }

      before do
        game.instance_variable_set(:@encode_colors, %i[blue blue blue blue])
        game.instance_variable_set(:@guessed_code, %i[red red red red])
      end

      it 'should return true' do
        expect(game.fully_correct_guess?(place)).to be(false)
      end
    end
  end

  describe '#partly_correct_guess?' do
    subject(:game) { described_class.new }

    context 'when the color is correct for this spot' do
      let(:place) { 0 }

      before do
        game.instance_variable_set(:@encode_colors, %i[red blue indigo red])
        game.instance_variable_set(:@guessed_code, %i[red blue blue blue])
      end

      it 'should return false' do
        expect(game.partly_correct_guess?(place)).to be(false)
      end
    end

    context 'when the color is correct for a different spot' do
      let(:place) { 0 }

      before do
        game.instance_variable_set(:@encode_colors, %i[indigo indigo indigo red])
        game.instance_variable_set(:@guessed_code, %i[red blue blue blue])
      end

      it 'should return true' do
        expect(game.partly_correct_guess?(place)).to be(true)
      end
    end

    context 'when the color is correct for no spots' do
      let(:place) { 0 }
      before do
        game.instance_variable_set(:@encode_colors, %i[blue blue blue blue])
        game.instance_variable_set(:@guessed_code, %i[orange orange orange orange])
      end

      it 'should return false' do
        expect(game.partly_correct_guess?(place)).to be(false)
      end
    end
  end

  describe '#log_turn_score' do
    let(:correct) { 1 }
    let(:partly_correct) { 2 }

    it 'should update @score with correct and partly correct values' do
      subject.log_turn_score(correct, partly_correct)
      expect(subject.instance_variable_get(:@score)).to eq({
        fully_correct_placement: correct.to_s,
        partly_correct_placement: partly_correct.to_s
      })
    end
  end

  describe '#guess_code' do
    subject(:game) { described_class.new }
    let(:color_selector) { ColorSelector.new(:player, :computer) }
    let(:remaining_guesses) { 12 }

    it 'should call break_code with @remaining_guesses' do
      expect(game.instance_variable_get(:@color_selector)).to receive(:break_code).with(remaining_guesses)
      game.guess_code
    end
  end
end
