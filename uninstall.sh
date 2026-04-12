#!/bin/zsh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> dotfiles のアンインストールを開始します..."

# Symlinks
echo "==> シンボリックリンクを削除しています..."
for src in "$DOTFILES_DIR"/.*; do
  filename="$(basename "$src")"

  # . / .. / .git は除外
  [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" ]] && continue

  dest="$HOME/$filename"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    rm "$dest"
    echo "  [削除] $dest"
  else
    echo "  [スキップ] $dest はこの dotfiles へのシンボリックリンクではありません。"
  fi
done

# Brewfile のパッケージを削除
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
  echo "==> Brewfile のパッケージを削除しています..."
  brew bundle list --file="$DOTFILES_DIR/Brewfile" | xargs brew uninstall --ignore-dependencies 2>/dev/null || true
else
  echo "==> Brewfile が見つかりません。パッケージの削除をスキップします。"
fi

# .claude 内のシンボリックリンクを削除
echo "==> .claude のシンボリックリンクを削除しています..."
for src in "$DOTFILES_DIR/claude/"*; do
  filename="$(basename "$src")"
  dest="$HOME/.claude/$filename"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    rm "$dest"
    echo "  [削除] $dest"
  else
    echo "  [スキップ] $dest はこの dotfiles へのシンボリックリンクではありません。"
  fi
done

# borders のシンボリックリンクを削除
echo "==> borders のシンボリックリンクを削除しています..."
src="$DOTFILES_DIR/borders/bordersrc"
dest="$HOME/.config/borders/bordersrc"

if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
  rm "$dest"
  echo "  [削除] $dest"
else
  echo "  [スキップ] $dest はこの dotfiles へのシンボリックリンクではありません。"
fi

# aerospace のシンボリックリンクを削除
echo "==> aerospace のシンボリックリンクを削除しています..."
src="$DOTFILES_DIR/aerospace/aerospace.toml"
dest="$HOME/.config/aerospace/aerospace.toml"

if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
  rm "$dest"
  echo "  [削除] $dest"
else
  echo "  [スキップ] $dest はこの dotfiles へのシンボリックリンクではありません。"
fi

echo "==> アンインストールが完了しました。"
