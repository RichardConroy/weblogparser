require 'parser/cli'
describe 'command line interface' do
  context 'with no arguments' do
    subject(:cli) { ::Parser::CLI.run }
    it 'prints the help' do
      expect { cli }.to output(/Usage: parser <file>/).to_stdout
    end
  end

  context 'with unknown arguments' do
    let(:argv) { ['--foo'] }
    subject(:cli) { ::Parser::CLI.run(args: argv) }

    it 'prints the help' do
      expect { cli }.to output(/Usage: parser <file>/).to_stdout
    end
  end
end
