require 'parser'
require 'parser/loader'
require 'parser/repository'
require 'parser/query/absolute_visits'

module Parser
  module CLI
    class << self
      def run(argv: ARGV)
        print_help unless argv[0]
        loader = Loader.new(file_path: argv[0])
        Repository.instance.store loader.visits
        print "Page (absolute visits)"
        puts
        Query::AbsoluteVisits.call.map{|t| puts "#{t.last.first} #{t.first}"}

      rescue StandardError => e
        print_help
        puts e.message
        puts e.backtrace
      end

      def print_help
        puts 'Usage: parser <file>'
      end
    end
  end
end
