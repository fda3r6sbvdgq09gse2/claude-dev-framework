---
name: git-workflow
description: Our git branching, commits, and collaboration patterns for AI-assisted development
version: 1.0.0
author: Globex Systems / Blackford Inc.
tags: [git, version-control, workflow, trunk-based, conventional-commits]
external_reference: https://git-scm.com/doc
last_updated: 2025-10-18
---

# Git Workflow Skill

## Overview

This skill documents our Git branching, commit, and collaboration workflow. We follow a simplified trunk-based development model optimized for AI-assisted development with multiple agents working in parallel.

---

## Our Conventions

### Branch Strategy

**Official way:** Git supports any branching model (Git Flow, GitHub Flow, etc.)

**Our way:** **Trunk-based development with feature branches**

**Why:**
- Simple (main + short-lived feature branches)
- Fast iteration (AI agents work in parallel)
- Low merge conflict risk
- Easy to understand

**Structure:**
```
main (production-ready)
  ├── feature/sprint-7A-camera
  ├── feature/sprint-7A-barcode
  └── fix/isbn-validation
```

---

### Commit Messages

**Official way:** Git doesn't enforce commit message format

**Our way:** **Conventional Commits with AI attribution**

**Format:**
```
<type>: <description>

[optional body]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types we use:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation only
- `refactor:` - Code restructuring
- `test:` - Adding tests
- `chore:` - Maintenance

**Example:**
```bash
git commit -m "$(cat <<'EOF'
feat: Add camera-based ISBN scanning

- Implement OpenCV camera capture
- Add pyzbar barcode detection
- Integrate with enrichment workflow

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

**Why:**
- Clarity (type shows intent immediately)
- Attribution (shows human-AI collaboration)
- Searchable (`git log --grep="feat:"`)
- Professional (clear for external contributors)

---

### Branch Naming

**Our convention:**
```
<category>/<sprint>-<description>
```

**Categories:**
- `feature/` - New features
- `fix/` - Bug fixes
- `refactor/` - Code improvements
- `docs/` - Documentation work

**Examples:**
```bash
feature/sprint-7A-camera-scanning
fix/isbn-checksum-validation
refactor/api-error-handling
docs/architecture-updates
```

**Why:**
- Organized by sprint (easy to track)
- Category visible at a glance
- Auto-closes issues (if we add `#123`)

---

## Patterns We Use

### Pattern: Feature Branch Workflow

**When to use:** All new features, even small ones

**Flow:**
```bash
# 1. Start from main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/sprint-7A-camera-scanning

# 3. Work and commit
# (make changes)
git add src/
git commit -m "feat: Add camera capture module"

# 4. Push to remote
git push -u origin feature/sprint-7A-camera-scanning

# 5. Create PR
gh pr create --title "Sprint 7A: Camera Scanning" --body "..."

# 6. After review and merge
git checkout main
git pull origin main
git branch -d feature/sprint-7A-camera-scanning
```

**Why it works:**
- Isolated work (no conflicts on main)
- Easy to review (all changes in one PR)
- Easy to abandon (just delete branch)
- Parallel work (multiple agents, multiple branches)

---

### Pattern: Atomic Commits

**When to use:** Always

**Rule:** Each commit = one logical change

**Good (atomic):**
```bash
git commit -m "feat: Add ISBN validation function"
git commit -m "test: Add tests for ISBN validation"
git commit -m "docs: Document ISBN validation usage"
```

**Bad (non-atomic):**
```bash
git commit -m "Add validation, tests, docs, and fix typo"
```

**Why:**
- Easy to review (one change per commit)
- Easy to revert (surgical rollback)
- Clear history (understand evolution)
- Bisect-friendly (debug with `git bisect`)

---

### Pattern: Commit Before AI Session Ends

**When to use:** Every Claude Code session

**Rule:** Always commit working code before exiting

**Flow:**
```bash
# At end of Claude session
git add src/ tests/
git commit -m "feat: Complete camera scanning implementation

- OpenCV integration working
- Tests passing (coverage 87%)
- Ready for review

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin feature/sprint-7A-camera-scanning
```

**Why:**
- Preserves progress (can't rely on Claude's memory)
- Enables handoffs (human reviews, next session starts clean)
- Backup (work saved remotely)
- Visibility (team sees progress)

---

### Pattern: Pull Before Push

**When to use:** Always, especially with parallel agents

**Flow:**
```bash
# Before pushing
git pull --rebase origin feature/sprint-7A-camera-scanning

# If conflicts, resolve them
git rebase --continue

# Then push
git push origin feature/sprint-7A-camera-scanning
```

**Why:**
- Avoids "rejected push" errors
- Keeps history linear (with rebase)
- Catches integration issues early
- Essential for parallel work

---

## Patterns We Avoid

### Anti-pattern: Long-Lived Feature Branches

**What:** Feature branches that live for weeks/months

**Why we avoid:**
- High merge conflict risk
- Hard to review (too many changes)
- Blocks integration
- Defeats purpose of trunk-based development

**Alternative:**
- Keep feature branches < 3 days
- Merge frequently to main
- Use feature flags for incomplete work
- Break large features into smaller branches

---

### Anti-pattern: Cryptic Commit Messages

**What:** Messages like "fix", "update", "wip"

**Why we avoid:**
- Impossible to understand history
- Can't find specific changes
- Unprofessional
- Wastes time (have to read diff to understand)

**Alternative:**
- Use conventional commit format
- Describe WHAT and WHY
- Be specific: "fix: Handle null ISBN in barcode detector"

---

### Anti-pattern: Committing Broken Code

**What:** Committing code that doesn't pass tests

**Why we avoid:**
- Breaks main branch
- Blocks other developers
- Wastes time (everyone has to fix)
- CI/CD fails

**Alternative:**
- Run tests before commit: `pytest`
- Use pre-commit hooks
- Mark WIP commits explicitly (and fix before merging)

---

## Learned the Hard Way

### Lesson 1: Always Use HEREDOC for Multi-Line Commits

**Problem:** Shell quoting issues with multi-line commit messages

**Solution:**
```bash
# BAD (shell might mangle newlines)
git commit -m "feat: Add feature\n\nBody text"

# GOOD (HEREDOC preserves formatting)
git commit -m "$(cat <<'EOF'
feat: Add feature

Body text with
multiple lines

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Lesson 2: Check Git Status Before Claude Commits

**Problem:** Claude might add files you don't want committed

**Solution:**
```bash
# Always check what's being committed
git status
git diff --cached

# Verify, then commit
git commit -m "..."
```

---

### Lesson 3: Pre-Commit Hooks Can Modify Files

**Problem:** Black/Ruff might reformat files during commit, causing "commit failed" followed by "everything's modified"

**Solution:**
```bash
# If commit fails due to hook changes
git add .
git commit --amend --no-edit

# OR: Verify authorship first
git log -1 --format='%an %ae'
# If it's your commit, amend is safe
```

---

## Workflow Diagrams

### Daily Development Flow

```
┌─────────────────────────────────────────┐
│ Morning: Start Day                      │
└─────────────────┬───────────────────────┘
                  │
                  ▼
        ┌─────────────────┐
        │ git checkout main│
        │ git pull         │
        └─────────┬───────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ git checkout -b feature/│
        └─────────┬───────────────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ Work + Commit (atomic)  │
        │ git add, git commit     │
        └─────────┬───────────────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ git push -u origin       │
        └─────────┬───────────────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ gh pr create            │
        └─────────┬───────────────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ After Review: Merge     │
        └─────────┬───────────────┘
                  │
                  ▼
        ┌─────────────────────────┐
        │ git checkout main       │
        │ git pull                │
        │ git branch -d feature/  │
        └─────────────────────────┘
```

---

### Parallel Agent Flow

```
Main Branch
    │
    ├─── feature/backend (Backend Agent)
    │       ↓
    │    [work, commit, push]
    │       ↓
    │    [PR: backend]
    │       ↓
    │    [merge to main]
    │
    ├─── feature/frontend (Frontend Agent)
    │       ↓
    │    [work, commit, push]
    │       ↓
    │    [PR: frontend]
    │       ↓
    │    [merge to main]
    │
    └─── feature/integration (Integration Agent)
            ↓
         [pull main]
         [integrate backend + frontend]
         [commit, push]
            ↓
         [PR: integration]
            ↓
         [merge to main]
```

**Key:** Integration agent pulls latest main to combine work from other agents.

---

## Related

**Internal:**
- `execution/sprints/` - Sprint planning uses this workflow
- `.claude/commands/commit-changes.md` - Slash command using this pattern

**External:**
- Git docs: https://git-scm.com/doc
- Conventional Commits: https://www.conventionalcommits.org/
- Trunk-Based Development: https://trunkbaseddevelopment.com/

**Framework:**
- `../claude-dev-framework/docs/git-workflow.md` - Framework-level patterns

---

## Changelog

- **2025-10-18:** Initial version documenting current workflow
- **2025-10-13:** Established HEREDOC pattern for multi-line commits
- **2025-10-11:** Added AI co-authorship attribution

---

**Status:** 🟢 Active - This is our current workflow
**Last Updated:** October 18, 2025
