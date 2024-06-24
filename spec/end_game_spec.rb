# frozen_string_literal: true

require 'stringio'

require 'pry-byebug'

require_relative '../lib/play_mastermind'
# require_relative '../lib/pretty_display'

RSpec.describe EndGame do
  subject { described_class.new }

  describe '#we_have_a_winner' do
    before { allow(subject).to receive(:play_again?).and_return('2') }

    it 'should call congratulate_the_winner' do
      expect(subject).to receive(:congratulate_the_winner)
      subject.we_have_a_winner
    end

    it 'should invite the player to play again'  do
      expect(subject).to receive(:invite_player_to_another_game)
      subject.we_have_a_winner
    end

    it 'should call play_again?' do
      expect(subject).to receive(:play_again?)
      subject.we_have_a_winner
    end
  end

  describe '#congratulate_the_winner' do
    let(:guesses_remaining) { 4 }
    let(:winning_game) { described_class.new(guesses_remaining) }
    let(:message) { "whoohoo, you win, you codebreaker, you!!!\n\nyou got it right in 8 attempts. Impressive!\n\n" }
    it { expect { winning_game.congratulate_the_winner }.to output(message).to_stdout }
  end

  describe '#better_luck_next_time' do
    before { allow(subject).to receive(:play_again?).and_return('2') }

    it 'should call print_losing_message' do
      expect(subject).to receive(:print_losing_message)
      subject.better_luck_next_time
    end

    it 'should invite the player to play again'  do
      expect(subject).to receive(:invite_player_to_another_game)
      subject.better_luck_next_time
    end

    it 'should call play_again?' do
      expect(subject).to receive(:play_again?)
      subject.better_luck_next_time
    end
  end

  describe '#print_losing_message' do
    let(:losing_game) { described_class.new(0, %i[red red indigo blue]) }
    let(:message) { "Ope, your 12 guesses are up.\n\n>> The code was: >> | red | red | indigo | blue |  <<\n\n\n" }
    it { expect { losing_game.print_losing_message }.to output(message).to_stdout }
  end

  describe '#play_again?' do
    context 'when the player selected 1 to play again' do
      before { allow(subject).to receive(:answer).and_return('1')}
      it 'should call play_again' do
        expect(subject).to receive(:play_again)
        subject.play_again?
      end
    end

    context 'when the player selected 2 to exit' do
      before { allow(subject).to receive(:answer).and_return('2')}
      it 'should call exit_game' do
        expect(subject).to receive(:exit_game)
        subject.play_again?
      end
    end

    context 'when the player selected something invalid' do
      before { allow(subject).to receive(:answer).and_return('abcd-invalid', '2') }

      # FIXME
      xit 'should call rescue NoMethodError and retry' do
        expect { subject.play_again? }.to raise_error(NoMethodError)
        expect(subject).to receive(:retry)
      end
    end
  end

  describe '#invite_player_to_another_game' do
    let(:message) { "Would you like to play again? (1 = yes, 2 = no)\n\n" }
    it { expect { subject.invite_player_to_another_game }.to output(message).to_stdout }
  end

  describe '#answer' do
    let(:yes_play_again) { StringIO.new('1') }

    context 'when the user enters "1"' do
      it 'returns 1' do
        subject.stub(:gets).and_return("1\n")
        expect(subject.answer).to eq('1')
      end
    end

    context 'when the user enters "2"' do
      it 'returns 2' do
        subject.stub(:gets).and_return("2\n")
        expect(subject.answer).to eq('2')
      end
    end
  end
end
