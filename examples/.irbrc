# RelinePac configuration for IRB/Pry
# This works even in Bundler environments (e.g., rails console)

if defined?(Bundler)
  # Access system gem when running under Bundler
  reline_pac_gem_path = Bundler.with_unbundled_env do
    `gem which reline_pac 2> /dev/null`.chomp
  end

  unless reline_pac_gem_path.empty?
    lib_dir = File.dirname(reline_pac_gem_path)
    $LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
  end
end

begin
  require 'reline_pac'

  RelinePac.configure do |config|
    # ============================================
    # Option 1: Use default keybindings (recommended for beginners)
    # ============================================
    # Default bindings:
    #   \C-y => pbpaste          (paste from clipboard)
    #   \C-k => pbcopy_kill      (copy rest of line to clipboard)
    #   \C-r => fzf_history      (search history with fzf)
    #   \C-n => completion_next  (next completion item)
    #   \C-p => completion_prev  (previous completion item)
    RelinePac::Packages::DEFAULT_KEYBINDS.each do |key, method|
      config.add_keybind(key, method)
    end

    # ============================================
    # Option 2: Customize keybindings
    # ============================================
    # If you want to customize, comment out lines 29-31 above, then uncomment and modify below:
    #
    # config.add_keybind("\C-y", :pbpaste)
    # config.add_keybind("\C-k", :pbcopy_kill)
    # config.add_keybind("\C-r", :fzf_history)
    # config.add_keybind("\C-n", :completion_next)
    # config.add_keybind("\C-p", :completion_prev)

    # ============================================
    # Option 3: Add your own custom package
    # ============================================
    # config.add_package(:insert_hello) do |_key|
    #   insert_text("Hello, World!")
    # end
    # config.add_keybind("\C-x\C-h", :insert_hello)
  end
rescue LoadError
  # Silently ignore if reline_pac is not installed
end
