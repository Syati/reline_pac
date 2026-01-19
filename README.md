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

Then set up your `~/.irbrc`:

```bash
# Download the example configuration
curl -o ~/.irbrc https://raw.githubusercontent.com/Syati/reline_pac/main/examples/.irbrc
```

Or see [examples/.irbrc](examples/.irbrc) for the full configuration code that you can copy and customize.

## Usage

The example configuration in [examples/.irbrc](examples/.irbrc) provides three options:

1. **Use default keybindings** (recommended): Just use the configuration as-is
2. **Customize keybindings**: Modify individual key bindings to your preference
3. **Add custom packages**: Define your own methods and bind them to keys

See [examples/.irbrc](examples/.irbrc) for detailed comments and examples.

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
