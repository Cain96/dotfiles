## 環境変数
export LANG=ja_JP.UTF-8
export KCODE=u # KCODEにUTF-8を設定
export EDITOR=nvim

## 色を使用出来るようにする
autoload -Uz colors
colors

## ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history           # 履歴を他のシェルとリアルタイム共有する

setopt hist_ignore_all_dups    # 同じコマンドをhistoryに残さない
setopt hist_ignore_space       # historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks      # historyに保存するときに余分なスペースを削除する
setopt hist_save_no_dups       # 重複するコマンドが保存されるとき、古い方を削除する
setopt inc_append_history      # 実行時に履歴をファイルに追加していく

# 補完の設定
autoload -Uz compinit && compinit

## キャッシュディレクトリ
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# brew
if [ -f "$ZSH_CACHE_DIR/brew-shellenv.sh" ]; then
  source "$ZSH_CACHE_DIR/brew-shellenv.sh"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "⚠️  brew: not found" >&2
fi

# mise
if [ -f "$ZSH_CACHE_DIR/mise-activate.sh" ]; then
  source "$ZSH_CACHE_DIR/mise-activate.sh"
elif command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
else
  echo "⚠️  mise: not found" >&2
fi

# aqua
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua/bin:$PATH"
export AQUA_REMOVE_MODE=pl
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:$HOME/.config/aquaproj-aqua/aqua.yaml
if [ -f "$ZSH_CACHE_DIR/aqua-completion.sh" ]; then
  source "$ZSH_CACHE_DIR/aqua-completion.sh"
elif command -v aqua &> /dev/null; then
  source <(aqua completion zsh)
fi

# direnv
if [ -f "$ZSH_CACHE_DIR/direnv-hook.sh" ]; then
  source "$ZSH_CACHE_DIR/direnv-hook.sh"
elif command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# chezmoi
if [ -f "$ZSH_CACHE_DIR/chezmoi-completion.sh" ]; then
  source "$ZSH_CACHE_DIR/chezmoi-completion.sh"
elif command -v chezmoi &> /dev/null; then
  source <(chezmoi completion zsh)
fi

# zoxide
if [ -f "$ZSH_CACHE_DIR/zoxide-init.sh" ]; then
  source "$ZSH_CACHE_DIR/zoxide-init.sh"
elif command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# claude code
export CLAUDE_CONFIG_DIR=$HOME/.config/claude

# safe-chain
source $HOME/.safe-chain/scripts/init-posix.sh

# キャッシュファイルを非同期で更新（バックグラウンド実行）
if [ -x $HOME/.local/bin/update-zsh-cache.sh ]; then
  ($HOME/.local/bin/update-zsh-cache.sh > /dev/null 2>&1 &)
fi
