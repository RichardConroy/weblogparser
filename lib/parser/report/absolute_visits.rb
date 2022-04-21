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

      def initialize(query: Query::AbsoluteVisits)
        @query = query
      end

      def format
        puts 'Page (absolute visits)'
        query.call.each { |visit_count| puts "#{visit_count.first} #{visit_count.last} visits" }
      end

      private

      attr_reader :query
    end
  end
end
