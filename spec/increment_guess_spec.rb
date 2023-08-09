require './lib/mm'
require 'pry-byebug'

describe IncrementGuess do
  let(:guess) { 0 }
  describe 'increment_turn_counter' do
    subject{described_class.new(guess)}
    it 'increments up by 1' do
      expect(subject.send(:increment_turn_counter)).to eq(1)
      expect(subject.send(:increment_turn_counter)).to eq(2)
    end
  end
end
