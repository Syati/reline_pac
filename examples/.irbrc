# Check if running in a Bundler environment (e.g., rails c)
if defined?(Bundler)
  # Temporarily unbundle to get the system gem path
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
    # Apply default keybindings
    RelinePac::Packages::DEFAULT_KEYBINDS.each do |key, method|
      config.add_keybind(key, method)
    end
  end
  # You can override or add custom keybindings
  # config.add_keybind("\C-r", :fzf_history)
rescue LoadError
  # do nothing
end
