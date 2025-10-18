---
name: agent-coordination
description: Multi-agent workflow patterns for parallel development without conflicts
version: 1.0.0
author: Globex Systems / Blackford Inc.
tags: [multi-agent, coordination, parallel, workflow, collaboration]
last_updated: 2025-10-18
---

# Agent Coordination Skill

## Overview

This skill documents how multiple AI agents work in parallel on the same project without conflicts. We use git worktrees, clear task boundaries, and turn-based protocols.

---

## Core Principles

### 1. One Agent, One Worktree

**Pattern:**
```bash
# Main repo
~/dev/book-cataloger/          # Main branch

# Agent worktrees
~/.claude-workers/
├── backend-agent/             # Backend's worktree
├── frontend-agent/            # Frontend's worktree
├── integration-agent/         # Integration's worktree
└── testing-agent/             # Testing's worktree
```

**Why:**
- Each agent has isolated workspace
- No file conflicts
- Can work simultaneously
- Clean separation

---

### 2. Clear Task Boundaries

**Before sprint:**
```markdown
Sprint 7A tasks:
- Backend: API endpoints (src/api/)
- Frontend: UI components (src/ui/)
- Integration: Connect API→UI (src/core/integration.py)
- Testing: Test all layers (tests/)
```

**Rules:**
- Each agent owns specific files
- No overlap in file ownership
- Integration agent coordinates
- CEO agent plans boundaries

---

### 3. Turn-Based Communication

**Protocol:**
```
Backend completes API → Commits → Pushes
  ↓
Integration pulls → Tests integration → Commits → Pushes
  ↓
Frontend pulls → Updates UI → Commits → Pushes
  ↓
Testing pulls → Runs full tests → Reports
```

**Not:**
- ❌ Simultaneous editing of same file
- ❌ Parallel commits without coordination
- ❌ Merge conflicts

---

## Workflow Patterns

### Sprint Start

**CEO Agent:**
1. Create sprint plan
2. Define task boundaries
3. Assign agents to tasks
4. Set up worktrees

**Each Agent:**
1. Create feature branch
2. Pull latest main
3. Start assigned task
4. Communicate progress

---

### During Sprint

**When you complete work:**
```bash
# 1. Run tests
pytest

# 2. Commit
git add src/
git commit -m "feat: Complete task X"

# 3. Push
git push origin feature/my-task

# 4. Notify next agent
# (via PR, comment, or handoff doc)
```

**When waiting for dependencies:**
- Work on independent tasks
- Write tests for future integration
- Document your progress
- Ask CEO for priority shift

---

### Integration Points

**Integration Agent role:**
- Pull all feature branches
- Test combinations
- Resolve conflicts
- Create integration PR

**Process:**
```bash
# Integration agent workflow
git checkout main
git pull

# Merge each agent's work
git merge origin/feature/backend-work
git merge origin/feature/frontend-work

# Test integration
pytest tests/integration/

# If tests pass
git push origin integration/sprint-7A
```

---

## Communication Protocols

### Handoff Document

**Create:** `.ai/handoffs/{agent}-to-{agent}.md`

```markdown
# Backend → Integration Handoff

## Completed:
- API endpoints for book CRUD
- ISBN validation endpoint
- Error handling middleware

## Files Modified:
- src/api/books.py
- src/api/isbn.py
- tests/api/test_books.py

## Next Steps:
- Integration: Connect to frontend
- Testing: Add E2E tests

## Known Issues:
- None

## How to Test:
\`\`\`bash
pytest tests/api/
\`\`\`
```

---

### Status Updates

**Daily standup format:**
```markdown
## {Agent} Daily Update

**Yesterday:**
- Completed API endpoints
- Fixed ISBN validation bug

**Today:**
- Working on error handling
- Adding tests

**Blockers:**
- Waiting for frontend UI specs
```

---

## Conflict Resolution

### Prevention

**Before starting work:**
```bash
# Check what files others are using
cat .ai/current-tasks.md

# Confirm your task doesn't overlap
# If overlap, coordinate with CEO
```

**File ownership registry:**
```yaml
# .ai/file-ownership.yaml
backend:
  - src/api/*
  - src/core/business_logic.py

frontend:
  - src/ui/*
  - src/components/*

integration:
  - src/core/integration.py
  - src/workflows/*
```

---

### When Conflicts Happen

**Small conflicts:**
```bash
# Pull latest
git pull --rebase origin main

# Resolve conflicts
# Edit conflicted files
git add .
git rebase --continue
```

**Large conflicts:**
- Escalate to Integration agent
- Integration agent coordinates resolution
- May require pair programming session

---

## Parallel Work Examples

### Example: Sprint 7A

**Task breakdown:**
```
Backend (2 days):
  - API: ISBN lookup endpoint
  - API: Book enrichment endpoint

Frontend (2 days):
  - UI: Camera scanner component
  - UI: Book details display

Integration (0.5 days):
  - Connect camera → API
  - Wire enrichment → UI

Testing (0.5 days):
  - Unit tests (all layers)
  - Integration tests
  - E2E tests
```

**Timeline:**
```
Day 1:
  Backend: Start API work
  Frontend: Start UI work
  (Parallel, no dependencies)

Day 2:
  Backend: Complete API
  Frontend: Complete UI mockup
  Integration: Start connecting

Day 2.5:
  Integration: Complete integration
  Testing: Run full test suite
```

---

## Best Practices

**✅ DO:**
- Commit often (atomic commits)
- Push frequently (share progress)
- Communicate blockers immediately
- Test before pushing
- Write clear commit messages
- Update handoff docs

**❌ DON'T:**
- Edit files owned by other agents
- Commit broken code
- Push without running tests
- Work in silence (communicate!)
- Create massive PRs
- Skip documentation

---

## Tools & Scripts

### Check Worktree Status

```bash
# See all worktrees
git worktree list

# See what agent is working on what
ls ~/.claude-workers/
```

### Sync All Agents

```bash
# Script: .ai/scripts/sync-all-agents.sh
for agent in backend frontend integration testing; do
  cd ~/.claude-workers/$agent-agent/
  git pull origin main
  echo "✅ Synced $agent"
done
```

---

## Related

- `skills/git-workflow/SKILL.md` - Git conventions
- `skills/sprint-planning/SKILL.md` - How CEO plans sprints
- `vision/FOUR_TIER_ARCHITECTURE.md` - System architecture

---

**Status:** 🟢 Active
**Last Updated:** October 18, 2025
