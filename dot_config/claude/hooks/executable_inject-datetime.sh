#!/usr/bin/env bash
set -euo pipefail

DATETIME=$(TZ=Asia/Tokyo date '+%Y-%m-%d %H:%M (%A) JST')
echo "Now is ${DATETIME}. Use this as the current date and time for all reasoning."
