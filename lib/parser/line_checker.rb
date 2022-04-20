# frozen_string_literal: true

require 'parser'
require 'parser/visit_record'
require 'parser/null_visit_record'

module Parser
  # Per line validator and parser
  class LineChecker
    def initialize(line, line_number)
      @line = line
      @line_number = line_number
    end

    def valid?
      split_line&.count == 2 # TODO: we can do a more robust regex here
    end

    def visit_record
      if valid?
        VisitRecord.new url: split_line[0], ip: split_line[1]
      else
        NullVisitRecord.new line: line, line_number: line_number
      end
    end

    attr_reader :line, :line_number

    private

    def split_line
      @split_line ||= line&.split
    end
  end
end
