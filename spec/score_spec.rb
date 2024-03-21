require './lib/play_mastermind'
require 'pry-byebug'

describe Score do
  subject { described_class.new(3, 1) }

  describe '#correct_place' do
    it { expect(subject.correct_place).to be(3) }
  end

  describe '#wrong_place' do
    it { expect(subject.wrong_place).to be(1) }
  end
end
