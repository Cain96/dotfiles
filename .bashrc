function cdls(){
 \cd $1
 ls;
}
alias cd=cdls

#
# git-completion.bash / git-prompt.sh
#
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '

alias runserver='python manage.py runserver'
alias webpack='./node_modules/.bin/webpack --config webpack.config.js'

alias circlebuild='circleci build github.com/cain96/sns_kanri'
alias gowork='cd $GOPATH/src/github.com/cain96'

if [ -x "`which go`" ]; then
    export GOPATH=$HOME/workspace/go
    export PATH=$PATH:$GOPATH/bin
fi

alias ktlintF='ktlint -F "src/main/**/*.kt"'

alias lsusb='system_profiler SPUSBDataType'
