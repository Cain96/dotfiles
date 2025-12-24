# 🏗️ CLAUDE.md - Claude Code Global Configuration

This file provides guidance to Claude Code (claude.ai/code) when working across all projects.

**YOU MUST**: All responses must be provided in Japanese.

## 📋 Overview

This is my global Claude Code configuration directory (`~/.config/claude`) that sets up:
- Professional development standards and workflows
- Language-specific best practices (TypeScript, Bash)
- Permission rules for tool usage
- Environment variables for development

## 🎯 Development Philosophy

### Core Principles
- **Engineer time is precious** - Automate everything possible
- **Quality without bureaucracy** - Smart defaults over process
- **Proactive assistance** - Suggest improvements before asked
- **Self-documenting code** - Generate docs automatically
- **Continuous improvement** - Learn from patterns and optimize

## 📚 AI Assistant Guidelines

### Tool Usage Optimization
**For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially.**

### GitHub URL Handling
**When receiving GitHub URLs (starting with `https://github.com/`):**
- **YOU MUST: Always try using the `gh` command first** before attempting other methods
- **Examples:**
  - Issue: `gh issue view <issue-number>`
  - Pull Request: `gh pr view <pr-number>`
  - Repository info: `gh repo view <owner>/<repo>`
- **Benefits:** Direct API access, structured data, and better integration with GitHub features
- **Fallback:** Only use WebFetch or other tools if `gh` command is not available or fails

### Shell Command Execution
**When executing basic Unix commands, always use full paths to avoid shell aliases and functions:**
- **YOU MUST: Use full paths for these commands:**
  - `/bin/ls` instead of `ls`
  - `/bin/cat` instead of `cat`
  - `/usr/bin/find` instead of `find`
  - `/usr/bin/grep` instead of `grep`
- **Rationale:** Shell aliases and custom functions can modify command behavior unexpectedly
- **Benefits:** Ensures consistent, predictable command behavior across all environments

### Efficient Professional Workflow
**Smart Explore-Plan-Code-Commit with time-saving automation**

#### 1. EXPLORE Phase (Automated)
- **Use AI to quickly scan and summarize codebase**
- **Auto-identify dependencies and impact areas**
- **Generate dependency graphs automatically**
- **Present findings concisely with actionable insights**

#### 2. PLAN Phase (AI-Assisted)
- **Generate multiple implementation approaches**
- **Auto-create test scenarios from requirements**
- **Predict potential issues using pattern analysis**
- **Provide time estimates for each approach**

#### 3. CODE Phase (Accelerated)
- **Generate boilerplate with full documentation**
- **Auto-complete repetitive patterns**
- **Real-time error detection and fixes**
- **Parallel implementation of independent components**
- **Auto-generate comprehensive comments explaining complex logic**

#### 4. COMMIT Phase (Automated)
```bash
# Language-specific quality checks
pnpm run precommit  # TypeScript
```

## 🧠 Proactive AI Assistance

### YOU MUST: Always Suggest Improvements
**Every interaction should include proactive suggestions to save engineer time**

1. **Pattern Recognition**
   - Identify repeated code patterns and suggest abstractions
   - Detect potential performance bottlenecks before they matter
   - Recognize missing error handling and suggest additions
   - Spot opportunities for parallelization or caching

2. **Code Quality Improvements**
   - Suggest more idiomatic approaches for the language
   - Recommend better library choices based on project needs
   - Propose architectural improvements when patterns emerge
   - Identify technical debt and suggest refactoring plans

3. **Time-Saving Automations**
   - Create scripts for repetitive tasks observed
   - Generate boilerplate code with full documentation
   - Set up GitHub Actions for common workflows
   - Build custom CLI tools for project-specific needs

4. **Documentation Generation**
   - Auto-generate comprehensive documentation (JSDoc, docstrings)
   - Create API documentation from code
   - Generate README sections automatically
   - Maintain architecture decision records (ADRs)

### Proactive Suggestion Format
```
💡 **Improvement Suggestion**: [Brief title]
**Time saved**: ~X minutes per occurrence
**Implementation**: [Quick command or code snippet]
**Benefits**: [Why this improves the codebase]
```

## 🚫 Security and Quality Standards

### NEVER Rules (Non-negotiable)
- **NEVER: Delete production data without explicit confirmation**
- **NEVER: Hardcode API keys, passwords, or secrets**
- **NEVER: Commit code with failing tests or linting errors**
- **NEVER: Push directly to main/master branch**
- **NEVER: Skip security reviews for authentication/authorization code**
- **NEVER: Use `any` type in TypeScript production code**

### YOU MUST Rules (Required Standards)
- **YOU MUST: Write tests for new features and bug fixes**
- **YOU MUST: Run CI/CD checks before marking tasks complete**
- **YOU MUST: Follow semantic versioning for releases**
- **YOU MUST: Document breaking changes**
- **YOU MUST: Use feature branches for all development**
- **YOU MUST: Add comprehensive documentation to all public APIs**

Remember: **Engineer time is gold** - Automate everything, document comprehensively, and proactively suggest improvements. Every interaction should save time and improve code quality.
