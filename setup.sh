#!/bin/bash

DOT_FILES=(mac/.bashrc mac/.bash_profile  common/git/.gitignore_global common/git/.gitconfig)

currentdir=$(cd $(dirname $0); pwd)
for file in ${DOT_FILES[@]}; do
    # ファイル名の取得
    if [[ $file =~ (.*\/)*(.*) ]]; then
        filename=${BASH_REMATCH[2]}
        ln -sf $currentdir/$file $HOME/$filename
    fi
done

XONSH_BASEDIR=$currentdir/common/.config/xonsh/
ln -sf $XONSH_BASEDIR $HOME/.config/xonsh
