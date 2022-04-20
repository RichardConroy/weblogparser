# frozen_string_literal: true

require 'parser'
require 'parser/loader'
require 'parser/repository'
require 'parser/report/absolute_visits'

module Parser
  # System entry point for kicking off all the concerns from the terminal
  module CLI
    class << self
      def run(argv: ARGV)
        print_help unless argv[0]
        loader = Loader.new(file_path: argv[0])
        Repository.instance.store loader.visits

        Report::AbsoluteVisits.format
      rescue StandardError => e
        rescue_actions(e)
      end

      def print_help
        puts 'Usage: parser <file>'
      end

      def rescue_actions(error)
        print_help
        puts error.message
        puts error.backtrace
      end
    end
  end
end
