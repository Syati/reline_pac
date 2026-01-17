# frozen_string_literal: true

module RelinePac
  # Introspection provides utilities to inspect and debug Reline keybindings.
  module Introspection
    class << self
      # Display all current keybindings in a human-readable format.
      def keymap
        config = Reline.core.config
        bindings = {}

        config.keymap.instance_variable_get(:@key_bindings).each do |key, method|
          # Skip ed_insert as it's used for regular character input
          next if %i[ed_insert ed_digit].include?(method)

          key_str = format_key_sequence(key)

          # Skip if we've already displayed this key
          next if bindings[key_str]

          bindings[key_str] = method
        end
        bindings
      end

      private

      # Format a key sequence (byte array) into a readable string.
      # @param key [Array<Integer>] array of bytes representing the key sequence
      # @return [String] formatted key representation
      # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      def format_key_sequence(key)
        sequence = key.pack('C*')

        case sequence
        when "\e[A", "\eOA" then '↑'
        when "\e[B", "\eOB" then '↓'
        when "\e[C", "\eOC" then '→'
        when "\e[D", "\eOD" then '←'
        when "\e[F", "\eOF" then 'End'
        when "\e[H", "\eOH" then 'Home'
        when "\e[1~", "\e[7~" then 'Home' # rubocop:disable Lint/DuplicateBranch
        when "\e[4~", "\e[8~" then 'End' # rubocop:disable Lint/DuplicateBranch
        when "\e[3~" then 'Delete'
        when "\e[5~" then 'PageUp'
        when "\e[6~" then 'PageDown'
        when "\e[Z" then '⇧Tab'
        when "\e[200~" then 'BracketedPaste'
        when /\e\[1;5([ABCD])/ then "⌃#{arrow_symbol(::Regexp.last_match(1))}"
        when /\e\[1;3([ABCD])/ then "⌥#{arrow_symbol(::Regexp.last_match(1))}"
        when "\e\x1B[C" then '⌃→'
        when "\e\x1B[D" then '⌃←'
        else
          if key.first == 27 && key.size > 1
            rest = key[1..].map { |byte| format_byte(byte) }.join
            "⎋#{rest}"
          else
            key.map { |byte| format_byte(byte) }.join
          end
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

      # Convert arrow key letter to symbol.
      # @param letter [String] 'A', 'B', 'C', or 'D'
      # @return [String] arrow symbol
      def arrow_symbol(letter)
        { 'A' => '↑', 'B' => '↓', 'C' => '→', 'D' => '←' }[letter]
      end

      # Format a single byte into a readable representation.
      # @param byte [Integer] byte value (0-255)
      # @return [String] formatted byte representation
      def format_byte(byte)
        case byte
        when 27
          '⎋'
        when 0..31 # Control キー
          "⌃#{(byte + 64).chr}"
        when 32
          '␣'
        when 127
          '⌫'
        else
          byte.chr.match?(/[[:print:]]/) ? byte.chr : format('\\x%02X', byte)
        end
      end
    end
  end
end
