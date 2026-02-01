# frozen_string_literal: true

require 'irb'

module RelinePac
  module IrbCommands
    # IRB command to display Reline keybindings
    class Keybinds < ::IRB::Command::Base
      category 'Context'
      description 'Show Reline keybindings'

      def execute(_arg)
        bindings = RelinePac::Introspection.keymap
        max_key_length = bindings.keys.map(&:length).max

        bindings.each do |key, method|
          puts "#{key.ljust(max_key_length + 2)} #{method}"
        end
      end
    end
  end
end

# IRB が読み込まれている場合のみ登録
IRB::Command.register(:show_keybinds, RelinePac::IrbCommands::Keybinds) if defined?(IRB::Command)
