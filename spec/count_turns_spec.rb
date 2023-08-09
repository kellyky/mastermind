require './lib/mm'
require 'pry-byebug'

describe CountTurns do
  describe '.initalize' do
    let(:a) { :red }
    let(:b) { :red }
    let(:c) { :red }
    let(:d) { :red }
    subject { described_class.new(a, b, c, d)}

    before {subject}
    it '...' do
      binding.pry
    end
  end
  describe '.run_through_turns' do
    let(:turns_done) { 0 }


    # if turns_done > 12 - hm... returns?
    context 'when turns_done is 12 or less' do
      # maybe test the method it calls - currently just using a placeholder
    end

    context 'when turns_done is more than 12' do
      # maybe test the method it calls - currently just using a placeholder
    end
  end
end
