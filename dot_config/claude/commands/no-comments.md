---
name: no-comments
description: >-
  comment-sicko サブエージェントを起動し、受け入れた指摘を修正し、制約コメントを型・テスト・Lint へ
  エンコードする案を提示する。
  Use to strip comments, kill workarounds at the root cause, and encode claimed constraints.
disable-model-invocation: true
allowed-tools: ['Read', 'Edit', 'Grep', 'Glob', 'Bash', 'Task']
argument-hint: '[base-branch]'
---

# No comments

Spawn comment-sicko. Act on accepted findings.

Authoring agents defend comments. Defer to comment-sicko's fresh perspective.

## Scope

Use the caller's files or diff. Otherwise use `git diff $(git merge-base <base> HEAD)`, which covers committed, staged, and unstaged changes on this branch; untracked files are not in that diff, so list them with `git status --short` and include them in scope. Resolve the base branch in this order and stop at the first non-empty result:

1. The first argument, if given.
2. `git symbolic-ref --quiet --short refs/remotes/origin/HEAD | sed 's|^origin/||'`
3. `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
4. `git remote show origin | sed -n 's/.*HEAD branch: //p'`
5. `main`

Never run `git remote set-head` or otherwise mutate refs to make this resolve.

## Steps

1. Spawn `Task` with `subagent_type: "comment-sicko"`. Pass the scope, including the resolved base branch. Do not restate its rules.
2. Inspect its report and diff. Reject application-code edits, scope escapes, exception-protected deletions, misstated `MUST KILL` reasons, and flags that treat kept intentional code as guilty. Reshape flags on our-code surprises stay actionable. Do not restore those comments. A keep survives only with proof it is about something we cannot change. Audit missed scoped lint and TypeScript suppressions. Correctness or safety suppressions stay actionable `MUST KILL`s. Restore deletions only with exact exceptions and scoped proof. Before accepting thin `IMPORTANT` or `do not remove` kills or keeps, verify the claim yourself: read the callers and callees of the named symbol, then `git log -S'<symbol>' --oneline` and `git blame -L <line>,<line> -- <file>` for the reason it was written. If a kill is ambiguous, do not restore. If a keep is refuted or still ambiguous, delete it. Revert and rerun one rejected report with the failure named. Reject a second, report it open, and fail `/no-comments`.
3. Fix trivial accepted flags directly by deleting a dead path, dropping a parameter, or using the real API. If any fix needs a shape, sketch the design once for the accepted set and its surrounding code — the target types, boundaries, and call flow — then stop at the sketch. Step 4 implements.
4. Implement the smallest root-cause fix in scope. Remove every named workaround. If the root cause is out of scope, land the smallest in-scope fix and report the rest open. Fix real causes and redesign as if the requirements had always existed; never bolt on symptom guards. That intent never authorizes widening the fence or fixing instances outside it.
5. Constraint comments say `do not remove`, `do not change wording`, or `talk to X before changing`. Leave keeps about things we cannot change. Offer the cheapest in-scope type, runtime, test, or CI lint. Wait for interactive approval. Unattended and eval require caller pre-approval. If approved, encode then delete. Otherwise delete, report the constraint open, and sketch out-of-scope work.
6. Report in Japanese: the deletion count, restored comments, reruns, design sketch, fixes, encoding offers, encodings, unenforced constraints, and other open work.
