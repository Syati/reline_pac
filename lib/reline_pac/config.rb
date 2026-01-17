# frozen_string_literal: true

module RelinePac
  # Config manages Reline keybindings and package installation.
  class Config
    def initialize
      Packages.install_all
    end

    # Add a custom package (method) to Reline::LineEditor.
    # @param method_name [Symbol] the method name to add
    # @yield a block that defines the method body; receives _key as first argument
    def add_package(method_name, &block)
      return unless block_given?

      Packages::Custom.module_eval do
        define_method(method_name, &block)
      end

      Reline::LineEditor.prepend(Packages::Custom) unless Reline::LineEditor.ancestors.include?(Packages::Custom)
    end

    # Add a keybinding that invokes the given LineEditor method symbol.
    # @param key [String] a string such as "\C-r"
    # @param method [Symbol] the LineEditor method to invoke
    def add_keybind(key, method)
      key_bytes = key.bytes
      reline_config.add_default_key_binding(key_bytes, method)
    end

    private

    def reline_config
      @reline_config ||= Reline.core.config
    end
  end
end
