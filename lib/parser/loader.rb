# frozen_string_literal: true

require 'parser'
require 'parser/line_checker'

module Parser
  # Loads and parses the webserver log
  class Loader
    def initialize(file_path: nil, writer: $stdout)
      @file_path = file_path
      @line_checks = []
      @writer = writer
      sanity_checks
    end

    def visits
      File.open(file_path).each_with_index do |line, index|
        line_number = index + 1
        line_checks << LineChecker.new(line, line_number)
      end
      print_errors
      to_visit_records
    end

    private

    attr_reader :file_path, :line_checks, :writer

    def sanity_checks
      raise ArgumentError, 'file_path required' unless file_path
      raise ArgumentError, "file_path: #{file_path} not found" unless File.exist?(file_path)
    end

    def line_checker_errors
      line_checks.reject(&:valid?)
    end

    def print_errors
      line_checker_errors.each do |invalid_line_check|
        writer.puts "cannot parse 'invalid line in file' at line #{invalid_line_check.line_number}"
      end
    end

    def to_visit_records
      line_checks.select(&:valid?).map(&:visit_record)
    end
  end
end
