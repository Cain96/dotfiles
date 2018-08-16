source ~/.bashrc

export DJANGO_READ_ENV_FILE=True

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home/"
export PATH=$JAVA_HOME/bin:$PATH

#cuda
export PATH=/Developer/NVIDIA/CUDA-9.2/bin:$PATH
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-9.2/lib:$DYLD_LIBRARY_PATH

export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$GOPATH/bin

export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
if
     which rbenv > /dev/null; then eval "$(rbenv init -)";
fi

export PGDATA=/usr/local/var/postgres

[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh
