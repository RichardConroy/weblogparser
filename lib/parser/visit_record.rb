# frozen_string_literal: true

require 'parser'

module Parser
  # PORO to capture a named pair of url (visited) and ip address (visitor) for storing in the repository
  class VisitRecord
    def initialize(url:, ip:)
      @url = url
      @ip = ip
    end

    attr_reader :url, :ip
  end
end
