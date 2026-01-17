# RelinePac

IRB や pry 向けに、補完・履歴検索・クリップボードを拡張し、キー割り当てを簡単にする小さな Reline 用 gem です。

[English](README.md) | 日本語

## インストール
- RubyGems 公開後: Gemfile に `gem "reline_pac"` を追加します。
- リポジトリから開発インストール: `bundle exec rake install`。

## 使い方
IRB や pry の起動時（例: `~/.irbrc`）に `RelinePac.configure` を呼び出し、`Reline::LineEditor` のメソッドへキーを割り当てます。

```ruby
# ~/.irbrc
begin
  require "reline_pac"
  RelinePac.configure do |config|
    # デフォルトを適用
    RelinePac::Packages::DEFAULT_KEYBINDS.each do |key, method|
      config.add_keybind(key, method)
    end
    
    # 上書きや独自の割り当ても可能
    # config.add_keybind("\C-r", :fzf_history)
  end 
rescue LoadError
  # do nothing
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
