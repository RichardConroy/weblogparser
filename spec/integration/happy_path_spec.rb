# frozen_string_literal: true

require 'parser/cli'
require 'pry'

describe 'command line interface' do
  context 'with no arguments' do
    subject(:cli) { ::Parser::CLI.run }
    it 'prints the help' do
      expect { cli }.to output(/Usage: parser <file>/).to_stdout
    end
  end

  context 'with unknown arguments' do
    let(:arguments) { ['--foo'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }

    it 'prints the help' do
      expect { cli }.to output(/Usage: parser <file>/).to_stdout
    end
  end

  context 'with smart pension webserver.log' do
    let(:arguments) { ['spec/fixtures/webserver.log'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }
    let(:absolute_report) do
      <<~EXPECTED
        Page (absolute visits)
        /about/2 90
        /contact 89
        /index 82
        /about 81
        /help_page/1 80
        /home 78
      EXPECTED
    end

    it 'displays absolute hits by page ordered DESC' do
      expect { cli }.to output(absolute_report).to_stdout
    end
  end

  context 'with log file containing invalid record' do
    let(:arguments) { ['spec/fixtures/3rd_line_invalid.log'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }

    it { expect { cli }.to output(/cannot parse 'invalid line in file' at line 3/).to_stdout }
    it { expect { cli }.to raise_error(SystemExit) }
  end
end
