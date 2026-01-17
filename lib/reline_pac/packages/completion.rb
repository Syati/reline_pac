# frozen_string_literal: true

module RelinePac
  module Packages
    module Completion
      module Methods
        def completion_dialog_visible?
          dialog = @dialogs.find { |d| d.name == :autocomplete }
          dialog&.contents
        end

        def completion_next(key)
          if completion_dialog_visible?
            menu_complete(key)
          else
            ed_next_history(key)
          end
        end

        def completion_prev(key)
          if completion_dialog_visible?
            menu_complete_backward(key)
          else
            ed_prev_history(key)
          end
        end
      end

      def self.install
        return unless defined?(Reline::LineEditor)
        return if Reline::LineEditor < Methods

        Reline::LineEditor.prepend(Methods)
      end
    end
  end
end
