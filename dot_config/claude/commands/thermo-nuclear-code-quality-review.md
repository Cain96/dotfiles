---
name: thermo-nuclear-code-quality-review
description: >-
  保守性・抽象化品質・スパゲッティ化を極めて厳しく審査する code-judo 重視のレビューを実行する。
  Use for a thermo-nuclear code quality review, thermonuclear review, deep code quality audit, or especially harsh maintainability review.
disable-model-invocation: true
allowed-tools: ['Read', 'Grep', 'Glob', 'Bash', 'Task']
argument-hint: '[base-branch]'
---

# Thermo-Nuclear Code Quality Review

Run an unusually strict maintainability review against the current branch. Delegate the actual rubric application to the `thermo-nuclear-code-quality-review` sub-agent so the analysis runs in an isolated context with the full rubric.

## Orchestration

1. Determine the base branch from the first argument; default to `main` when none is given.
2. In parallel, collect:
   - `git diff <base>...HEAD` (full diff including new files)
   - `git diff <base>...HEAD --name-status` (changed file list)
   - Full contents of each changed file via `Read` (skip lockfiles, generated outputs, and binary assets unless behavior depends on them)
3. Invoke the `thermo-nuclear-code-quality-review` sub-agent via the `Task` tool with `subagent_type: "thermo-nuclear-code-quality-review"`. Pass a user prompt containing:
   - `### Git / diff output` followed by the diff and name-status output
   - `### Changed file contents` followed by per-file contents in fenced blocks with a `path` header line
4. Surface the sub-agent's findings to the user in the priority order the rubric specifies. Do not soften or summarize structural callouts.

## Guardrails

- Do not spawn nested sub-agents from the parent. The thermo-nuclear sub-agent is the only delegate.
- Do not edit code from this command. This is review-only; any fix-up must be done in a follow-up turn after the user agrees.
- If the diff is empty, report that and stop.

Report at the end with a concise summary of the top findings in Japanese, followed by the sub-agent's full output verbatim.
