
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
source ~/.bashrc

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if
     which rbenv > /dev/null; then eval "$(rbenv init -)";
fi

fish
# fish
export PATH=$PATH:/Users/cain/bin/slack-theme
export SLACK_THEME_SHELL_PROFILE="/Users/cain/.bash_profile"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
