function gco() {
  local branches branch
  branches=$(git branch --all --format="%(refname:short)" --sort=-committerdate)  # すべてのブランチを取得します
  branch=$(echo "$branches" | peco --prompt='Branch>' | sed 's#^origin/##')  # pecoで検索して結果を取得します

  if [[ -n "$branch" ]]; then  # ブランチが選択された場合
    echo "git checkout $branch"
    git checkout "$branch"  # ブランチをcheckoutします
  fi
}
