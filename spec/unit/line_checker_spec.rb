# frozen_string_literal: true

require 'parser/line_checker'
require 'parser/null_visit_record'

describe Parser::LineChecker do
  let(:line) { nil }
  let(:line_number) { 5 }
  subject { described_class.new(line, line_number) }
  describe '#valid?' do
    context 'with nil' do
      it { expect(subject.valid?).to eq false }
    end

    context 'with "/index 192.168.1.1' do
      let(:line) { '/index 192.168.1.1' }

      it { expect(subject.valid?).to eq true }
    end

    context 'with "/home_2unique_3repeat 184.123.665.067' do
      let(:line) { '/home_2unique_3repeat 184.123.665.067' }

      it { expect(subject.valid?).to eq true }
    end

    context 'with indefinite whitespace' do
      let(:line) { '/home/1     184.123.665.067' }

      it { expect(subject.valid?).to eq true }
    end

    context 'with non standard paths"' do
      let(:line) { 'no-leading-slash 184.123.665.067' }

      it 'still considers it valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'with non-rfc ip addresses' do
      let(:line) { '/help 1.2.3.4.5.6.7.8' }

      it 'still considers it valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'with domain names for visitors' do
      let(:line) { '/help example.com' }

      it 'still considers it valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'with all one word' do
      let(:line) { '/home_2unique_3repeat___184.123.665.067' }

      it { expect(subject.valid?).to eq false }
    end

    context 'with too many words' do
      let(:line) { 'the quick brown url jumps over the lazy ip address' }

      it { expect(subject.valid?).to eq false }
    end

    context 'with just whitespace' do
      let(:line) { '    ' }

      it { expect(subject.valid?).to eq false }
    end

    context 'with comments' do
      let(:line) { '# config' }

      # TODO: this is the point where you want to consider how RFC valid
      # you want the parser to be. Put enough tests here to be a starting
      # point for it
      xit { expect(subject.valid?).to eq false }
    end
  end

  describe '#visit_record' do
    context 'when invalid' do
      let(:line) { 'kablooie' }

      it { expect(subject.visit_record).to be_a_kind_of Parser::NullVisitRecord }
      it { expect(subject.visit_record.url).to be_nil }
      it { expect(subject.visit_record.ip).to be_nil }
      it { expect(subject.visit_record.line).to eq line }
      it { expect(subject.visit_record.line_number).to eq 5 }
    end

    context 'with "/index 192.168.1.1' do
      let(:line) { '/index 192.168.1.1' }

      it { expect(subject.visit_record.url).to eq '/index' }
      it { expect(subject.visit_record.ip).to eq '192.168.1.1' }
    end
  end
end
