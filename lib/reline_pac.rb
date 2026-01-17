# frozen_string_literal: true

require 'reline'
require_relative 'reline_pac/version'
require_relative 'reline_pac/packages'
require_relative 'reline_pac/config'

# RelinePac provides Reline extensions for completion, history search, and clipboard helpers.
module RelinePac
  class Error < StandardError; end

  def self.configure
    config = Config.new
    yield config if block_given?
    config
  end
end
