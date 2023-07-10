# Install a new tool version using asdf and peco
ai() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | peco --query "$LBUFFER")
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    asdf install $name $({ comm -23 <(asdf list all $name | sort --version-sort) <(asdf list $name | awk '{print $1}' | sort --version-sort); echo "latest"; } | peco --query "$LBUFFER")
  fi
}

# Switch to a new tool version using asdf and peco
au() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | peco)
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    local current=$(asdf current $name | awk '{print $2}')
    asdf global $name $({asdf list $name | awk '{print $1}' | grep -v "^\*"; echo "latest"; } | peco --query "$LBUFFER")
  fi
}
