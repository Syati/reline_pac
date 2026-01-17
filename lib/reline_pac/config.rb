# frozen_string_literal: true

module RelinePac
  # Config manages Reline keybindings and package installation.
  class Config
    def initialize
      Packages.install_all
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
      @reline_config ||= Reline.send(:core).config
    end
  end
end
