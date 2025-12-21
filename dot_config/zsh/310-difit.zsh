# difit - Git diff viewer with subcommands
# https://github.com/yoshiko-pg/difit

function difit() {
  local subcommand="$1"

  case "$subcommand" in
    commits)
      # Interactive commit selection with fzf
      shift
      local from_commit to_commit from_hash to_hash

      from_commit=$(git log --oneline --decorate -100 --color=always | \
        fzf \
          --ansi \
          --header "> difit \$TO \$FROM~1" \
          --prompt "Select \$FROM>" \
          --preview 'git log --oneline --decorate --color=always -1 {1}' \
          --preview-window=top:3:wrap
      ) || return
      from_hash="${from_commit%% *}"

      to_commit=$(git log --oneline --decorate -100 --color=always $from_hash~1.. | \
        fzf \
          --ansi \
          --header "> difit \$TO $from_hash~1" \
          --prompt "Select \$TO>" \
          --preview 'git log --oneline --decorate --color=always -1 {1}' \
          --preview-window=top:3:wrap
      ) || return
      to_hash="${to_commit%% *}"

      bunx --bun difit "$to_hash" "$from_hash~1"
      ;;

    local)
      # Show all uncommitted changes
      shift
      bunx --bun difit . "$@"
      ;;

    staged)
      # Show only staged changes
      shift
      bunx --bun difit staged "$@"
      ;;

    pr)
      # Interactive PR selection with gh + fzf
      shift
      local pr_info pr_url

      pr_info=$(gh pr list --search "is:open sort:created-desc" --limit 100 \
        --json number,title,url,headRefName \
        --jq '.[] | "#\(.number) \(.title) (\(.headRefName)) - \(.url)"' | \
        fzf --ansi \
          --prompt "Select PR> " \
          --preview 'gh pr view $(echo {} | cut -d" " -f1) --json title,author,labels,url,body | jq -r "\"Title:  \(.title)\nAuthor: \(.author.login)\nLabels: \((.labels // []) | map(.name) | join(\", \"))\nURL:    \(.url)\n\n\(.body // \"(no description)\")\""' \
          --preview-window=right:60%:wrap
      ) || return

      pr_url=$(echo "$pr_info" | awk -F' - ' '{print $NF}')
      bunx --bun difit --pr "$pr_url" "$@"
      ;;

    *)
      # Pass all arguments to difit (default behavior)
      bunx --bun difit "$@"
      ;;
  esac
}
