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
# Log File Structure:
#   ~/.config/claude/logs/YYYY-MM/YYYY-MM-DD.log
#   Example: ~/.config/claude/logs/2025-01/2025-01-15.log
#
# =============================================================================

# Base log directory
BASE_LOG_DIR="${HOME}/.config/claude/logs"

# Get current date components
year_month=$(date '+%Y-%m')
date_str=$(date '+%Y-%m-%d')

# Create monthly directory path
LOG_DIR="${BASE_LOG_DIR}/${year_month}"

# Create log file path (daily file)
LOG_FILE="${LOG_DIR}/${date_str}.log"

# Create monthly directory if it doesn't exist
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
