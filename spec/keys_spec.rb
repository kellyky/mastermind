require './lib/mastermind'
require 'pry-byebug'

describe Keys do
  subject { described_class.new(3, 1) }

  describe '#red' do
    it { expect(subject.red).to be(3) }
  end

  describe '#white' do
    it { expect(subject.white).to be(1) }
  end
end