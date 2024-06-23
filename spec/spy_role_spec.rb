# frozen_string_literal: true

require 'stringio'

require 'pry-byebug'

require_relative '../lib/play_mastermind'

describe SpyRole do
  subject { described_class.new }

  describe '#assign_roles' do
    it 'returns a hash' do
      allow(subject).to receive(:player_answer).and_return('1')
      expect(subject.assign_roles).to be_a(Hash)
    end

    context 'when "1" is selected' do
      before { allow(subject).to receive(:player_answer).and_return('1') }

      it 'calls computer_code_breaker' do
        expect(subject).to receive(:computer_code_breaker)
        subject.assign_roles
      end

      it 'assigns the correct roles' do
        subject.assign_roles
        expect(subject.code_maker).to be(:player)
        expect(subject.code_breaker).to be(:computer)
      end
    end

    context 'when "2" is selected' do
      before { allow(subject).to receive(:player_answer).and_return('2') }

      it 'calls player_code_breaker' do
        expect(subject).to receive(:player_code_breaker)
        subject.assign_roles
      end

      it 'assigns the correct roles' do
        subject.assign_roles
        expect(subject.code_maker).to be(:computer)
        expect(subject.code_breaker).to be(:player)
      end
    end

    context 'when invalid input is selected (initially)' do
      before do
        # Stubbing first an invalid user input followed by '1' - to set the computer as code breaker
        allow(subject).to receive(:player_answer).and_return('g', '1')
      end
      it 'raises StandardError and retries' do
        error_message = "\nPlease choose '1' to set the code or '2' to break the code."

        # Expecting the method to retry and eventually call computer_code_breaker after the invalid input
        expect(subject).to receive(:computer_code_breaker)

        # Expecting PrettyDisplay.puts_pause to be called with the error message once
        expect(PrettyDisplay).to receive(:puts_pause).with(error_message, 2).once

        subject.assign_roles
      end
    end
  end

  describe '#computer_code_breaker' do
    before do
      allow(subject).to receive(:player_answer).and_return('1')
      subject.computer_code_breaker
    end

    it { expect(subject.code_maker).to be(:player) }
    it { expect(subject.code_breaker).to be(:computer) }
  end

  describe '#player_code_breaker' do
    before do
      allow(subject).to receive(:player_answer).and_return('2')
      subject.player_code_breaker
    end

    it { expect(subject.code_maker).to be(:computer) }
    it { expect(subject.code_breaker).to be(:player) }
  end
end
