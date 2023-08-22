require './lib/play_mastermind'
require 'pry-byebug'

describe PlayMasterMind do
  describe '#play_game' do
    subject { described_class.new }
    context 'when fewer than 12 turns have been played' do
      it 'should call play_turn' do
        expect(subject.play_turn(11)).to receive(:play_game)
        expect(subject.play_turn(13)).to receive(:play_game)
      end
    end

    context 'when 12 turns have been played' do
      it 'should call the end game -- better luck next time' do
        turns_left = 12

      end
    end
  end

  describe '#play_turn' do
  end

  describe '#evaluate_guess' do
  end

  describe '#merit_red_peg?' do
  end

  describe '#merit_white_peg?' do
  end

  describe '#score' do
  end

  describe '#get_rating' do
  end

  describe '#guess_code' do
  end
end
