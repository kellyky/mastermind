require './lib/mm'
require 'pry-byebug'

describe SetCode do
  subject { described_class.all_colors }

  describe '.all_colors' do
    it { expect(subject.class).to be(Array) }
    it { expect(subject.length).to be(4) }
  end
end