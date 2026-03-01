---
name: deslop
description: >-
  AIが生成したコードの冗長なコメント、不要な防御チェック、any型キャストなどを除去する。
  Use when cleaning up AI-generated code slop from the current branch before committing or creating a PR.
disable-model-invocation: true
allowed-tools: ['Read', 'Edit', 'Grep', 'Glob', 'Bash']
---

# Remove AI code slop

Check the diff against main, and remove all AI generated slop introduced in this branch.

This includes:
- Extra comments that a human wouldn't add or is inconsistent with the rest of the file
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Casts to any to get around type issues
- Any other style that is inconsistent with the file

Report at the end with only a 1-3 sentence summary of what you changed in Japanese.
