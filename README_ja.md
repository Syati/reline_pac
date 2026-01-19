# RelinePac

IRB や pry 向けに、補完・履歴検索・クリップボードを拡張し、キー割り当てを簡単にする小さな Reline 用 gem です。

[English](README.md) | 日本語

## 必要な環境
- `fzf` コマンド（`\C-r` による履歴検索に必要）
- macOS の `pbcopy`/`pbpaste` コマンド（クリップボード操作に必要）

## インストール

gem をグローバルにインストールします（プロジェクトの Gemfile には追加しません）:

```bash
gem install reline_pac
```

次に `~/.irbrc` に以下を追加します。Bundler 環境（`rails console` など）でも動作します:

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

または、GitHub から直接ダウンロードすることもできます:

```bash
curl -o ~/.irbrc https://raw.githubusercontent.com/Syati/reline_pac/main/examples/.irbrc
```

## 使い方

インストールセクションの設定例を `~/.irbrc` に追加すれば、デフォルトのキーバインドが利用できます。

### カスタムパッケージ
独自のメソッドを追加できます:

```ruby
RelinePac.configure do |config|
  config.add_package(:my_custom_method) do |_key|
    insert_text("Hello from custom package!")
  end
  config.add_keybind("\C-x", :my_custom_method)
end
```

### デフォルトのキー割り当て
- `\C-y` -> `:pbpaste`（macOS の `pbpaste` を使用）
- `\C-k` -> `:pbcopy_kill`（macOS の `pbcopy` を使用）
- `\C-r` -> `:fzf_history`（PATH に `fzf` が必要）
- `\C-n` -> `:completion_next`
- `\C-p` -> `:completion_prev`

### 含まれるパッケージ
- Completion: 補完ダイアログ表示中は `\C-n` / `\C-p` で候補移動、非表示時は履歴移動。
- Clipboard: `\C-y` で `pbpaste` の内容を挿入、`\C-k` でカーソル以降を `pbcopy` へ送信。
- History: `\C-r` で履歴を `fzf` に流し込み、重複や空行を除去して選択し、選択結果で行を置き換え。

`RelinePac.configure` 実行時に全パッケージを自動インストールします。各インストールは冪等なので、繰り返し呼んでも安全です。

## 開発
```bash
bundle install
bundle exec rake spec
```
開発時の確認には `bin/console` を利用できます。

## ライセンス
MIT ライセンスです。`LICENSE.txt` を参照してください。
