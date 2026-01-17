# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RelinePac::Config do
  describe '#add_package' do
    it 'adds a custom method to Reline::LineEditor' do
      config = described_class.new

      config.add_package(:test_method) do |_key|
        'test result'
      end

      # Verify the method was added
      line_editor = Reline::LineEditor.allocate
      expect(line_editor).to respond_to(:test_method)
    end

    it 'allows calling the custom method' do
      config = described_class.new

      config.add_package(:custom_insert) do |_key|
        insert_text('custom') if respond_to?(:insert_text)
      end

      line_editor_class = Class.new do
        prepend(Reline::LineEditor.ancestors.find { |m| m.method_defined?(:custom_insert, false) })

        def insert_text(text)
          @inserted = text
        end

        attr_reader :inserted
      end

      instance = line_editor_class.new
      instance.custom_insert(nil)
      expect(instance.inserted).to eq('custom')
    end

    it 'allows overriding methods with later definitions' do
      config = described_class.new

      # Add first package
      config.add_package(:shared_method) do |_key|
        'first'
      end

      # Add second package with same method name
      config.add_package(:shared_method) do |_key|
        'second'
      end

      # The second one should take precedence (prepend behavior)
      line_editor = Reline::LineEditor.allocate
      expect(line_editor.shared_method(nil)).to eq('second')
    end

    it 'does nothing when no block is given' do
      config = described_class.new
      initial_ancestors = Reline::LineEditor.ancestors.dup

      config.add_package(:no_block_method)

      # Should not add anything
      expect(Reline::LineEditor.ancestors.size).to eq(initial_ancestors.size)
    end
  end
end
