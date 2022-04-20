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
        # TODO: code smells here. Call is giving us { 30 => ['/index'], 50 => ['/help']}. An object would be better
        query.call.map { |visit_count| puts "#{visit_count.last.first} #{visit_count.first}" }
      end

      private

      attr_reader :query
    end
  end
end
