---
name: git-workflow
description: >-
  Conventional commit format, commit trailers, PR description templates, and
  git workflow operations (branching, rebasing, merging, stashing, cherry-picking,
  bisecting, reverting, pushing, pulling). Use whenever the user performs any
  git operation or invokes any `git` command — including creating commits,
  writing commit messages, creating or reviewing pull requests, managing
  branches, rebasing, stashing, cherry-picking, bisecting, or pushing/pulling.
  Do NOT use for purely conceptual questions about git internals that involve
  no actual operation.
user-invocable: false
allowed-tools: ['Bash', 'Read']
---

# Git Workflow Expert

This skill provides guidance on commit standards and PR best practices.

## 🔧 Commit Standards

### Conventional Commits

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Commit Type Reference

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | Adding user authentication |
| `fix` | Bug fix | Fixing null pointer error |
| `docs` | Documentation only | Update README |
| `style` | Formatting changes | Code formatting, no logic change |
| `refactor` | Code refactoring | Restructure without behavior change |
| `perf` | Performance improvement | Optimize algorithm |
| `test` | Adding/updating tests | Add unit tests |
| `build` | Build system changes | Update webpack config |
| `ci` | CI/CD changes | Update GitHub Actions |
| `chore` | Maintenance tasks | Update dependencies |
| `revert` | Revert previous commit | Revert "feat: add feature" |

### Commit Message Guidelines

**Subject line**:
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period at the end
- Maximum 50 characters

**Body**:
- Wrap at 72 characters
- Explain what and why, not how
- Use bullet points for multiple changes

**Example**:
```bash
git commit -m "$(cat <<'EOF'
feat(api): add user profile endpoint

- Add GET /api/users/:id endpoint
- Include avatar URL in response
- Add rate limiting (100 req/min)

This allows frontend to fetch user details
without additional API calls.

Closes #123
EOF
)"
```

### Commit Trailers

Add metadata to commits using trailers:

```bash
# Reference GitHub issue
git commit --trailer "Github-Issue: #123"

# Credit bug reporter
git commit --trailer "Reported-by: John Doe <john@example.com>"

# Reference related commits
git commit --trailer "See-also: abc123"

# Co-author
git commit --trailer "Co-authored-by: Jane Smith <jane@example.com>"
```

**Example with multiple trailers**:
```bash
git commit -m "$(cat <<'EOF'
fix(auth): resolve token expiration issue

Fixed bug where expired tokens weren't properly
refreshed, causing users to be logged out unexpectedly.

Github-Issue: #456
Reported-by: John Doe <john@example.com>
Reviewed-by: Jane Smith <jane@example.com>
EOF
)"
```

## 📝 Pull Request Guidelines

### PR Title

Follow the same format as commit messages:

```
<type>(<scope>): <description>
```

**Examples**:
- `feat(auth): add OAuth2 authentication`
- `fix(api): resolve race condition in data sync`
- `docs(contributing): update contributor guidelines`

### PR Description Template

```markdown
## Summary
Brief description of changes (1-3 sentences)

## Changes
- Bullet point list of main changes
- Focus on what and why, not implementation details
- Keep it high-level

## Test Plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing performed
- [ ] Edge cases covered

## Breaking Changes
List any breaking changes (if applicable)

## Related Issues
Closes #123
Related to #456

## Screenshots/Videos
(if applicable)
```

### PR Best Practices

1. **Keep PRs small** - Easier to review, faster to merge
2. **One feature per PR** - Don't mix unrelated changes
3. **Update documentation** - Keep docs in sync with code
4. **Add tests** - Don't merge without test coverage
5. **Respond to reviews** - Address feedback promptly
6. **Squash commits** - Clean up commit history before merge
7. **Delete branch** - Clean up after merge

### PR Review Checklist

**Before requesting review**:
- [ ] All tests pass
- [ ] Code is formatted (linter passes)
- [ ] Documentation updated
- [ ] No console.log or debug code
- [ ] Type safety verified (TypeScript)
- [ ] Breaking changes documented

**For reviewers**:
- [ ] Code follows project conventions
- [ ] Logic is clear and maintainable
- [ ] Edge cases are handled
- [ ] Tests are adequate
- [ ] No security vulnerabilities
- [ ] Performance considerations addressed

## 🎯 Git Workflow Checklist

Daily workflow checklist:

- [ ] Pull latest changes: `git pull`
- [ ] Create feature branch
- [ ] Make atomic commits with conventional format
- [ ] Write meaningful commit messages
- [ ] Push regularly: `git push`
- [ ] Create PR with proper description
- [ ] Address review feedback
- [ ] Squash commits if needed
- [ ] Merge and delete branch

## 💡 Advanced Git Tips

### Rebase

Claude Code's shell cannot drive `-i`; squash fixup commits non-interactively.

```bash
# Resolve the repository's default branch (never hardcode main)
BASE=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD | sed 's|^origin/||')
BASE=${BASE:-$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)}
BASE=${BASE:-$(git remote show origin | sed -n 's/.*HEAD branch: //p')}
git commit --fixup=<sha>
git rebase --autosquash "${BASE:-main}"
```

## 🚫 Common Mistakes to Avoid

❌ **Don't**:
- Commit directly to main/master
- Use vague commit messages ("fix bug", "update")
- Mix unrelated changes in one commit
- Forget to pull before pushing
- Leave WIP commits in PR
- Skip commit message body for complex changes

✅ **Do**:
- Use feature branches
- Write descriptive conventional commits
- Make atomic commits (one logical change)
- Pull regularly and before pushing
- Squash/reword commits before merging
- Provide context in commit body
