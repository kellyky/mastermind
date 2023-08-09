require './lib/mm'
require 'pry-byebug'

describe DecrementGuess do
  let(:guess) { 10 }
  describe 'increment_turn_counter' do
    subject{described_class.new(guess)}
    it 'decrements down by 1' do
      expect(subject.send(:decrement_turn_counter)).to eq(9)
      expect(subject.send(:decrement_turn_counter)).to eq(8)
    end
  end
end
