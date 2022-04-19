require 'parser'

module Parser
  module CLI
    class << self
      def run(args: ARGV)
        puts 'Usage: parser <file>'
      end
    end
  end
end
