function chpwd() {
	if [[ $(pwd) != $HOME ]]; then;
		ls
	fi
}

autoload chpwd
