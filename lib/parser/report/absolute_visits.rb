# frozen_string_literal: true

require 'parser/query/absolute_visits'

module Parser
  module Report
    # Report generator for printing out the results of the absolute visits to each url
    class AbsoluteVisits
      class << self
        def format(**args)
          new(**args).format
        end
      end

      def initialize(query: Query::AbsoluteVisits, writer: $stdout, repository:)
        @query, @writer, @repository = query, writer, repository
      end

      def format
        writer.puts 'Page (absolute visits)'
        query.call(repository: repository).each  do
          |visit_count| writer.puts "#{visit_count.first} #{visit_count.last} visits"
        end
      end

      private

      attr_reader :query, :writer, :repository
    end
  end
end
