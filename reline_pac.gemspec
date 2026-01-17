# frozen_string_literal: true

require_relative 'lib/reline_pac/version'

Gem::Specification.new do |spec|
  spec.name = 'reline_pac'
  spec.version = RelinePac::VERSION
  spec.authors = ['mizuki-y']
  spec.email = ['mizuki-y@syati.info']

  spec.summary = 'Reline extensions adding completion navigation, fzf history search, and macOS clipboard helpers'
  spec.description = ''
  spec.homepage = 'https://github.com/Syati/reline_pac'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.3.10'

  spec.require_paths = ['lib']
  spec.files = Dir[
    'LICENSE.txt',
    'CHANGELOG.md',
    'lib/**/*.rb',
    'sig/**/*.rbs'
  ]

  spec.metadata = {
    'homepage_uri' => 'https://github.com/Syati/reline_pac#readme',
    'changelog_uri' => 'https://github.com/Syati/reline_pac/blob/main/CHANGELOG.md',
    'bug_tracker_uri' => 'https://github.com/Syati/reline_pac/issues',
    'source_code_uri' => 'https://github.com/Syati/reline_pac',
    'rubygems_mfa_required' => 'true'
  }

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'reline', '>= 0.5.10', '< 0.7.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
