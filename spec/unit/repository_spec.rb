# frozen_string_literal: true

require 'parser/repository'
require 'parser/visit_record'

describe Parser::Repository do
  describe '#store' do
    context 'with VisitRecord' do
      let(:argument) { Parser::VisitRecord.new url: '/home', ip: '192.168.1.1' }

      it { expect { subject.store(argument) }.not_to raise_error }
      it 'adds it to the internal storage' do
        expect { subject.store(argument) }.to change { subject.all.count }.by(1)
      end
    end

    context 'with VisitRecord array' do
      let(:argument) do
        [
          Parser::VisitRecord.new(url: '/home', ip: '192.168.1.1'),
          Parser::VisitRecord.new(url: '/home', ip: '192.168.1.1'),
          Parser::VisitRecord.new(url: '/home', ip: '192.168.1.2'),
          Parser::VisitRecord.new(url: '/help', ip: '192.168.1.3')
        ]
      end

      it { expect { subject.store(argument) }.not_to raise_error }
      it 'adds it to the internal storage' do
        expect { subject.store(argument) }.to change { subject.all.count }.by(4)
      end
    end

    context 'with string' do
      it { expect { subject.store('kaboom') }.to raise_error(TypeError) }
      it 'does not add to storage' do
        expect do
          subject.store('kaboom')
        rescue StandardError
          nil
        end.not_to(change { subject.all.count })
      end
    end
  end
end
