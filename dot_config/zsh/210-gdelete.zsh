function gdelete() {
  local protected=(develop master main)

  echo "Fetching latest changes from remote..."
  if ! command git fetch --all --prune 2>&1; then
    echo "✗ Failed to fetch from remote" >&2
    return 1
  fi
  echo "✓ Successfully fetched latest changes"
  echo ""

  command git worktree prune

  local baseBranch=""
  local candidate
  for candidate in "${protected[@]}"; do
    if command git show-ref --verify --quiet "refs/heads/$candidate"; then
      baseBranch="$candidate"
      break
    fi
  done
  if [[ -z "$baseBranch" ]]; then
    echo "✗ Base branch (${protected[*]}) not found" >&2
    return 1
  fi

  local deleteBranches=()
  local branch worktreePath
  while IFS=$'\t' read -r branch worktreePath; do
    [[ -n "$branch" ]] || continue
    (( ${protected[(Ie)$branch]} )) && continue
    [[ -n "$worktreePath" ]] && continue
    deleteBranches+=("$branch")
  done < <(command git branch --merged "$baseBranch" --format='%(refname:short)%09%(worktreepath)')

  local remoteBase="$baseBranch"
  if command git show-ref --verify --quiet "refs/remotes/origin/$baseBranch"; then
    remoteBase="origin/$baseBranch"
  fi

  local deleteRemoteBranches=()
  local symref
  while IFS=$'\t' read -r branch symref; do
    [[ -n "$branch" ]] || continue
    [[ -n "$symref" ]] && continue
    (( ${protected[(Ie)${branch#origin/}]} )) && continue
    deleteRemoteBranches+=("$branch")
  done < <(command git branch -r --merged "$remoteBase" --format='%(refname:short)%09%(symref)')

  if [[ ${#deleteBranches[@]} -eq 0 && ${#deleteRemoteBranches[@]} -eq 0 ]]; then
    echo "No branches to delete"
    return 0
  fi

  if [[ ${#deleteBranches[@]} -gt 0 ]]; then
    echo "Local branches to delete: ${deleteBranches[@]}"
    if command git branch -d "${deleteBranches[@]}" 2>&1; then
      echo "✓ Successfully deleted local branches"
    else
      local exit_code=$?
      echo "✗ Failed to delete some local branches (exit code: $exit_code)" >&2
      echo "  Hint: Use 'git branch -D <branch>' to force delete unmerged branches" >&2
      return $exit_code
    fi
  fi

  if [[ ${#deleteRemoteBranches[@]} -gt 0 ]]; then
    echo "Remote tracking branches to delete: ${deleteRemoteBranches[@]}"
    local failed=0
    for branch in "${deleteRemoteBranches[@]}"; do
      if command git branch -rd "$branch" 2>&1; then
        echo "✓ Deleted: $branch"
      else
        echo "✗ Failed to delete: $branch" >&2
        failed=$((failed + 1))
      fi
    done

    if [[ $failed -gt 0 ]]; then
      echo "✗ Failed to delete $failed remote tracking branch(es)" >&2
      return 1
    else
      echo "✓ Successfully deleted all remote tracking branches"
    fi
  fi
}
