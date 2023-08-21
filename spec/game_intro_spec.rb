require './lib/game_intro'
require 'pry-byebug'

describe GameIntro do
  describe '.welcome' do
    # is this a decent way to test this? I found testing exact output cumbersome, given
    # the various spacing and newlines
    let(:expected_output) { described_class.welcome.join }
    it { expect(expected_output.class).to be(String) }
  end

  describe '.rules' do
    let(:expected_output) { described_class.rules.join }
    it { expect(expected_output.class).to be(String) }
  end
end