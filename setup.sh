#!/bin/bash

# git
GIT_BASEDIR=$currentdir/common/git/
ln -sf $GIT_BASEDIR/.gitconfig $HOME/.gitconfig
ln -sf $GIT_BASEDIR/.gitignore_global $HOME/.gitignore_global

# zsh
ZSH_BASEDIR=$currentdir/common/.config/zsh/
ln -sf $ZSH_BASEDIR/.zshrc $HOME/.zshrc
ln -sf $ZSH_BASEDIR/settings/ $HOME/.config/zsh

# nvim
VIM_BASEDIR=$currentdir/common/.config/nvim/
ln -sf $VIM_BASEDIR $HOME/.config/nvim
