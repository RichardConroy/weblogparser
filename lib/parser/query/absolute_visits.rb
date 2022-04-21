# frozen_string_literal: true

require 'parser'
require 'parser/repository'
require 'pry'

module Parser
  module Query
    # Command class to interrogate the repository and return the visit counts ordered descending
    class AbsoluteVisits
      class << self
        def call
          new.query
        end
      end

      def initialize(repository = Repository.instance)
        @repository = repository
      end

      def query
        # binding.pry
        repository.all.map { |vr| [vr.url, vr.ip] }
          .group_by { |entry| entry.shift }   # => {'/home' => [[ip2],[ip2]..], '/contact' => [...]}
          .map { |url, array| [url, array.count] } # => [['/home', 2],['/contact',5]...]
          .sort_by { |tuple| -tuple.last }
        # uniq_urls.group_by { |url| urls.count(url) }.sort_by { |tuple| -tuple.first }
      end

      private

      def uniq_urls
        urls.uniq
      end

      def urls
        @urls ||= repository.all.map(&:url)
      end

      attr_accessor :repository
    end
  end
end
