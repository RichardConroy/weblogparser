require 'parser'

module Parser
  class VisitRecord
    def initialize(url:, ip:)
      @url, @ip = url, ip
    end

    attr_reader :url, :ip

  end
end
