# frozen_string_literal: true

require_relative 'lib/parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'parser'
  spec.version       = Parser::VERSION
  spec.authors       = ['Richard Conroy']
  spec.email         = ['richard.conroy@gmail.com']

  spec.summary       = 'Coding exercise'
  spec.homepage      = 'http://example.com/placeholder'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://example.com/placeholder'
  spec.metadata['changelog_uri'] = 'http://example.com/placeholder_changelog'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'pronto'
  spec.add_development_dependency 'pronto-flay'
  spec.add_development_dependency 'pronto-reek'
  spec.add_development_dependency 'pronto-rubocop'
  spec.add_development_dependency 'pronto-undercover'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-lcov'
  spec.add_development_dependency 'undercover'
end
