# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RelinePac::Introspection do
  describe '.keymap' do
    it 'returns a hash without errors' do
      expect { described_class.keymap }.not_to raise_error
    end

    it 'returns a hash of keybindings' do
      result = described_class.keymap
      expect(result).to be_a(Hash)
    end

    it 'filters out ed_insert and ed_digit bindings' do
      result = described_class.keymap
      expect(result.values).not_to include(:ed_insert)
      expect(result.values).not_to include(:ed_digit)
    end

    it 'includes known keybindings' do
      result = described_class.keymap
      # Control-A should map to ed_move_to_beg
      expect(result).to include('⌃A' => :ed_move_to_beg)
    end

    it 'removes duplicate keys' do
      result = described_class.keymap
      # All keys should be unique
      expect(result.keys.uniq.length).to eq(result.keys.length)
    end

    it 'formats special keys correctly' do
      result = described_class.keymap
      # Should have Control and Escape keys formatted with symbols
      expect(result.keys.grep(/⌃/).any?).to be true
      expect(result.keys.grep(/⎋/).any?).to be true
    end
  end
end
