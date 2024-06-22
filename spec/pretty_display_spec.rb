# frozen_string_literal: true

require 'stringio'

require 'pry-byebug'
require 'rainbow'

require_relative '../lib/game_intro'

describe PrettyDisplay do
  let(:seconds) { 0.01 }
  let(:text) { "woo, I'm text!" }

  describe '.puts_pause' do
    context 'when no text is passed' do
      it 'should display 2 empty lines' do
        expect { described_class.puts_pause }.to output("\n\n").to_stdout
      end
    end

    context 'when text is passed' do
      context 'and newlines are not specified' do
        context 'and pause duration is not specified' do
          it 'should display the text passed and 1 newline(\n)' do
            expect { described_class.puts_pause(text) }.to output("#{text}\n").to_stdout
          end
        end
      end

      context 'and newlines are specified' do
        let(:newlines) { 2 }
        let(:newlines_output) { "\n\n" }

        context 'and no pause duration is specified' do
          subject { described_class.puts_pause(text, newlines) }
          it { expect { subject }.to output(text + newlines_output).to_stdout }
        end

        context 'and pause duration is specified' do
          subject { described_class.puts_pause(text, newlines, seconds) }

          it { expect { subject }.to output(text + newlines_output).to_stdout }
        end
      end
    end
  end

  describe '.animated_elipses' do
    context 'when no time pause is specified' do
      subject { described_class.animated_elipses }
      it { expect { subject }.to output('...').to_stdout }
    end

    context 'when a time pause *is* specified' do
      subject { described_class.animated_elipses(seconds) }

      it { expect { subject }.to output('...').to_stdout }
    end
  end

  describe '.animated_text' do
    subject { described_class.animated_text }

    context 'when no text is passed' do
      it { expect { subject }.to output('...').to_stdout }
    end

    context 'when text is passed' do
      context 'and no pause (seconds) is specified' do
        subject { described_class.animated_text(text) }
        it { expect { subject }.to output(text).to_stdout }
      end

      context 'and a pause (seconds) *is* specified' do
        subject { described_class.animated_text(text, seconds) }
        it { expect { subject }.to output(text).to_stdout }
      end
    end
  end

  describe '.color_text' do
    context 'when passed a color in COLOR_MAP' do
      it 'should call a singleton method of that name' do
        expect(described_class).to receive(:blue)
        described_class.color_text(:blue)
      end
    end

    context 'when passed an invalid color' do
      it 'should raise ArgumentError' do
        color = 'pink'
        expect { described_class.color_text(color) }.to raise_error(ArgumentError, "Invalid color: #{color}")
      end
    end
  end

  describe 'colorizing methods' do
    PrettyDisplay::COLOR_MAP.each do |color, _|
      it 'should colorize text in #{color}' do
        expect { described_class.send(color) }.to output(
          "#{Rainbow(color.to_s).send(PrettyDisplay::COLOR_MAP[color])} | "
        ).to_stdout
      end
    end
  end
end
