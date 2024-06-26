# frozen_string_literal: true

require 'pry-byebug'
require 'stringio'

require_relative '../lib/color_selector'
require_relative '../lib/pretty_display'

RSpec.describe ColorSelector do
  subject(:color_selector) do
    described_class.new(code_maker, code_breaker, difficulty, code_length, guesses_left)
  end

  let(:code_breaker) { :player }
  let(:code_maker) { :computer }
  let(:difficulty) { :standard }
  let(:code_length) { 4 }
  let(:guesses_left) { 12 }
  let(:color_bank) { %i[red orange yellow green blue indigo violet] }

  before { ColorSelector.class_variable_set(:@@color_bank, color_bank) }

  describe '#color_bank' do
    context 'when beginner difficulty' do
      let(:difficulty) { :beginner }
      it 'should return the first 4 colors in the color bank' do
        expect(color_selector.color_bank).to eq(color_bank.first(4))
      end
    end

    context 'when easy difficulty' do
      let(:difficulty) { :easy }
      it 'should return the first 5 colors in the color bank' do
        expect(color_selector.color_bank).to eq(color_bank.first(5))
      end
    end

    context 'when standard difficulty' do
      it 'should return the all 7 colors in the color bank' do
        expect(color_selector.color_bank).to eq(color_bank)
      end
    end
  end

  describe '#code_length' do
    let(:code_length) { 2 }
    it 'should return the value of @@code_length' do
      expect(color_selector.code_length).to eq(2)
    end
  end

  describe '#difficulty' do
    let(:difficulty) { :beginner }
    it 'should return the value of @@difficulty' do
      expect(color_selector.difficulty).to eq(:beginner)
    end
  end

  describe '#encode_colors' do
    context 'when code maker is the computer' do
      it 'should call computer_select_colors' do
        expect(color_selector).to receive(:computer_select_colors)
        color_selector.encode_colors
      end
    end

    context 'when code maker is the player' do
      let(:code_maker) { :player }

      # TODO: look into if this is a solid test approach for this?
      it 'should instantiate player with guesses_left' do
        expect_any_instance_of(ColorSelector::Player).to receive(:initialize).with(guesses_left)
        expect_any_instance_of(ColorSelector::Player).to receive(:select_colors)
        color_selector.encode_colors
      end
    end
  end

  describe '#break_code' do
    context 'when @@code_breaker is computer' do
      let(:code_breaker) { :computer }
      it 'should call computer_select_colors' do
        expect(color_selector).to receive(:computer_select_colors)
        color_selector.break_code(guesses_left)
      end
    end

    context 'when @@code_breaker is player' do
      let(:player) { ColorSelector::Player.new(guesses_left) }

      it 'should call Player.new(guesses_left).select_colors' do
        expect_any_instance_of(ColorSelector::Player).to receive(:select_colors)
        color_selector.break_code(guesses_left)
      end
    end
  end

  describe '#show_color_bank' do
    let(:mock_color_selector) { double('ColorSelector') }
    let(:color_bank) { %i[red orange yellow green blue indigo violet] }

    before do
      allow(mock_color_selector).to receive(:color_bank).and_return(color_bank)
    end

    it 'should iterate over each color' do
      color_bank.each do |color|
        expect(PrettyDisplay).to receive(:color_text).with(color)
      end
      color_selector.show_color_bank
    end
  end

  describe '#print_guesses_left' do
    context 'when ZERO guesses remain' do
      let(:guesses_left) { 0 }
      it 'should print last guess message' do
        expect(color_selector.print_guesses_left).to eq(
          'This is your last guess. Make it count!'
        )
      end
    end

    context 'when guesses remain' do
      let(:guesses_left) { 1 }
      it 'should print last guess message' do
        expect(color_selector.print_guesses_left).to eq(
          # Currently guesses_left refers to *after* the current turn
          "You have #{guesses_left + 1} guesses left."
        )
      end
    end
  end

  describe '#computer_selected_colors' do
    before do
      allow(color_selector).to receive(:color_bank).and_return(color_bank)
    end

    context 'when the code length is 4' do
      it 'should return a 4-item array' do
        expect(color_selector.computer_select_colors.size).to eq(4)
      end

      it 'should return only colors from the color_bank' do
        selected_colors = color_selector.computer_select_colors.uniq
        expect(selected_colors.all? { |color| color_bank.include?(color) }).to be(true)
      end
    end

    context 'when the code length is 2' do
      let(:code_length) { 2 }
      it 'should return a 2-item array' do
        expect(color_selector.computer_select_colors.size).to eq(2)
      end
    end
  end

  describe ColorSelector::Player do
    subject(:player) { described_class.new(guesses_left) }

    describe '#select_colors' do
      before do
        ColorSelector.class_variable_set(:@@difficulty, :standard)
        ColorSelector.class_variable_set(:@@code_length, 4)
        allow(player).to receive(:gets).and_return("red\n", "ora\n", "yel\n", "blu\n")
      end

      it 'should call show_guessing_round_intro' do
        expect(player).to receive(:show_guessing_round_intro)
        player.select_colors
      end

      # TODO: Revisit the logic here. Passes currently but I'm not sure it should
      it 'calls select_color until @selected_colors is the correct length' do
        expect(player).to receive(:select_color).exactly(4).times.and_call_original
        player.select_colors
        expect(player.instance_variable_get(:@selected_colors).size).to eq(4)
      end

      it '@selected_colors returns the user-selected colors' do
        player.select_colors
        expect(player.instance_variable_get(:@selected_colors)).to eq(%i[red orange yellow blue])
      end

      it 'adds only valid player-entered colors to @selected_colors' do
        allow(player).to receive(:gets).and_return("red\n", '123', "", "ora\n", "yel\n", "blu\n")
        expect(subject).to receive(:handle_invalid_color).and_return(true).exactly(2).times.and_call_original
        player.select_colors
        expect(player.instance_variable_get(:@selected_colors)).to eq(%i[red orange yellow blue])
      end
    end

    describe '#show_guessing_round_intro' do
      it 'should display message to player to pick an available color' do
        try_again_message = "Hm, I don't know that one. Please choose an available color."
        allow(player).to receive(:select_color)
        expect(PrettyDisplay).to receive(:puts_pause).with(try_again_message)
        player.handle_invalid_color
      end

      it 'should call select_color' do
        expect(player).to receive(:select_color)
        player.handle_invalid_color
      end
    end

    describe '#select_color' do
      let(:chosen_color) { 'orange' }
      let(:standardized_color) { colors[chosen_color.strip.downcase.slice(0..2).to_sym] }
      let(:colors) do
        # COLORS map in ColorSelector
        {
          red: :red,
          ora: :orange,
          yel: :yellow,
          gre: :green,
          blu: :blue,
          ind: :indigo,
          vio: :violet
        }.freeze
      end

      before { allow(player).to receive(:player_choice).and_return(chosen_color, 'red') }

      context 'when the color is in the color bank' do
        it 'gets added to @selected_colors' do
          expect(player.select_color.include?(standardized_color)).to be(true)
        end
      end

      context 'when the first 3 characters of the color matches a color in the bank' do
        let(:chosen_color) { 'bluuuuuuu' }
        it 'gets added to @selected_colors' do
          expect(player.select_color.include?(standardized_color)).to be(true)
        end
      end

      context 'when the color is invalid (i.e. not in the color bank)' do
        let(:chosen_color) { 'typo' }

        before do
          allow(player).to receive(:player_choice).and_return(chosen_color, 'red')
          allow(player).to receive(:select_color).and_call_original
        end

        it 'should prompt the player to select another color' do
          expect(player).to receive(:select_color).twice
          player.select_color
        end
      end
    end

    describe '#player_choice' do
      it 'should return the player input' do
        user_input = 'indigo'
        player.stub(:gets).and_return(user_input)
        expect(player.player_choice).to eq(user_input)
      end
    end
  end
end
