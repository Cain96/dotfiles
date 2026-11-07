---
name: thermos
description: >-
  thermo-nuclear-review（バグ・セキュリティ・破壊的変更）と thermo-nuclear-code-quality-review（保守性・構造）でブランチを監査する。
  引数で片方だけ、または両方を並列に走らせて統合する。
  Use for thermos, thermo nuclear / thermonuclear review, deep review, deep code quality audit, or combined bug/security and code-quality branch audits.
disable-model-invocation: true
allowed-tools: ['Read', 'Grep', 'Glob', 'Bash', 'Agent']
argument-hint: '[review|quality|both] [base-branch]'
---

# Thermos

Audit the current branch with one or both thermo-nuclear reviewers.

| Mode | Sub-agent | Focus |
|:--|:--|:--|
| `review` | `thermo-nuclear-review` | bugs, breakages, security, devex regressions, feature-gate leaks |
| `quality` | `thermo-nuclear-code-quality-review` | maintainability, structure, file-size growth, spaghetti, abstractions |
| `both` (default) | both, in parallel | all of the above |

## Orchestration

1. Parse `$ARGUMENTS`:
   - If the first token is `review`, `quality`, or `both`, that is the mode and the next token (if any) is the base branch.
   - Otherwise the mode is `both` and the first token (if any) is the base branch.
2. If no base branch was given, resolve it in this order and stop at the first non-empty result:
   1. `git symbolic-ref --quiet --short refs/remotes/origin/HEAD | sed 's|^origin/||'`
   2. `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
   3. `git remote show origin | sed -n 's/.*HEAD branch: //p'`
   4. `main`

   Never run `git remote set-head` or otherwise mutate refs to make this resolve.
3. In parallel, collect:
   - `git diff <base>...HEAD` (full diff including new files)
   - `git diff <base>...HEAD --name-status` (changed file list)
   - `gh pr view --json number,url,title,body` (ignore failure; there may be no PR)
   - Full contents of each changed file via `Read` (skip lockfiles, generated outputs, and binary assets unless behavior depends on them)
4. Build one shared user prompt containing:
   - `### Git / diff output` followed by the diff and name-status output
   - `### Changed file contents` followed by per-file contents in fenced blocks with a `path` header line
   - `### Pull request` followed by the PR number, URL, title, and body, or `none`
5. Invoke the sub-agent(s) for the mode via the `Agent` tool with that prompt. For `both`, launch the two in a **single message** with `run_in_background: true` and wait for both to finish.

## Synthesis

- Verify each finding you keep against the actual files before presenting it. Drop anything that does not hold up and say you dropped it.
- Do not downgrade or soften findings that hold up.
- For `both`:
  - Deduplicate across reviewers. A finding raised by both is stronger evidence; mark it as such.
  - When the reviewers disagree, decide with your own reading of the code and state the reason in one line.
  - Order: correctness/security High → structural code-quality blockers → Medium → the rest.
- Skip cosmetic nits when larger issues exist.
- End with a one-line verdict: merge-ready, or the blockers that must be resolved first.

## Guardrails

- Do not spawn sub-agents other than the ones for the selected mode.
- Do not edit code or post PR comments from this command. This is review-only; any fix-up must be done in a follow-up turn after the user agrees.
- If the diff is empty, report that and stop.

Report in Japanese with `file:line` for every finding. Do not paste sub-agent output wholesale.
