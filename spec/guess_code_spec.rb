require './lib/mm'
require 'pry-byebug'

describe GuessCode do
  subject { described_class.new(:red, :green, :blue, :yellow) }
  describe '#color_1' do
    it { expect(subject.color_1.class).to be(Symbol) }
    it { expect(subject.color_1).to be(:red) }
  end

  describe '#color_2' do
    it { expect(subject.color_2.class).to be(Symbol) }
    it { expect(subject.color_2).to be(:green) }
  end

  describe '#color_3' do
    it { expect(subject.color_3.class).to be(Symbol) }
    it { expect(subject.color_3).to be(:blue) }
  end

  describe '#color_4' do
    it { expect(subject.color_4.class).to be(Symbol) }
    it { expect(subject.color_4).to be(:yellow) }
  end

  describe '#all_colors' do
    let(:third_color) { subject.all_colors[2] }
    it { expect(subject.all_colors.class).to be(Array) }
    it { expect(subject.all_colors.length).to be(4) }
    it { expect(third_color).to be(subject.color_3) }
  end
end