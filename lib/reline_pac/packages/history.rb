# frozen_string_literal: true

module RelinePac
  module Packages
    # History provides fzf-powered history search for Reline.
    module History
      # Methods adds fzf history search to Reline::LineEditor.
      module Methods
        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        def fzf_history(_key)
          all_history = Reline::HISTORY.to_a
          return if all_history.empty?

          seen = {}
          filtered = all_history.reverse.filter_map do |h|
            stripped = h.strip
            next if stripped.empty? || seen[stripped]

            seen[stripped] = true
            h
          end

          display = filtered.map { |h| h.gsub("\n", '⏎') }

          selected_index = nil
          ::IO.popen("fzf --reverse --border --query='#{line}' --with-nth=1 --delimiter=$'\\t'", 'r+') do |io|
            display.each_with_index { |d, i| io.puts "#{d}\t#{i}" }
            io.close_write
            result = io.read.strip
            selected_index = result.split("\t").last.to_i unless result.empty?
          end

          selected_text = selected_index ? filtered[selected_index] : whole_buffer
          reset_line
          insert_multiline_text(selected_text)
          $stdout.write prompt_list.last
          if selected_text.include?("\n")
            $stdout.write selected_text.split("\n").last
          else
            $stdout.write line
          end
        end
        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      end

      def self.install
        return unless defined?(Reline::LineEditor)
        return if Reline::LineEditor < Methods

        Reline::LineEditor.prepend(Methods)
      end
    end
  end
end
