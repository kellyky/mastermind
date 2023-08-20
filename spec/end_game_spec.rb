require './lib/mastermind'
require 'pry-byebug'
require 'stringio'

describe EndGame do
  let(:guesses_remaining) { 4 }
  let(:winning_game) { described_class.new(guesses_remaining)}
  let(:losing_game) { described_class.new(0, [:red, :red, :indigo, :blue])}
  let(:game) { described_class.new }


  describe '#we_have_a_winner' do
    # should we test that it calls print_winners_message
    # should we test that it calls play_again?
  end

  describe '#print_winners_message' do  
    let(:message) { "whoohoo, you win, you codebreaker, you!!!\n\nyou got it right in 8 attempts. Impressive!\n\n" }
    it { expect { winning_game.print_winners_message }.to output(message).to_stdout }
  end

  describe '#better_luck_next_time' do
    # test that it calls print_losing_message?
    # test that it calls play_again?
  end

  describe '#print_losing_message' do
    let(:message) { "Ope, your 12 guesses are up.\n\n>> The code was: >> | red | red | indigo | blue |  <<\n\n\n" }
    it { expect { losing_game.print_losing_message }.to output(message).to_stdout }
  end

  describe '#print_play_again_message' do
    let(:message) { "Would you like to play again? (1 = yes, 2 = no)\n" }
    it { expect { game.print_play_again_message }.to output(message).to_stdout }
  end

  describe '#answer' do
    let(:yes_play_again) { StringIO.new('1')}

    context 'when the user enters "1"' do
      it 'returns 1' do
        game.stub(:gets).and_return("1\n")
        expect(game.answer).to eq("1")
      end
    end

    context 'when the user enters "2"' do
      it 'returns 2' do
        game.stub(:gets).and_return("2\n")
        expect(game.answer).to eq("2")
      end
    end
  end
end
