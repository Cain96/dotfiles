set -gx LANG ja_JP.UTF-8
set -gx LESSCHARSET utf-8
set -gx JLESSCHARSET japanese-utf-8
set -gx MANPAGER "less -isr"
set -gx PAGER "lv -c"
set -gx EDITOR nvim

set -x PATH $PATH "$HOME/bin"

# direnv
eval (direnv hook fish)

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
source (rbenv init -|psub)

# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"
status --is-interactive; and . (pyenv init - | psub)

# django
set -x DJANGO_READ_ENV_FILE True
balias runserver 'python manage.py runserver'
balias webpack './node_modules/.bin/webpack --config webpack.config.js'
balias circle_valid 'circleci config validate -c .circleci/config.yml'
balias circle_build 'circleci build circleci build .circleci/config.yml'

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
