# Worker Memory Rollback Strategy

**Purpose:** Prevent "rogue workers" and bad learning from corrupting the system
**Author:** Brain Worker
**Date:** 2025-10-10

---

## 🎯 The Problem

Workers accumulate knowledge over time through:
- Profile updates (XP, skills, levels)
- Pattern libraries (reusable code templates)
- Lessons learned (project insights)

**Risk:** Worker could learn bad patterns, hallucinate, or develop inefficient habits.

**Without rollback:** Bad learning persists forever, degrading performance.
**With rollback:** Revert to last known good state in seconds.

---

## ✅ Solution: Git-Based Memory Management

Worker memory (`~/.claude-workers/`) is now a git repository with full version history.

### Directory Structure

```
~/.claude-workers/
├── .git/                    # Full version history
├── backend/
│   ├── profile.md          # XP, skills, stats
│   └── patterns/           # Code templates
├── frontend/
│   ├── profile.md
│   └── patterns/
├── integration/
│   ├── profile.md
│   └── patterns/
├── testing/
│   ├── profile.md
│   └── patterns/
└── coordination/
    ├── TEAM_SYSTEM.md
    └── protocols/
```

---

## 🔄 Rollback Commands

### View History

```bash
cd ~/.claude-workers

# View commit history
git log --oneline --all

# Example output:
# a7f3e2b Sprint 3 patterns saved
# e7049e8 Sprint 3 complete - Worker XP updates
# 3c2d1a0 Sprint 2 complete
```

### Check Worker Stats

```bash
# Compare current vs previous sprint
git diff HEAD~1 integration/profile.md

# See what patterns were added
git diff HEAD~1 --name-only | grep patterns
```

### Rollback Entire System

```bash
# Rollback to previous commit (undo Sprint 3)
git reset --hard HEAD~1

# Rollback to specific commit
git reset --hard e7049e8

# Rollback specific worker only
git checkout HEAD~1 -- integration/profile.md integration/patterns/
```

### Rollback Specific Pattern

```bash
# Remove bad pattern
git rm backend/patterns/broken-pattern.md
git commit -m "Remove broken pattern that caused hallucinations"

# Revert pattern to previous version
git checkout HEAD~1 -- backend/patterns/api-fallback.md
git commit -m "Revert API fallback pattern to Sprint 2 version"
```

---

## 🎯 Quality Gates (Prevent Bad Learning)

### Before Committing Worker Updates

**1. Verify Sprint Completion**
```bash
# Check all workers completed successfully
for worker in backend frontend integration testing; do
  cat ../book-cataloger-worktrees/book-cataloger-$worker/.ai/COMPLETE.txt
done
```

**2. Review Learning Captures**
```bash
# Check learning capture for hallucinations
cat ../book-cataloger-worktrees/book-cataloger-integration/.ai/SPRINT_X_LEARNING_CAPTURE.md
```

**3. Validate XP Gains**
```bash
# XP gains should be reasonable
# Sprint: +20
# Tasks: +25 each (max ~100)
# New skills: +10 each (max ~40)
# Bonus: +5-15
# Total: Should be 60-150 per sprint

# Suspicious: +500 XP (too high!)
# Suspicious: +10 XP (too low!)
```

**4. Check Pattern Quality**
```bash
# Pattern should have:
# - Clear problem statement
# - Code example
# - When to use
# - Testing approach

# Red flags:
# - Vague advice ("just use X")
# - No code examples
# - Overly complex solutions
# - Contradicts previous patterns
```

---

## 🚨 Detecting Bad Learning

### Signs of "Rogue Worker"

**XP inflation:**
```
Sprint 1: +100 XP
Sprint 2: +120 XP
Sprint 3: +500 XP  # ⚠️ Suspicious!
```

**Contradictory patterns:**
```
# Sprint 2 pattern: Use CSV for databases
# Sprint 3 pattern: CSV is slow, use SQL always
# ⚠️ Contradicts without justification!
```

**Hallucinated skills:**
```
Skills Improved:
- Quantum Computing: NEW → ⭐⭐⭐⭐⭐  # ⚠️ Not in project!
- Time Travel APIs: NEW → ⭐⭐⭐⭐   # ⚠️ Hallucination!
```

**Overly complex solutions:**
```python
# ⚠️ Red flag: 500 lines for simple task
def add_two_numbers(a, b):
    # ... 500 lines of unnecessary abstraction ...
    return a + b
```

---

## 📊 Health Monitoring

### Sprint-by-Sprint Quality Check

```bash
# After each sprint, check:

1. XP gains reasonable? (60-150 per sprint)
2. Skills align with project? (no quantum computing for book catalog!)
3. Patterns have code examples? (not just advice)
4. Patterns documented thoroughly? (when to use, testing, etc.)
5. Worker stats consistent? (no sudden jumps in skills)
```

### Automated Checks (Future)

```python
#!/usr/bin/env python3
"""Validate worker memory quality."""

def validate_xp_gain(old_xp: int, new_xp: int, sprint_num: int):
    """Check XP gain is reasonable."""
    gain = new_xp - old_xp

    if gain < 50:
        raise Warning(f"Low XP gain: {gain} (expected 60-150)")

    if gain > 200:
        raise Warning(f"Excessive XP gain: {gain} (expected 60-150)")

def validate_pattern(pattern_file: str):
    """Check pattern has required sections."""
    required_sections = ['Problem', 'Solution', 'Code Example', 'Usage', 'Testing']

    with open(pattern_file) as f:
        content = f.read()

    missing = [s for s in required_sections if s not in content]

    if missing:
        raise ValueError(f"Pattern missing sections: {missing}")
```

---

## 🔧 Rollback Scenarios

### Scenario 1: Bad Pattern Added

**Problem:** Sprint 3 added a pattern that causes bugs

**Solution:**
```bash
cd ~/.claude-workers

# Remove bad pattern
git rm integration/patterns/broken-confidence-scoring.md

# Restore old pattern
git checkout HEAD~1 -- integration/patterns/confidence-scoring.md

git commit -m "Rollback: Restore Sprint 2 confidence scoring pattern"
```

### Scenario 2: Worker Hallucinated Skills

**Problem:** Worker claims mastery of skills not used in project

**Solution:**
```bash
# Revert profile to previous sprint
git checkout HEAD~1 -- backend/profile.md

git commit -m "Rollback: Remove hallucinated Quantum Computing skill"
```

### Scenario 3: XP Inflation

**Problem:** Worker awarded excessive XP (400+ per sprint)

**Solution:**
```bash
# Revert all profiles to last commit
git checkout HEAD~1 -- */profile.md

# Manually recalculate XP
# Edit profiles with correct XP

git commit -m "Rollback: Fix XP inflation bug"
```

### Scenario 4: Entire Sprint Was Bad

**Problem:** Sprint 4 was a disaster, everything needs rollback

**Solution:**
```bash
# Rollback entire memory to Sprint 3
git reset --hard HEAD~1

# Force push if synced to remote
git push --force origin main
```

---

## 📝 Best Practices

### 1. Commit After Each Sprint

```bash
# Sprint complete? Commit immediately!
cd ~/.claude-workers
git add -A
git commit -m "Sprint X complete - [brief summary]"
```

### 2. Review Before Committing

```bash
# Check what changed
git diff

# Review profile changes
git diff */profile.md

# Review new patterns
git diff --name-only | grep patterns
```

### 3. Tag Major Milestones

```bash
# Tag after successful project completion
git tag -a v1.0-book-cataloger -m "Book Cataloger project complete"

# Rollback to milestone
git checkout v1.0-book-cataloger
```

### 4. Branch for Experimental Learning

```bash
# Try risky pattern in branch
git checkout -b experimental-async-patterns

# If good, merge
git checkout main
git merge experimental-async-patterns

# If bad, discard
git checkout main
git branch -D experimental-async-patterns
```

---

## 🎮 Token Economics

### Why This Matters

- **Context limit:** 200k tokens
- **Worker profiles:** ~3k tokens each
- **Patterns:** ~2k tokens each
- **Total memory:** ~50k tokens (25% of context!)

**Risk:** Bloated memory wastes tokens on useless patterns.

**Solution:** Prune bad patterns aggressively.

```bash
# Remove unused patterns
git rm backend/patterns/never-used-pattern.md

# Keep memory lean and focused
```

---

## 🚀 Recovery Procedures

### If Worker "Goes Rogue"

**1. Stop work immediately**
```bash
# Exit Claude Code
exit
```

**2. Assess damage**
```bash
cd ~/.claude-workers
git log --oneline -10
git diff HEAD~1
```

**3. Rollback to last good state**
```bash
git reset --hard HEAD~1
```

**4. Document incident**
```bash
# Create incident report
cat > coordination/incidents/2025-10-10-backend-rogue.md <<EOF
# Incident: Backend Worker Hallucination

Date: 2025-10-10
Worker: Backend
Issue: Claimed mastery of GraphQL when project uses REST
Action: Rolled back to Sprint 2 state
Prevention: Add skill validation checks
EOF

git add coordination/incidents/
git commit -m "Document: Backend worker hallucination incident"
```

---

## ✅ Success Criteria

Worker memory system is healthy when:

✅ XP gains are consistent (60-150 per sprint)
✅ Skills align with project technology
✅ Patterns have code examples and testing
✅ No contradictory patterns
✅ Profiles match project reality
✅ Git history shows steady progress
✅ Can rollback any sprint in < 30 seconds

---

## 🎯 Future Enhancements

1. **Automated validation:** Pre-commit hooks check XP/skills
2. **Pattern linting:** Validate pattern format
3. **Skill verification:** Check skills against project files
4. **Memory compression:** Archive old patterns after N projects
5. **Cross-project learning:** Share patterns between projects
6. **Quality scoring:** Rate patterns by usefulness

---

**This rollback strategy ensures workers can learn aggressively without risk!**

If a pattern doesn't work → rollback in seconds.
If XP inflation occurs → fix and recommit.
If hallucination detected → revert to last good state.

**Workers can now evolve rapidly with safety net!** 🚀
