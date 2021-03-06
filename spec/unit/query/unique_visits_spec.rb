# frozen_string_literal: true

require 'parser/query/unique_visits'
require 'parser/repository'
require 'parser/visit_record'

describe Parser::Query::UniqueVisits do
  let(:repository) { Parser::Repository.new }
  subject { described_class.new(repository: repository) }

  describe '#query' do
    context 'with empty repository' do
      it { expect(subject.query).to eq [] }
    end

    context 'with 1 visit record' do
      let(:url) { '/home' }
      let(:ip) { '192.168.1.1' }
      let(:visit_record) { Parser::VisitRecord.new url: url, ip: ip }
      before { repository.store visit_record }

      it { expect(subject.query).to eq [[url, 1]] }
    end

    context 'with multiple non-unique records for same url' do
      let(:url) { '/home' }
      let(:ip) { '192.168.1.1' }
      before do
        4.times { repository.store(Parser::VisitRecord.new(url: url, ip: ip)) }
      end

      it 'returns a single entry pair with a unique hit count' do
        expect(subject.query).to eq [[url, 1]]
      end
    end

    context 'with multiple records for different urls' do
      let(:url) { '/home' }
      let(:url_about) { '/about' }
      let(:ip) { '192.168.1.1' }
      before do
        2.times { repository.store(Parser::VisitRecord.new(url: url_about, ip: ip)) }
        6.times { |n| repository.store(Parser::VisitRecord.new(url: url, ip: "192.128.1.#{n}")) }
        2.times { |_n| repository.store(Parser::VisitRecord.new(url: url, ip: '192.128.1.22')) }
      end

      it 'returns a two pairs with a total unique hit count ordered desc' do
        expect(subject.query).to eq [[url, 7], [url_about, 1]]
      end
    end
  end
end
