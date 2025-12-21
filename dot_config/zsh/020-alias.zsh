## alias設定
# 関数内でもエイリアスを有効にする
setopt aliases

# core
alias so='source'
alias q='quit'
alias c='clear'
alias mkdir='mkdir -p'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias up='cd ..'
alias f='open .'

# eza (Alternative ls)
_ls() { eza --icons --git "$@" }
alias ls='_ls'
alias l='_ls -l'
alias ll='_ls -l'
alias lf='_ls -f'
alias ld='_ls -d'
alias la='_ls -aahl'
alias lt='_ls -T -L 3 -a -I "node_modules|.git|.cache"'

# bat (Alternative cat)
alias cat='bat'

# fd (Alternative find)
alias find='fd'

# ripgrep (Alternative grep)
alias grep='rg --color=always'

# vim / neovim
alias vim='nvim'
alias v='vim'
alias vi='vim'

# git
alias git='hub'
alias gs='git status'
alias gl='git log --graph'

# original
alias g='search-ghq-projects'
alias search='search-ghq-projects'
alias rebrew='brew update && brew upgrade && brew cleanup'
