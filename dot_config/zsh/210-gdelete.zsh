function gdelete() {
  # 最新の状態を取得
  echo "Fetching latest changes from remote..."
  if ! git fetch --all --prune 2>&1; then
    echo "✗ Failed to fetch from remote" >&2
    return 1
  fi
  echo "✓ Successfully fetched latest changes"
  echo ""

  # ローカルのマージ済みブランチを取得（先頭の空白/アスタリスクを削除し、保護ブランチを除外）
  local deleteBranches=()
  while IFS= read -r branch; do
    [[ -n "$branch" ]] && deleteBranches+=("$branch")
  done < <(git branch --merged | sed 's/^[* ]*//' | grep -v '^(develop|master|main)$')

  # リモートのマージ済みブランチを取得（先頭の空白を削除し、保護ブランチを除外）
  local deleteRemoteBranches=()
  while IFS= read -r branch; do
    [[ -n "$branch" ]] && deleteRemoteBranches+=("$branch")
  done < <(git branch -r --merged | sed 's/^  //' | grep -v 'origin/(develop|master|main)$')

  # 削除対象がない場合
  if [[ ${#deleteBranches[@]} -eq 0 && ${#deleteRemoteBranches[@]} -eq 0 ]]; then
    echo "No branches to delete"
    return 0
  fi

  # ローカルブランチの削除
  if [[ ${#deleteBranches[@]} -gt 0 ]]; then
    echo "Local branches to delete: ${deleteBranches[@]}"
    if git branch -d "${deleteBranches[@]}" 2>&1; then
      echo "✓ Successfully deleted local branches"
    else
      local exit_code=$?
      echo "✗ Failed to delete some local branches (exit code: $exit_code)" >&2
      echo "  Hint: Use 'git branch -D <branch>' to force delete unmerged branches" >&2
      return $exit_code
    fi
  fi

  # リモート追跡ブランチの削除
  if [[ ${#deleteRemoteBranches[@]} -gt 0 ]]; then
    echo "Remote tracking branches to delete: ${deleteRemoteBranches[@]}"
    local failed=0
    for branch in "${deleteRemoteBranches[@]}"; do
      if git branch -rd "$branch" 2>&1; then
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
