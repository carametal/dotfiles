#!/bin/zsh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> dotfiles のインストールを開始します..."

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Homebrew をインストールしています..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "==> Homebrew はすでにインストール済みです。スキップします。"
fi

# Brewfile
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
  echo "==> Brewfile からパッケージをインストールしています..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "==> Brewfile が見つかりません。スキップします。"
fi

# Symlinks
# dotfiles ディレクトリ内の .(ドット)ファイルを $HOME へシンボリックリンクする
echo "==> シンボリックリンクを作成しています..."
for src in "$DOTFILES_DIR"/.*; do
  filename="$(basename "$src")"

  # . / .. / .git は除外
  [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" ]] && continue

  dest="$HOME/$filename"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "  [スキップ] $dest はすでに存在します（シンボリックリンクではありません）。手動で移動してください。"
    continue
  fi

  ln -sfn "$src" "$dest"
  echo "  [リンク] $dest -> $src"
done

# .claude 内の設定ファイルをシンボリックリンク
echo "==> .claude の設定ファイルをリンクしています..."
mkdir -p "$HOME/.claude"
for src in "$DOTFILES_DIR/claude/"*; do
  filename="$(basename "$src")"
  dest="$HOME/.claude/$filename"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "  [スキップ] $dest はすでに存在します（シンボリックリンクではありません）。手動で移動してください。"
    continue
  fi

  ln -sfn "$src" "$dest"
  echo "  [リンク] $dest -> $src"
done

# ghostty 設定ファイルをシンボリックリンク
echo "==> ghostty の設定ファイルをリンクしています..."
mkdir -p "$HOME/.config/ghostty"
src="$DOTFILES_DIR/ghostty/config"
dest="$HOME/.config/ghostty/config"

if [[ -e "$dest" && ! -L "$dest" ]]; then
  echo "  [スキップ] $dest はすでに存在します（シンボリックリンクではありません）。手動で移動してください。"
else
  ln -sfn "$src" "$dest"
  echo "  [リンク] $dest -> $src"
fi

# zed 設定ファイルをシンボリックリンク
echo "==> zed の設定ファイルをリンクしています..."
mkdir -p "$HOME/.config/zed"
for src in "$DOTFILES_DIR/zed/"*; do
  filename="$(basename "$src")"
  dest="$HOME/.config/zed/$filename"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "  [スキップ] $dest はすでに存在します（シンボリックリンクではありません）。手動で移動してください。"
    continue
  fi

  ln -sfn "$src" "$dest"
  echo "  [リンク] $dest -> $src"
done

# aerospace 設定ファイルをシンボリックリンク
echo "==> aerospace の設定ファイルをリンクしています..."
mkdir -p "$HOME/.config/aerospace"
src="$DOTFILES_DIR/aerospace/aerospace.toml"
dest="$HOME/.config/aerospace/aerospace.toml"

if [[ -e "$dest" && ! -L "$dest" ]]; then
  echo "  [スキップ] $dest はすでに存在します（シンボリックリンクではありません）。手動で移動してください。"
else
  ln -sfn "$src" "$dest"
  echo "  [リンク] $dest -> $src"
fi

echo "==> インストールが完了しました。"
