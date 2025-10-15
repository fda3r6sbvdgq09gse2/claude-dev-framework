---
description: Resume from last saved session after hard reset or interruption
---

# Resume Session Context

Load and display the last saved session state to quickly get back on track after:
- Hard reset or Claude Code restart
- System interruption
- Extended break
- Context compaction

## What It Shows

- Last session timestamp
- Git status at save time
- Modified files
- Recent commits
- Project state
- Extraction candidates
- Next steps
- Framework lock status

## Usage

Run this when:
- Starting a new Claude Code session
- After a hard reset
- When you forgot what you were working on
- To verify state before continuing

## Output

Displays complete session context and verifies:
- ✅ Framework still locked at v2.0.0
- ✅ No unexpected changes
- 📝 Uncommitted work status

## Resume Instructions

After reviewing context:
1. Check git status for in-progress work
2. Review modified files
3. Continue from where you left off

Use `/cost` and `/usage` to check resource usage since last session.

---

**Execution**:
```bash
.ai/scripts/resume_context.sh
```
