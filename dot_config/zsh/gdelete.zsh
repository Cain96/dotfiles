function gdelete() {
  local deleteBranches=($(git branch --merged | grep -vE '^\*|develop$|master$|main$'))
  local deleteRemoteBranches=($(git branch -r --merged | grep -vE '^\*|develop$|master$|main$'))

  if if [[ ${#deleteBranches[@]} -eq 0 && ${#deleteRemoteBranches[@]} -eq 0 ]]; then
    echo "No branches to delete"
    return 0
  fi

  if [ ${#deleteBranches[@]} -gt 0 ]; then
    echo "Local branches to delete: $deleteBranches"
    git branch -d "${deleteBranches[@]}"
  fi

  if [ ${#deleteRemoteBranches[@]} -gt 0 ]; then
    echo "Remote branches to delete: $deleteRemoteBranches"
    git branch -r -d "${deleteRemoteBranches[@]}"
  fi
}
