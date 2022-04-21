# frozen_string_literal: true

require 'parser'
require 'parser/repository'
require 'pry'

module Parser
  module Query
    # Command class to interrogate the repository and return the visit counts ordered descending
    class AbsoluteVisits
      class << self
        def call(**args)
          new(**args).query
        end
      end

      def initialize(repository:)
        @repository = repository
      end

      def query
        repository.all.map(&:to_a)
                  .group_by(&:shift)
                  .map { |url, array| [url, array.count] }
                  .sort_by { |pair| -pair.last }
      end

      private

      attr_accessor :repository
    end
  end
end
