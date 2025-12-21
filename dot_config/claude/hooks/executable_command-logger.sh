#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Command Logger for Claude Code
# =============================================================================
# Purpose: Log all Bash command execution history to a file
# Hook Type: PreToolUse
# Target: Bash tool
#
# Log Format:
#   [YYYY-MM-DD HH:MM:SS] username: command
#
# Log File:
#   ~/.config/claude/logs/command_history.log
#
# =============================================================================

# Log file path
LOG_DIR="${HOME}/.config/claude/logs"
LOG_FILE="${LOG_DIR}/command_history.log"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Read hook input from Claude Code via stdin
input=$(cat)

# Extract command from JSON input
# The tool_input.command field contains the Bash command to be executed
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# Exit if command is empty
if [ -z "$command" ]; then
    exit 0
fi

# Get current timestamp (YYYY-MM-DD HH:MM:SS format)
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Create log entry
# Format: [timestamp] username: command
log_entry="[${timestamp}] ${USER}: ${command}"

# Append to log file
# Multiline commands are kept as-is
echo "$log_entry" >> "$LOG_FILE"

# Hook exits successfully (does not block command execution)
exit 0
