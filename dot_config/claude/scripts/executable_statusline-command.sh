#!/usr/bin/env bash
set -euo pipefail

# Read stdin input from Claude Code
input=$(cat)

# ANSI escape codes
RESET=$'\033[0m'
BOLD=$'\033[1m'

# Ring characters for pie-like display (0% 25% 50% 75% 100%)
RINGS=('○' '◔' '◑' '◕' '●')

# Returns ANSI RGB color code based on percentage (green -> yellow -> red)
gradient() {
    local pct=$1
    if [ "$pct" -lt 50 ]; then
        local r=$(( pct * 51 / 10 ))
        printf $'\033[38;2;%d;200;80m' "$r"
    else
        local g=$(( 200 - (pct - 50) * 4 ))
        if [ "$g" -lt 0 ]; then g=0; fi
        printf $'\033[38;2;255;%d;60m' "$g"
    fi
}

# Returns ring character based on percentage
ring_char() {
    local pct=$1
    local idx=$(( pct / 25 ))
    if [ "$idx" -gt 4 ]; then idx=4; fi
    printf '%s' "${RINGS[$idx]}"
}

# Format label + percentage with ring meter and gradient color
fmt_rate() {
    local label=$1
    local pct=$2
    local color r
    color=$(gradient "$pct")
    r=$(ring_char "$pct")
    printf '%s' "${label} ${color}${r}${RESET} ${BOLD}${pct}%${RESET}"
}

# Format remaining time until resets_at (Unix timestamp) as Xd / Xh / Xm
fmt_remaining() {
    local resets_at=$1
    local now diff
    now=$(date +%s)
    diff=$(( resets_at - now ))
    if [ "$diff" -le 0 ]; then
        printf 'now'
    elif [ "$diff" -lt 3600 ]; then
        printf '%dm' "$(( diff / 60 ))"
    elif [ "$diff" -lt 86400 ]; then
        printf '%dh' "$(( diff / 3600 ))"
    else
        printf '%dd' "$(( diff / 86400 ))"
    fi
}

# ── Parse JSON ──────────────────────────────────────────────

model_name=$(echo "$input" | jq -r '.model.display_name // empty')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')

# Context window usage (no label — icon is used as prefix in the status line)
context_pct=""
_ctx_fmt() {
    local p=$1
    local color r
    color=$(gradient "$p")
    r=$(ring_char "$p")
    printf '%s' "${color}${r}${RESET} ${BOLD}${p}%${RESET}"
}
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$ctx_used" ] && [ "$ctx_used" != "null" ]; then
    context_pct=$(_ctx_fmt "$(printf '%.0f' "$ctx_used")")
else
    usage=$(echo "$input" | jq '.context_window.current_usage // empty')
    if [ -n "$usage" ] && [ "$usage" != "null" ]; then
        current_tokens=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
        total_size=$(echo "$input" | jq '.context_window.context_window_size')
        pct=$(( current_tokens * 100 / total_size ))
        context_pct=$(_ctx_fmt "$pct")
    fi
fi

# 5h rate limit
five_hour_part=""
five_hour_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$five_hour_used" ] && [ "$five_hour_used" != "null" ]; then
    pct=$(printf '%.0f' "$five_hour_used")
    five_hour_part=$(fmt_rate "5h" "$pct")
    if [ -n "$five_hour_resets" ] && [ "$five_hour_resets" != "null" ]; then
        remaining=$(fmt_remaining "$five_hour_resets")
        five_hour_part="${five_hour_part} (${remaining})"
    fi
fi

# 7d rate limit
seven_day_part=""
seven_day_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
if [ -n "$seven_day_used" ] && [ "$seven_day_used" != "null" ]; then
    pct=$(printf '%.0f' "$seven_day_used")
    seven_day_part=$(fmt_rate "7d" "$pct")
    if [ -n "$seven_day_resets" ] && [ "$seven_day_resets" != "null" ]; then
        remaining=$(fmt_remaining "$seven_day_resets")
        seven_day_part="${seven_day_part} (${remaining})"
    fi
fi

# Git branch
git_branch=""
if [ -n "$current_dir" ] && git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -C "$current_dir" -c core.filemode=false branch --show-current 2>/dev/null || echo "")
    if [ -z "$git_branch" ]; then
        git_branch=$(git -C "$current_dir" -c core.filemode=false rev-parse --short HEAD 2>/dev/null || echo "")
    fi
fi

# ── Build output ────────────────────────────────────────────

# Line 1: context | model | branch | dir
line1_parts=()
[ -n "$context_pct" ] && line1_parts+=("  $context_pct")
[ -n "$model_name" ]  && line1_parts+=("󰚩 $model_name")
[ -n "$git_branch" ]  && line1_parts+=(" $git_branch")
if [ -n "$current_dir" ]; then
    dir_name=$(basename "$current_dir")
    line1_parts+=(" $dir_name")
fi

# Line 2: 5h | 7d
line2_parts=()
[ -n "$five_hour_part" ] && line2_parts+=(" $five_hour_part")
[ -n "$seven_day_part" ] && line2_parts+=("$seven_day_part")

# Print each line joined with " | "
join_parts() {
    local first=true
    for part in "$@"; do
        if [ "$first" = true ]; then
            printf '%s' "$part"
            first=false
        else
            printf ' | %s' "$part"
        fi
    done
}

join_parts "${line1_parts[@]}"
if [ "${#line2_parts[@]}" -gt 0 ]; then
    printf '\n'
    join_parts "${line2_parts[@]}"
fi
