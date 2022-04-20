require 'parser'
require 'parser/visit_record'
require 'parser/null_visit_record'

module Parser
  class LineChecker
    def initialize(line, line_number)
      @line, @line_number = line, line_number

    end

    def valid?
      split_line&.count == 2 # TODO:
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

    # attr_accessor :line, :line_number


    def split_line
      @_split_line ||= line&.split
    end
  end
end
