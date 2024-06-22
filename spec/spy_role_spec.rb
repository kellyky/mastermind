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
    end

    context 'when "2" is selected' do
      before { allow(subject).to receive(:player_answer).and_return('2') }

      it 'calls player_code_breaker' do
        expect(subject).to receive(:player_code_breaker)
        subject.assign_roles
      end
    end

    # FIXME - not sure how to test the error & rescue withuot endless loop
    context 'when anything else is selected' do
      # it 'raises StandardError and retries' do
      #   allow(subject).to receive(:player_answer).and_return('5')
      #   expect(subject).to receive(:assign_roles).once.and_raise
      #   expect(subject).to receive(:assign_roles).once.and_call_original
      #   subject.assign_roles
      # end
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
