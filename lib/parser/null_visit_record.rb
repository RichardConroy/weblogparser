require 'parser'

module Parser
  class NullVisitRecord
    def initialize(line:, line_number:)
      @line, @line_number = line, line_number
      @url, @ip = nil, nil
    end

    attr_reader :url, :ip, :line, :line_number
  end
end
