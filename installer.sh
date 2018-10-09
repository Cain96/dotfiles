#!/bin/sh

# homebrew
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor

# brew cask
brew install caskroom/cask/brew-cask

# terminal
brew cask install iterm2

# tool
#brew cask install dropbox
#brew cask install google-chrome
#brew cask install evernote
#brew cask install slack
#brew cask install skype

# programming
brew install vim --with-override-system-vi
brew cask install atom
brew install git
brew cask install docker # docker for mac
## python
brew install pyenv-virtualenv
## ruby
brew install rbenv ruby-build rbenv-communal-gems
## java
brew cask install java

# database
## mysql
brew install mysql@5.7
brew services start mysql@5.7
## postgresql
brew install postgresql
brew services start postgresql

# set up symbolic link
./setup.sh

# set up programming
common/programming.sh

# upgrade pip
pip install --upgrade setuptools
pip install --upgrade pip

# shell
pip install xonsh
pip install gnureadline
pip install prompt-toolkit
brew install bash-completion2
brew install peco
brew install ghq

## xonsh
pip install numpy
pip install requests
pip install xonsh-docker-tabcomplete
pip install xontrib-readable-traceback
