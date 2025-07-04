ZSHHOME="${HOME}/.config/zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then

    # Source the .profile.zsh file first
    profile_zsh="$ZSHHOME/profile.zsh"
    if [ -f "$profile_zsh" -o -h "$profile_zsh" ] && [ -r "$profile_zsh" ]; then
        . "$profile_zsh"
    fi

    # Source the remaining zsh files
    for i in $ZSHHOME/*; do
        if [ "$i" != "$profile_zsh" ]; then
          [[ ${i##*/} = *.zsh ]] && [ \( -f $i -o -h $i \) -a -r $i ]  && . $i
        fi
    done
fi
# aqua
export AQUA_REMOVE_MODE=pl
