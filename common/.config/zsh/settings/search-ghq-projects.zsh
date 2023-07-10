function search-ghq-projects() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    cd $selected_dir
  fi
}
