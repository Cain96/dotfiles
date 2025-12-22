#!/usr/bin/env bash
set -euo pipefail

# Read stdin input from Claude Code
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Exit if no file path
if [ -z "$file_path" ]; then
    exit 0
fi

# Exit if file doesn't exist
if [ ! -f "$file_path" ]; then
    exit 0
fi

# Exclusion patterns
excluded_patterns=(
    "node_modules/"
    ".git/"
    "dist/"
    "build/"
    ".min.js"
    "package-lock.json"
    "yarn.lock"
    "pnpm-lock.yaml"
    "bun.lockb"
)

# Check if file matches any exclusion pattern
for pattern in "${excluded_patterns[@]}"; do
    if [[ "$file_path" == *"$pattern"* ]]; then
        exit 0
    fi
done

# Get file extension
extension="${file_path##*.}"

# Format based on file type
format_js_ts_json() {
    local file="$1"

    # Get the directory of the file
    local file_dir
    file_dir=$(dirname "$file")

    # Find project root (directory containing package.json)
    local project_root="$file_dir"
    while [ "$project_root" != "/" ]; do
        if [ -f "$project_root/package.json" ]; then
            break
        fi
        project_root=$(dirname "$project_root")
    done

    # Check if project root was found
    if [ "$project_root" = "/" ]; then
        # No package.json found, skip silently
        return 0
    fi

    local biome_bin="$project_root/node_modules/.bin/biome"
    local prettier_bin="$project_root/node_modules/.bin/prettier"

    # Try Biome first
    if [ -x "$biome_bin" ]; then
        if cd "$file_dir" && "$biome_bin" check --write --unsafe "$file" 2>&1; then
            return 0
        fi
        local biome_exit_code=$?
        if [ $biome_exit_code -ne 0 ]; then
            # Biome exists but failed to format
            echo "❌ Biome formatting failed for: $file" >&2
            return 2
        fi
    fi

    # Fallback to Prettier
    if [ -x "$prettier_bin" ]; then
        if cd "$file_dir" && "$prettier_bin" --write "$file" 2>&1; then
            return 0
        fi
        local prettier_exit_code=$?
        if [ $prettier_exit_code -ne 0 ]; then
            # Prettier exists but failed to format
            echo "❌ Prettier formatting failed for: $file" >&2
            return 2
        fi
    fi

    # Neither formatter is available, skip silently
    return 0
}

format_ruby() {
    local file="$1"

    # Use Rubocop for Ruby files
    if command -v rubocop >/dev/null 2>&1; then
        if ! rubocop --autocorrect-all "$file" 2>&1; then
            local rubocop_exit_code=$?
            if [ $rubocop_exit_code -ne 0 ]; then
                echo "❌ Rubocop formatting failed for: $file" >&2
                return 2
            fi
        fi
    fi

    return 0
}

# Format based on extension
case "$extension" in
    ts|tsx|js|jsx|json)
        format_js_ts_json "$file_path"
        exit_code=$?
        ;;
    rb)
        format_ruby "$file_path"
        exit_code=$?
        ;;
    *)
        # Unsupported file type, skip silently
        exit 0
        ;;
esac

# Exit with the formatter's exit code
exit $exit_code
