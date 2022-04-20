require 'parser/cli'
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

    it 'displays absolute hits by page ordered DESC' do
      expect { cli }.to output(/Page (absolute visits)/).to_stdout
      expect { cli }.to output(%r[/index 5]).to_stdout
    end
  end

  context 'with log file containing invalid record' do
    let(:arguments) { ['spec/fixtures/3rd_line_invalid.log'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }

    it 'displays a parser error message' do
      expect { cli }.to output(%r[cannot parse 'invalid line in file' at line 3]).to_stdout
    end
  end
end
