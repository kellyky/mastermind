# frozen_string_literal: true

require 'stringio'
require 'pry-byebug'

require_relative '../lib/difficulty'

RSpec.describe Difficulty do
  subject { described_class.new }
  let(:player_difficulty_choice) { '1' }

  before do
    allow_any_instance_of(described_class).to receive(:player_choice).and_return(player_difficulty_choice)
  end

  describe '.assign' do
    it 'calls explain_game_difficulty_options' do
      expect_any_instance_of(Difficulty).to receive(:set_mode)
      described_class.assign
    end

    it 'calls set_mode' do
      allow(described_class).to receive(:new).and_return(double(Difficulty, set_mode: nil))
      described_class.assign
      expect(described_class).to have_received(:new)
    end
  end

  describe '.explain_game_difficulty_options' do
    let(:difficulty) do
      [
        ['Would you like to play standard difficulty or a slightly easier version of the game?', 2],
        ['1 = standard mode: break a 4-color code with 7 possible colors', 1],
        ['2 = easy mode: break a 4-color code with 5 possible colors', 1],
        ['3 = beginner mode: break a 2-color code with 4 possible colors', 2]
      ]
    end

    it 'pretty-displays each line' do
      difficulty.all? do |message, newlines|
        expect(PrettyDisplay).to receive(:puts_pause).with(message, newlines)
      end

      described_class.explain_game_difficulty_options
    end
  end

  describe '#set_mode' do
    it 'should call update_difficulty' do
      expect(subject).to receive(:update_difficulty).with(player_difficulty_choice)
      subject.set_mode
    end

    it 'should have default @mode of :standard' do
      allow(subject).to receive(:update_difficulty).with(player_difficulty_choice)
      expect(subject.set_mode).to eq(:standard)
    end
  end

  describe '#update_difficulty' do
    context 'when the player selected 1 - standard mode' do
      it 'should call standard_mode' do
        expect(subject).to receive(:standard_mode)
        subject.update_difficulty(player_difficulty_choice)
      end
    end

    context 'when the player selected 2 - easy mode' do
      let(:player_difficulty_choice) { '2' }
      it 'should call standard_mode' do
        expect(subject).to receive(:easy_mode)
        subject.update_difficulty(player_difficulty_choice)
      end
    end

    context 'when the player selected 3 - beginner mode' do
      let(:player_difficulty_choice) { '3' }
      it 'should call standard_mode' do
        expect(subject).to receive(:beginner_mode)
        subject.update_difficulty(player_difficulty_choice)
      end
    end

    context 'when invalid input is selected' do
      let(:invalid_input) { 'something invalid ~123@#$' }
      let(:invalid_input_message) { "\nHm, I don't know that one.... " }

      it 'rescues invalid input - tells the player the choice was invalid' do
        allow(described_class).to receive(:assign)
        expect(PrettyDisplay).to receive(:puts_pause).with(invalid_input_message, 2)
        subject.update_difficulty(invalid_input)
      end
    end
  end

  describe '#standard_mode' do
    let(:standard_mode_confirmation) do
      "\nStandard mode it is! You'll have all 7 colors of the rainbow to choose from."
    end

    it '@mode should be :standard' do
      expect(subject.instance_variable_get(:@mode)).to eq(:standard)
    end

    it 'should confirm standard mode choice' do
      expect(PrettyDisplay).to receive(:puts_pause).with(standard_mode_confirmation, 3)
      subject.standard_mode
    end
  end

  describe '#easy_mode' do
    let(:player_difficulty_choice) { '2' }
    let(:easy_mode_confirmation) { "\nEasy mode it is. You've got this!!" }

    it '@mode should be :easy' do
      subject.easy_mode
      expect(subject.instance_variable_get(:@mode)).to eq(:easy)
    end

    it 'should confirm easy mode' do
      expect(PrettyDisplay).to receive(:puts_pause).with(easy_mode_confirmation, 3)
      subject.easy_mode
    end
  end

  describe '#beginner_mode' do
    let(:player_difficulty_choice) { '3' }
    let(:beginner_mode_confirmation) do
      [
        ["\nbeginner mode it is! You'll break a code of 2 colors, and you 5.", 2],
        ["You've got this!!", 3]
      ]
    end

    it '@mode should be :easy' do
      subject.beginner_mode
      expect(subject.instance_variable_get(:@mode)).to eq(:beginner)
    end

    it 'should confirm beginner mode' do
      beginner_mode_confirmation.all? do |message, newlines|
        expect(PrettyDisplay).to receive(:puts_pause).with(message, newlines)
      end

      subject.beginner_mode
    end
  end
end
