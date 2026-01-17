# frozen_string_literal: true

module RelinePac
  module Packages
    module Clipboard
      module Methods
        def pbpaste(_key)
          text = `pbpaste`.chomp
          insert_text(text)
        end

        def pbcopy_kill(_key)
          cut_text = line.byteslice(byte_pointer..-1)
          return unless cut_text && !cut_text.empty?

          ::IO.popen('pbcopy', 'w') { |io| io.write cut_text }
          delete_text(byte_pointer..-1)
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
