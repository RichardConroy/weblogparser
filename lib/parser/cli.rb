# frozen_string_literal: true

require 'parser'
require 'parser/loader'
require 'parser/repository'
require 'parser/report/absolute_visits'
require 'pry'

module Parser
  # System entry point for kicking off all the concerns from the terminal
  class CLI
    class << self
      def run(argv: ARGV)
        new(argv: argv).run
      end
    end

    def initialize(argv: )
      @file_path = argv[0]
    end

    def run
      print_help unless file_path
      process_log_file
      Report::AbsoluteVisits.format
    rescue StandardError => error
      rescue_actions(error)
    end

    private

    def process_log_file
      loader = Loader.new(file_path: file_path)
      Repository.instance.store loader.visits
    end

    def print_help
      puts 'Usage: parser <file>'
    end

    def rescue_actions(error)
      print_help
      puts error.message
      puts error.backtrace
    end

    attr_reader :file_path
  end
end
