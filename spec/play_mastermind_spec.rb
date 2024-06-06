require './lib/play_mastermind'
require 'pry-byebug'

describe PlayMasterMind do
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
