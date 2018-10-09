source ~/.bashrc

# java
export JAVA_HOME=`/usr/libexec/java_home -v "11"`
export PATH=$JAVA_HOME/bin:$PATH

# python
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if
     which rbenv > /dev/null; then eval "$(rbenv init -)";
fi

# xonsh
alias x='xonsh'
x
