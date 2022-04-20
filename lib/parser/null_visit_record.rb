# frozen_string_literal: true

require 'parser'

module Parser
  # Null Object pattern representation of an unparseable log file line to allow for robust log file iteration
  class NullVisitRecord
    def initialize(line:, line_number:)
      @line = line
      @line_number = line_number
      @url = nil
      @ip = nil
    end

    attr_reader :url, :ip, :line, :line_number
  end
end
