---
name: deslop
description: >-
  AIが生成したコードの冗長なコメント、不要な防御チェック、any型キャストなどを除去する。
  Use when cleaning up AI-generated code slop from the current branch before committing or creating a PR.
disable-model-invocation: true
argument-hint: '[base-branch]'
allowed-tools: ['Read', 'Edit', 'Grep', 'Glob', 'Bash']
---

# Remove AI code slop

Check the diff against the base branch, and remove all AI generated slop introduced in this branch.

Resolve the base branch in this order and stop at the first non-empty result:

1. The first argument, if given.
2. `git symbolic-ref --quiet --short refs/remotes/origin/HEAD | sed 's|^origin/||'`
3. `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
4. `git remote show origin | sed -n 's/.*HEAD branch: //p'`
5. `main`

Never run `git remote set-head` or otherwise mutate refs to make this resolve.

## Focus Areas

- Extra comments that a human wouldn't add or is inconsistent with the rest of the file
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Casts to any to get around type issues
- Deeply nested code that should be simplified with early returns
- Any other style that is inconsistent with the file

## Guardrails

- Keep behavior unchanged unless fixing a clear bug.
- Prefer minimal, focused edits over broad rewrites.

Report at the end with only a 1-3 sentence summary of what you changed in Japanese.
