require './lib/game_intro'
require 'pry-byebug'

describe GameIntro do
  describe '.welcome' do
    let(:expected_output) { described_class.welcome.join }
    it { expect(expected_output.class).to be(String) }
  end

  describe '.rules' do
    let(:expected_output) { described_class.rules.join }
    it { expect(expected_output.class).to be(String) }
  end
end