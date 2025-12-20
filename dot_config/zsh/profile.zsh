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

# ツールチェック用ヘルパー関数
check_and_init() {
  local tool_name="$1"
  local init_command="$2"

  if command -v "$tool_name" &> /dev/null; then
    eval "$init_command"
  else
    echo "⚠️  ${tool_name}: not found" >&2
  fi
}

# brew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "⚠️  brew: not found" >&2
fi

# mise
check_and_init "mise" 'eval "$(mise activate zsh)"'

# aqua
check_and_init "aqua" 'export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua/bin:$PATH"; export AQUA_REMOVE_MODE=pl; export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:$HOME/.config/aquaproj-aqua/aqua.yaml; source <(aqua completion zsh)'

# direnv
check_and_init "direnv" 'eval "$(direnv hook zsh)"'

# chezmoi
check_and_init "chezmoi" 'source <(chezmoi completion zsh)'

# zoxide
check_and_init "zoxide" 'eval "$(zoxide init zsh)"'

# claude code
export CLAUDE_CONFIG_DIR=$HOME/.config/claude

# safe-chain
source $HOME/.safe-chain/scripts/init-posix.sh
