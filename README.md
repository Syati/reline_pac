# RelinePac

Reline extensions for completion, history search, and clipboard helpers with simple keybind configuration for IRB/pry.

English | [日本語](README_ja.md)

## Requirements
- `fzf` command (for history search with `\C-r`)
- macOS `pbcopy`/`pbpaste` commands (for clipboard operations)

## Installation

Install the gem globally (not in your project's Gemfile):

```bash
gem install reline_pac
```

Then add the following to your `~/.irbrc`. This works even in Bundler environments (like `rails console`):

```ruby
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
```

Alternatively, you can download it directly from GitHub:

```bash
curl -o ~/.irbrc https://raw.githubusercontent.com/Syati/reline_pac/main/examples/.irbrc
```

## Usage

Add the setup code from the Installation section to your `~/.irbrc` to enable default keybindings.

### Custom packages
You can add your own custom methods:

```ruby
RelinePac.configure do |config|
  config.add_package(:my_custom_method) do |_key|
    insert_text("Hello from custom package!")
  end
  config.add_keybind("\C-x", :my_custom_method)
end
```

### Default keybinds
- `\C-y` -> `:pbpaste` (uses macOS `pbpaste`)
- `\C-k` -> `:pbcopy_kill` (uses macOS `pbcopy`)
- `\C-r` -> `:fzf_history` (requires `fzf` in PATH)
- `\C-n` -> `:completion_next`
- `\C-p` -> `:completion_prev`

### Included packages
- Completion: when the completion dialog is open, `\C-n` / `\C-p` move candidates; otherwise they move history.
- Clipboard: `\C-y` inserts `pbpaste` output, `\C-k` sends the rest of the line to `pbcopy`.
- History: `\C-r` pipes history to `fzf`, deduplicates/strips blanks, and replaces the line with the selection.

All packages are installed when `RelinePac.configure` runs. Installers are idempotent, so repeated calls are safe.

## Development
```bash
bundle install
bundle exec rake spec
```
Use `bin/console` to experiment during development.

## License
MIT License. See `LICENSE.txt`.
