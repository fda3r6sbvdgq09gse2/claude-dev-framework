---
description: Save current session context for easy resume after hard reset or interruption
---

# Save Session Context

Save the current development session state including:
- Git status and modified files
- Recent commits
- Project framework log state
- Extraction candidates
- TODOs and in-progress work
- Framework lock status

## Usage

Run when:
- Before ending a development session
- Before a planned interruption
- After completing significant work
- Before running risky operations

## What Gets Saved

- Git repository state
- Modified files list
- Recent commit history
- Project additions (from project-marketplace.json)
- Extraction candidates (from learnings/)
- TODO state
- Framework lock verification

## Output

Creates timestamped session file in `.ai/context/session_TIMESTAMP.md`
with complete resume instructions.

## To Resume

After saving, resume with:
```
/resume-session
```

Or manually:
```bash
.ai/scripts/resume_context.sh
```

---

**Execution**:
```bash
.ai/scripts/save_context.sh
```
