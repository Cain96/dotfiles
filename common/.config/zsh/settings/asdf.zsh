# Install a new tool version using asdf and fzf
ai() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | fzf --query "$LBUFFER")
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    asdf install $name $({ comm -23 <(asdf list all $name | sort --version-sort) <(asdf list $name | awk '{print $1}' | sort --version-sort); echo "latest"; } | fzf --query "$LBUFFER")
  fi
}

# Switch to a new tool version using asdf and fzf
au() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | fzf)
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    local current=$(asdf current $name | awk '{print $2}')
    asdf global $name $({asdf list $name | awk '{print $1}' | grep -v "^\*"; echo "latest"; } | fzf --query "$LBUFFER")
  fi
}
