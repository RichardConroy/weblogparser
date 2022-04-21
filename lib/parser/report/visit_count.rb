# frozen_string_literal: true

module Parser
  module Report
    # Report generator for printing out the results of the absolute visits to each url
    class VisitCount
      class << self
        def format(**args)
          new(**args).format
        end
      end

      def initialize(repository:, query:, writer: $stdout)
        @query = query
        @writer = writer
        @repository = repository
      end

      def format
        writer.puts title
        query.call(repository: repository).each do |visit_count|
          writer.puts "#{visit_count.first} #{visit_count.last} visits"
        end
      end

      private

      def title
        "Page (#{query.to_s.split('::').last})" # => Page AbsoluteVisits
      end

      attr_reader :query, :writer, :repository
    end
  end
end
