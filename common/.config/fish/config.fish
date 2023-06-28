set -gx LANG ja_JP.UTF-8
set -gx LESSCHARSET utf-8
set -gx JLESSCHARSET japanese-utf-8
set -gx MANPAGER "less -isr"
set -gx PAGER "lv -c"
set -gx EDITOR nvim

set -x PATH $PATH "$HOME/bin"
set -gx WORKSPACE "$HOME/workspace"

set -gx HISTSIZE 9999
set -gx PROMPT_COMMAND $PROMPT_COMMAND "update_terminal_cwd;history -a;history -c;history -r;"

# direnv
eval (direnv hook fish)

# asdf
source /usr/local/opt/asdf/libexec/asdf.fish

# node
set -x PATH $PATH "$HOME/Library/pnpm"

function fish_user_key_bindings
  # ghq の選択
  bind \cl peco_select_ghq_repository
  # gh-open
  bind \cx\cl peco_open_gh_repository
  # コマンド履歴
  bind \cr 'peco_select_history (commandline -b)'
  # プロセスキル
  bind \cx\ck peco_kill
  # 最近のディレクトリへ移動
  bind \cx\cr peco_recentd
end

# alias
balias ls 'ls -G'
balias l 'ls -l'
balias lf 'ls -f'
balias ld 'ls -d'
balias la 'ls -la'
balias ll 'ls -l'
balias so 'source'
balias sofish 'source ~/.config/fish/config.fish'
balias q 'quit'
balias c 'clear'
balias mkdir 'mkdir -p'
balias cp 'cp -v'
balias mv 'mv -v'
balias rm 'rm -v'
balias up 'cd ..'
balias f 'open .'
balias grep 'grep --color'

# vim / neovim
balias vim 'nvim'
balias v 'vim'
balias vi 'vim'
balias vfi 'vim ~/.config/fish/config.fish'
balias vnvim 'vim ~/.config/nvim/init.vim'
balias vs 'vim ~/.ssh/config'

balias git 'hub'
balias gs 'git status'

#fisherパッケージdecors/fish-ghqの設定
set GHQ_SELECTOR peco

# bobthefish
set -g theme_display_date no
