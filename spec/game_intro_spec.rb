# frozen_string_literal: true

require 'pry-byebug'
require 'stringio'

require './lib/game_intro'

describe GameIntro do
  describe '.run_intro' do
    it 'calls welcome, rules, and explain_scoring' do
      expect(described_class).to receive(:welcome)
      expect(described_class).to receive(:rules)
      expect(described_class).to receive(:explain_scoring)
      described_class.run_intro
    end
  end

  describe '.welcome' do
    let(:expected_output) { described_class.welcome.join }
    it { expect(expected_output.class).to be(String) }
  end

  describe '.rules' do
    let(:expected_output) { described_class.rules.join }
    it { expect(expected_output.class).to be(String) }
  end
end
