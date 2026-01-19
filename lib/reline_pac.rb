# frozen_string_literal: true

require 'reline'
require_relative 'reline_pac/version'
require_relative 'reline_pac/packages'
require_relative 'reline_pac/config'
require_relative 'reline_pac/introspection'
# Load commands only if IRB is available
require_relative 'reline_pac/irb_commands' if defined?(IRB)

# RelinePac provides Reline extensions for completion, history search, and clipboard helpers.
module RelinePac
  class Error < StandardError; end

  def self.configure
    config = Config.new
    yield config if block_given?
    config
  end
end
