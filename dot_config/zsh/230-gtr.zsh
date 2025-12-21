# gtr - Git worktree runner with fzf integration
# git gtrコマンドのfzf統合ラッパー関数

function gtr() {
  local subcommand="$1"
  local branch="$2"

  # git gtrが利用可能かチェック
  if ! command -v git-gtr >/dev/null 2>&1 && ! git gtr --help >/dev/null 2>&1; then
    echo "Error: git gtr is not installed or not available" >&2
    return 1
  fi

  case "$subcommand" in
    editor|ai|cd|rm)
      # ブランチ名が指定されていない場合、fzfで選択
      if [[ -z "$branch" ]]; then
        local worktrees selected_line

        # git worktree listからworktreeリストを取得
        worktrees=$(command git worktree list 2>/dev/null) || {
          echo "Error: Failed to get worktree list" >&2
          return 1
        }

        # git worktree listの出力をそのままfzfで選択
        selected_line=$(echo "$worktrees" | \
          fzf --prompt="Select worktree> " --height=40% --layout=reverse --border) || return

        if [[ -z "$selected_line" ]]; then
          return 0
        fi

        # 選択された行からブランチ名を抽出
        # git worktree listの形式: "/path/to/worktree  abc123 [branch-name]"
        # ブランチ名は[で囲まれているか、detachedの場合はハッシュのみ
        branch=$(echo "$selected_line" | \
          awk '{
            for (i=1; i<=NF; i++) {
              field = $i
              # [branch-name]の形式からブランチ名を抽出
              if (field ~ /^\[.*\]$/) {
                gsub(/^\[|\]$/, "", field)
                print field
                exit
              }
            }
            # [branch-name]が見つからない場合、detached HEADの可能性がある
            # その場合は最初の非パス、非ハッシュフィールドを探す
            for (i=1; i<=NF; i++) {
              field = $i
              if (field !~ /^\// && field !~ /^\./ && field !~ /^[0-9a-f]{40}$/ && field !~ /^\[/) {
                print field
                break
              }
            }
          }' | head -1)

        if [[ -z "$branch" ]]; then
          echo "Error: Failed to extract branch name from selected line" >&2
          return 1
        fi
      fi

      # 適切なgit gtrコマンドを実行
      case "$subcommand" in
        editor)
          command git gtr editor "$branch" "${@:3}"
          ;;
        ai)
          command git gtr ai "$branch" "${@:3}"
          ;;
        cd)
          local worktree_path
          worktree_path=$(command git gtr go "$branch" 2>/dev/null) || {
            echo "Error: Failed to get worktree path for branch: $branch" >&2
            return 1
          }
          if [[ -n "$worktree_path" ]]; then
            cd "$worktree_path"
          else
            echo "Error: Worktree path is empty for branch: $branch" >&2
            return 1
          fi
          ;;
        rm)
          command git gtr rm "$branch" "${@:3}"
          ;;
      esac
      ;;
    *)
      # その他のサブコマンドはgit gtrにフォールバック
      command git gtr "$@"
      ;;
  esac
}
