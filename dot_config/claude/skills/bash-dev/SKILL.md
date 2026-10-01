---
name: bash-dev
description: >-
  Bash scripting development standards, error handling, and best practices.
  Use when writing, editing, or reviewing .sh files or Bash scripts,
  when the user asks about Bash patterns/conventions, or when shell script quality guidance is needed.
user-invocable: false
allowed-tools: ['Read', 'Grep', 'Bash']
---

# Bash Development Expert

This skill supports Bash script development with best practices and safety standards.

## 🎯 Core Rules

### Shebang and Safety
- **Shebang**: Always use `#!/usr/bin/env bash`
- **Set Options**: Always use `set -euo pipefail`
  - `-e`: Exit on error
  - `-u`: Exit on undefined variable
  - `-o pipefail`: Fail pipeline if any command fails

### Variable Handling
- **Quoting**: Always quote variables `"${var}"`
- **Constants**: Use UPPERCASE for global/environment variables
- **Local Variables**: Use lowercase for function-local variables
- **Readonly**: Use `readonly` for constants

### Function Best Practices
- **Local Variables**: Always use `local` keyword
- **Parameter Validation**: Validate required parameters
- **Return Codes**: 0 for success, non-zero for errors

## Skeleton

Scale this to the script; small scripts don't need usage or argument parsing.

```bash
#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  local target="${1:?usage: $(basename "$0") <target>}"
  # ...
}

main "$@"
```

## 🎯 Quality Checklist

Check these before committing:

- [ ] Shebang `#!/usr/bin/env bash` present
- [ ] `set -euo pipefail` at the beginning
- [ ] All variables quoted `"${var}"`
- [ ] Global variables in UPPERCASE
- [ ] Local variables use `local` keyword
- [ ] Error handling implemented
- [ ] Usage function provided (when the script takes arguments)
- [ ] Exit codes are meaningful (0=success, non-zero=error)
- [ ] Script tested with `shellcheck`

## Verification

Run `shellcheck` on every script you write or edit, and fix or justify each warning (`# shellcheck disable=SCxxxx` with the reason).
