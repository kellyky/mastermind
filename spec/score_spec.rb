# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/score'

RSpec.describe Score do
  subject { described_class.new(code_length, guessed_code, encode_colors) }
  let(:code_length) { 4 }
  let(:guessed_code) { %i[red red red yellow] }
  let(:encode_colors) { %i[red red red red] }

  describe '#wins_game?' do
    context 'when correct guesses equals code_length' do
      before { subject.instance_variable_set(:@correct, 4) }
      it 'should return true' do
        expect(subject.wins_game?).to be(true)
      end
    end

    context 'when correct guesses does not equal code_length' do
      it 'should return false' do
        expect(subject.wins_game?).to be(false)
      end
    end
  end

  describe '#parse_guesses' do
    context 'when 1 correct color was guessed in-place' do
      before do
        allow(subject).to receive(:fully_correct_guess?).and_return(true, false, false, false)
        subject.instance_variable_set(:@correct, 0)
      end

      it 'should increment @correct by 1 per correct guess' do
        subject.parse_guesses
        expect(subject.instance_variable_get(:@correct)).to eq(1)
      end
    end

    context 'when 4 correct colors were guessed in-place' do
      before do
        allow(subject).to receive(:fully_correct_guess?).and_return(true)
        subject.instance_variable_set(:@correct, 0)
      end

      it 'should increment @correct by 1 per correct guess' do
        subject.parse_guesses
        expect(subject.instance_variable_get(:@correct)).to eq(4)
      end
    end

    context 'when 4 partly correct colors were guessed - i.e. correct for different places' do
      before do
        allow(subject).to receive(:partly_correct_guess?).and_return(true)
        subject.instance_variable_set(:@partly_correct, 0)
      end

      it 'should increment @correct by 1 per partly correct guess' do
        subject.parse_guesses
        expect(subject.instance_variable_get(:@partly_correct)).to eq(4)
      end
    end
  end

  describe '#fully_correct_guess?' do
    let(:guessed_code) { %i[red yellow] }
    let(:encode_colors) { %i[red red] }

    context 'when the correct color was guessed for the place' do
      let(:place) { 0 }

      it 'should return true' do
        expect(subject.fully_correct_guess?(place)).to be(true)
      end
    end

    context 'when the correct color was NOT guessed for the place' do
      let(:place) { 1 }

      it 'should return true' do
        expect(subject.fully_correct_guess?(place)).to be(false)
      end
    end
  end

  describe '#partly_correct_guess?' do
    let(:encode_colors) { %i[red blue] }

    context 'when the correct collor was guessed for the place' do
      let(:guessed_code) { %i[red yellow] }
      let(:place) { 0 }

      it 'should teturn false' do
        expect(subject.partly_correct_guess?(place)).to be(false)
      end
    end

    context 'when the correct color was guessed for a DIFFERENT space' do
      let(:guessed_code) { %i[blue yellow] }
      let(:place) { 0 }

      it 'should return true' do
        expect(subject.partly_correct_guess?(place)).to be(true)
      end
    end

    context 'when the color guessed was not in the encoded colors' do
      let(:guessed_code) { %i[blue yellow] }
      let(:place) { 1 }

      it 'should return true' do
        expect(subject.partly_correct_guess?(place)).to be(false)
      end
    end


  end

  describe '#display_results' do
    before do
      allow(subject).to receive(:print_score)
      allow(subject).to receive(:print_code)
      allow(subject).to receive(:print_border)
    end
    it 'should call print_code' do

      expect(subject).to receive(:print_code)
      subject.display_results
    end

    it 'should call print_score' do
      expect(subject).to receive(:print_score)
      subject.display_results
    end

    it 'should call print_border' do
      expect(subject).to receive(:print_border)
      subject.display_results
    end
  end

  describe '#print_code' do
    it 'should call color_print_guessed_code' do
      expect(subject).to receive(:color_print_guessed_code)
      subject.display_results
    end
  end

  describe '#color_print_guessed_code' do
    it 'should call PrettyDisplay.color_text on each guessed color' do
      colors = subject.instance_variable_set(:@guessed_code, guessed_code)
      colors.each do |color|
        expect(PrettyDisplay).to receive(:color_text).with(color)
      end
      subject.color_print_guessed_code
    end
  end

  describe '#print_score' do
    before do
      allow(subject).to receive(:print_fully_correct_score)
      allow(subject).to receive(:print_partly_correct_score)
    end

    it 'should call print_fully_correct_score' do
      expect(subject).to receive(:print_fully_correct_score)
      subject.print_score
    end

    it 'should call print_partly_correct_score' do
      expect(subject).to receive(:print_partly_correct_score)
      subject.print_score
    end
  end

  describe '#print_fully_correct_score' do
    let(:message) { "\n >> Black: 1 | space(s) with the RIGHT color" }

    before { subject.instance_variable_set(:@correct, 1) }
    it 'should pretty-display fully correct score' do
      expect(PrettyDisplay).to receive(:puts_pause).with(message)
      subject.print_fully_correct_score
    end
  end

  describe '#print_partly_correct_score' do
    let(:message) do
        " >> White: 2 | space(s) with partly_correct color " \
        '/ but you do need this color'
    end

    before { subject.instance_variable_set(:@partly_correct_guess, 2) }
    it 'should pretty-display the partly correct score' do
      expect(PrettyDisplay).to receive(:puts_pause).with(message, 2)
      subject.print_partly_correct_score
    end
  end

  describe '#print_border' do
    let(:border) { "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" }

    it 'should pretty-display the border' do
      expect(PrettyDisplay).to receive(:puts_pause).with(border, 3, 0.3)
      subject.print_border
    end
  end
end
