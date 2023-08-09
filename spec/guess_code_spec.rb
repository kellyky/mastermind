require './lib/mastermind'
require 'pry-byebug'

describe GuessCode do
  subject { described_class.player_attempts_to_break_the_code }

  describe '.player_attempts_to_break_the_code' do
    it { expect(subject.class).to be(Array) }
    it { expect(subject.count).to eq(4) }
  end
end