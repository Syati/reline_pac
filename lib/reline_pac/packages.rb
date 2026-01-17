# frozen_string_literal: true

require 'reline'
require_relative 'packages/completion'
require_relative 'packages/clipboard'
require_relative 'packages/history'

module RelinePac
  module Packages
    DEFAULT_KEYBINDS = {
      "\C-y" => :pbpaste,
      "\C-k" => :pbcopy_kill,
      "\C-r" => :fzf_history,
      "\C-n" => :completion_next,
      "\C-p" => :completion_prev
    }.freeze

    def self.install_all
      [Completion, Clipboard, History].each(&:install)
    end
  end
end
