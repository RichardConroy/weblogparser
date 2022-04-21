# frozen_string_literal: true

require 'parser'
require 'parser/visit_record'
# require 'singleton'

module Parser
  # A strongly typed collection for VisitRecord instances
  class Repository
    # include Singleton

    def initialize(storage: [])
      @storage = storage
    end

    def store(visit)
      case visit
      when VisitRecord
        storage << visit
      when Array
        visit.each { |element| store(element) } # TODO: would like to make this pseudo transactional
      else
        raise TypeError, "only VisitRecord or arrays of VisitRecord supported. Received: #{visit.class}"
      end
    end

    def all
      storage.dup
    end

    private

    attr_accessor :storage
  end
end
