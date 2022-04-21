# frozen_string_literal: true

require 'parser'
require 'parser/loader'
require 'parser/repository'
require 'parser/report/absolute_visits'
require 'parser/query/unique_visits'
require 'pry'

module Parser
  # System entry point for kicking off all the concerns from the terminal
  class CLI
    class << self
      def run(argv: ARGV, writer: $stdout)
        new(argv: argv, writer: writer).run
      end
    end

    def initialize(argv:, writer:)
      @file_path = argv[0]
      @writer = writer
      @repository = Repository.new
    end

    def run
      print_help unless file_path
      process_log_file
      print_reports
    rescue StandardError => error
      rescue_actions(error)
    end

    private

    def process_log_file
      loader = Loader.new(file_path: file_path, writer: writer)
      repository.store loader.visits
    end

    def print_reports
      Report::AbsoluteVisits.format query: Query::AbsoluteVisits, writer: writer, repository: repository
      Report::AbsoluteVisits.format query: Query::UniqueVisits, writer: writer, repository: repository
    end

    def print_help
      writer.puts 'Usage: parser <file>'
    end

    def rescue_actions(error)
      print_help
      writer.puts error.message
      writer.puts error.backtrace
    end

    attr_reader :file_path, :writer, :repository
  end
end
