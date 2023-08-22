require './lib/play_mastermind'
require 'pry-byebug'
require 'stringio'

describe SpyRole do
  describe '.set_codebreaker' do
    # ? need test that it calls print_spy_role_message
    # ? need test that it calls answer
    # ? need test that it calls evaluate_choice
  end

  describe '.print_spy_role_message' do
    subject { described_class.print_spy_role_message }
    let(:line_1) { "Do you want to set the code or break the code?\n\n" }
    let(:line_2) { "(1 = set the code, 2 = break the code)\n\n" }

    it { expect { subject }.to output(line_1 + line_2).to_stdout }
  end

  describe '.answer' do
    context 'when the player selects "1" (code maker)' do
      it 'returns 1' do
        code_maker = StringIO.new('1')
        described_class.stub(:gets).and_return("1\n")
        expect(described_class.answer).to eq("1")
      end
    end

    # FIX
    context 'when the player selects "2" (code breaker)' do
      it 'returns 2' do
        code_breaker = StringIO.new('2')
        described_class.stub(:gets).and_return("2\n")
        expect(described_class.answer).to eq("2")
      end

    end

    # FIX
    context 'when the player selects "3" (secret test mode)' do
      it 'returns 2' do
        described_class.stub(:gets).and_return("3\n")
        expect(described_class.answer).to eq("3")
      end
    end

    # FIX
    context 'when the player selects an invalid option' do
      let(:tester) { StringIO.new('3') }
      let(:invalid) { "yo" }
      it '...' do
        described_class.stub(:gets).and_return("placeholder")
        expect(described_class.answer).to eq("placeholder")
      end
    end
  end

  describe '.evaluate_choice' do
  end

  describe '.computer_code_breaker' do
  end

  describe '.player_code_breaker' do
  end

  describe '.test_mode' do
  end
end
