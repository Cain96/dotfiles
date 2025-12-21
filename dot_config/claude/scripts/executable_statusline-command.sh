#!/usr/bin/env bash
set -euo pipefail

# Read stdin input from Claude Code
input=$(cat)

# Get model name
model_name=$(echo "$input" | jq -r '.model.display_name')

# Get current directory
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Get context window information
usage=$(echo "$input" | jq '.context_window.current_usage')
context_pct=""
if [ "$usage" != "null" ]; then
    current_tokens=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    total_size=$(echo "$input" | jq '.context_window.context_window_size')
    pct=$((current_tokens * 100 / total_size))

    # Select emoji based on context usage percentage
    if [ "$pct" -le 60 ]; then
        emoji="🟢"
    elif [ "$pct" -le 80 ]; then
        emoji="🟡"
    else
        emoji="🔴"
    fi

    context_pct=$(printf '%s %d%%' "$emoji" "$pct")
fi

# Get Git branch information (disable core.filemode to avoid lock issues)
git_branch=""
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -C "$current_dir" -c core.filemode=false branch --show-current 2>/dev/null || echo "")
    if [ -z "$git_branch" ]; then
        # Get commit hash for detached HEAD
        git_branch=$(git -C "$current_dir" -c core.filemode=false rev-parse --short HEAD 2>/dev/null || echo "")
    fi
fi

# Build status line
status_parts=()

# Model name
if [ -n "$model_name" ]; then
    status_parts+=("󰚩  $model_name")
fi

# Current directory (basename only)
dir_name=$(basename "$current_dir")
status_parts+=("  $dir_name")

# Git branch
if [ -n "$git_branch" ]; then
    status_parts+=(" $git_branch")
fi

# Context usage percentage
if [ -n "$context_pct" ]; then
    status_parts+=("  $context_pct")
fi

# Final output (join elements with " | ")
first=true
for part in "${status_parts[@]}"; do
    if [ "$first" = true ]; then
        printf '%s' "$part"
        first=false
    else
        printf ' | %s' "$part"
    fi
done
