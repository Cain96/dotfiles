#!/bin/sh

# python
python_latest=$(pyenv install --list | grep -v - | grep -v b | tail -1) # python3 最新安定版
pyenv install $python_latest
pyenv rehash
pyenv global $python_latest
echo "python global version"
python --version

# ruby
ruby_latest=$(rbenv install -l | grep -v - | tail -1) # ruby 最新安定版
rbenv install $ruby_latest
rbenv rehash
rbenv global $ruby_latest
echo "ruby global version"
ruby -v
