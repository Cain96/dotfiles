#!/bin/zsh
# zshキャッシュファイル更新スクリプト
# 各ツールの初期化コマンドの出力をキャッシュファイルに保存する

set -euo pipefail

CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$CACHE_DIR"

# brew shellenv
if [ -x $HOMEBREW_PREFIX/bin/brew ]; then
  $HOMEBREW_PREFIX/bin/brew shellenv > "$CACHE_DIR/brew-shellenv.sh" 2>/dev/null || true
elif command -v brew &> /dev/null; then
  brew shellenv > "$CACHE_DIR/brew-shellenv.sh" 2>/dev/null || true
fi

# mise activate
if command -v mise &> /dev/null; then
  mise activate zsh > "$CACHE_DIR/mise-activate.sh" 2>/dev/null || true
fi

# aqua completion
if command -v aqua &> /dev/null; then
  aqua completion zsh > "$CACHE_DIR/aqua-completion.sh" 2>/dev/null || true
fi

# direnv hook
if command -v direnv &> /dev/null; then
  direnv hook zsh > "$CACHE_DIR/direnv-hook.sh" 2>/dev/null || true
fi

# chezmoi completion
if command -v chezmoi &> /dev/null; then
  chezmoi completion zsh > "$CACHE_DIR/chezmoi-completion.sh" 2>/dev/null || true
fi

# zoxide init
if command -v zoxide &> /dev/null; then
  zoxide init zsh --cmd cd > "$CACHE_DIR/zoxide-init.sh" 2>/dev/null || true
fi
