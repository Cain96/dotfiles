function search-ghq-projects() {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    cd $selected_dir
  fi
}
