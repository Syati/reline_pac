# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in reline_pac.gemspec
gemspec

reline_version = ENV['RELINE_VERSION'] || '~> 0.6.0'


if reline_version.start_with?('~>')
  gem "reline", reline_version
else
  gem_version = "~> #{reline_version}.0"
  gem 'reline', gem_version
end

group :development, :test do
  gem "rake", "~> 13.0"
  gem "rspec", "~> 3.0"
  gem "rubocop", "~> 1.21"
end
