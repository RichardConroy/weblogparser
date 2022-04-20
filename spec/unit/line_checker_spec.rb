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
  end

  describe '#visit_record' do
    context 'when invalid' do
      let(:line) { 'kablooie' }

      it { expect(subject.visit_record).to be_a_kind_of Parser::NullVisitRecord }
    end

    context 'with "/index 192.168.1.1' do
      let(:line) { '/index 192.168.1.1' }

      it { expect(subject.visit_record.url).to eq '/index' }
      it { expect(subject.visit_record.ip).to eq '192.168.1.1' }
    end
  end
end
