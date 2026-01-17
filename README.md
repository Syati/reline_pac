# RelinePac


Reline extensions for completion, history search, and clipboard helpers with simple keybind configuration for IRB/pry.

English | [日本語](README_ja.md)

## Requirements
- `fzf` command (for history search with `\C-r`)
- macOS `pbcopy`/`pbpaste` commands (for clipboard operations)

## Installation
- After publishing to RubyGems: add `gem "reline_pac"` to your Gemfile.
- From this repository while developing: `bundle exec rake install`.

## Usage
Call `RelinePac.configure` during IRB/pry startup (e.g., `~/.irbrc`) and bind keys to `Reline::LineEditor` methods.

```ruby
# ~/.irbrc
begin
  require "reline_pac"
  RelinePac.configure do |config|
    RelinePac::Packages::DEFAULT_KEYBINDS.each do |key, method|
      config.add_keybind(key, method)
    end
    
    # override or add your own bindings
    # config.add_keybind("\C-r", :fzf_history)
  end
rescue LoadError
  # do nothing
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
