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
        /about/2 90 visits
        /contact 89 visits
        /index 82 visits
        /about 81 visits
        /help_page/1 80 visits
        /home 78 visits
      EXPECTED
    end

    it 'displays absolute hits by page ordered DESC' do
      expect { cli }.to output(absolute_report).to_stdout
    end
  end

  context 'with abbreviated log' do
    let(:arguments) { ['spec/fixtures/personal.log'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }
    let(:absolute_report) do
      <<~ABBREVIATED
        Page (absolute visits)
        /contact_with_6_repeat_visits 6 visits
        /help_page_with_5_unique 5 visits
        /home_2unique_3repeat 5 visits
      ABBREVIATED
    end

    it 'displays absolute hits by page ordered DESC' do
      expect { cli }.to output(absolute_report).to_stdout
    end
  end

  context 'with log file containing invalid record' do
    let(:arguments) { ['spec/fixtures/3rd_line_invalid.log'] }
    subject(:cli) { ::Parser::CLI.run(argv: arguments) }

    it { expect { cli }.to output(/cannot parse 'invalid line in file' at line 3/).to_stdout }

    # TODO: if I have time test exit status in a better way (maybe use Aruba)
    xit { expect { cli }.to raise_error(SystemExit) }
  end
end
