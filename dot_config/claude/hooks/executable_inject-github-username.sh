#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  exit 0
fi

USERNAME=$(gh auth status --json hosts --jq '.hosts."github.com"[] | select(.active == true) | .login' 2>/dev/null || true)

if [[ -z "${USERNAME}" ]]; then
  exit 0
fi

echo "My GitHub username is ${USERNAME}."
