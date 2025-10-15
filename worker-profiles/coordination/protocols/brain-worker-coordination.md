# Brain-Worker Coordination Protocol

**Origin:** Book Cataloger - Sprint 1 & 2
**Date:** 2025-10-10
**Type:** Development Workflow
**Pattern:** 5-Terminal Parallel Development

## Context

Coordinate 4 specialized workers (GUI, Backend, Integration, Quality/Testing) using git worktrees for true parallel development. Brain terminal orchestrates without coding, workers commit to feature branches, Brain merges to main.

## Architecture

```
┌─────────────────────────────────────────┐
│  BRAIN (Terminal 1 - main branch)      │
│  - Never codes                          │
│  - Monitors workers                     │
│  - Merges completed work                │
│  - Resolves conflicts                   │
└─────────────────────────────────────────┘
            ↓         ↓         ↓
    ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐
    │ GUI       │ │ Backend   │ │ Integration│ │ Testing   │
    │ Terminal 2│ │ Terminal 3│ │ Terminal 4│ │ Terminal 5│
    │ feature/  │ │ feature/  │ │ feature/  │ │ feature/  │
    │   gui     │ │   backend │ │   integration│ │   testing │
    └───────────┘ └───────────┘ └───────────┘ └───────────┘
```

## Setup Protocol

### 1. Worktree Creation
```bash
# Brain creates worktrees once
cd /Users/z/dev/book-cataloger
git worktree add ../book-cataloger-worktrees/book-cataloger-gui -b feature/gui
git worktree add ../book-cataloger-worktrees/book-cataloger-backend -b feature/backend
git worktree add ../book-cataloger-worktrees/book-cataloger-integration -b feature/integration
git worktree add ../book-cataloger-worktrees/book-cataloger-testing -b feature/testing
```

### 2. Task Assignment
Create `.ai/TASK_CONTEXT.md` or `.ai/SPRINT_X_TASKS.md` in each worktree with:
- Clear objectives (numbered tasks)
- Time estimates
- Dependencies (what worker needs from others)
- Domain boundaries (what files they CAN/CANNOT touch)
- Success criteria
- Test requirements

### 3. Worker Launch
Each terminal gets exact copy/paste instructions:
```bash
cd /path/to/worktree
claude

# Then paste:
I'm the [ROLE] Worker - Sprint X.

Show me my tasks:
@.ai/SPRINT_X_TASKS.md

I'll build: [brief summary]

Starting with Task 1: [first task]
```

## Monitoring Protocol

### Every 30-60 Minutes
```bash
# Brain runs status check
.ai/scripts/worktree_status.sh

# Check for completions
find ../book-cataloger-worktrees -name "COMPLETE.txt" -newer .ai/sprint_start_time.txt

# Quick git status
for worker in gui backend integration testing; do
  echo "=== $worker ==="
  cd ../book-cataloger-worktrees/book-cataloger-$worker
  git log --oneline -3
done
```

### What Brain Looks For
- ✅ **COMPLETE.txt exists:** Worker finished
- ⏳ **Recent commits:** Worker making progress
- 🚫 **No commits in 30+ min:** Check if blocked
- ⚠️ **Uncommitted changes:** Worker still coding

## Merge Protocol

### Order: Dependency-Driven
**Sprint 1 & 2 Order:**
1. **Testing** (quick fixes, no dependencies)
2. **Backend** (APIs, export - independent)
3. **Integration** (needs Backend APIs)
4. **GUI** (needs Integration database/workflow)

### Merge Steps (Per Worker)
```bash
# 1. Brain verifies worker is complete
cd ../book-cataloger-worktrees/book-cataloger-WORKER
cat .ai/COMPLETE.txt  # Should list completed tasks
git status  # Should be clean (all committed)

# 2. Brain checks for conflicts BEFORE merge
cd /Users/z/dev/book-cataloger  # Back to main
git merge --no-commit --no-ff feature/WORKER
git status  # Look for conflicts

# If conflicts:
git merge --abort
# Coordinate with worker to resolve

# If clean:
git merge --abort  # Undo dry run
git merge --no-ff feature/WORKER  # Real merge

# 3. Verify merge
pytest  # Run tests
git log --oneline -5  # Verify merge commit

# 4. Update all worktrees
cd ../book-cataloger-worktrees/book-cataloger-WORKER
git fetch origin
git merge origin/main  # Bring in other workers' changes
```

## Conflict Resolution Protocol

### Prevention (Best Practice)
**Domain Separation:**
- GUI Worker: Only touches `src/ui/`
- Backend Worker: Only touches `src/api/`, `src/export/`
- Integration Worker: Only touches `src/core/`, `src/enrichment/`
- Testing Worker: Only touches `tests/`

**Result:** Zero conflicts in Sprint 1 & 2!

### When Conflicts Occur

**Untracked File Blocking:**
```bash
# Error: "untracked working tree files would be overwritten by merge"
# Solution: Move blocking file
mv src/file.py src/file.py.old
git merge --no-ff feature/branch
```

**Code Conflicts:**
```bash
# 1. Identify conflicting files
git status

# 2. Review both versions
git diff feature/branch -- src/conflicting_file.py

# 3. Strategy A: Let worker resolve
cd ../book-cataloger-worktrees/book-cataloger-WORKER
# Tell worker to merge main first and resolve conflicts
git merge main

# Strategy B: Brain resolves (if trivial)
git merge --no-ff feature/branch
# Edit conflicts
git add src/conflicting_file.py
git commit
```

## Worker Communication Patterns

### Blocking Dependencies
**Example:** Integration needs Backend's cover API

**Pattern:**
```python
# Integration Worker mocks initially:
def get_cover_url(isbn: str) -> str:
    # TODO: Replace with real Backend API
    return f"mock_cover_{isbn}.jpg"

# Continue with own work

# After Backend merges:
# Brain tells Integration: "Backend's cover API is merged, update your import"
```

### Shared Data Structures
**Example:** Both workers need to modify BookMetadata

**Pattern:**
- **First worker** (Integration) defines structure
- **Second worker** (GUI) waits or uses mock
- **Brain** merges Integration first
- **Second worker** updates after merge

## Dynamic Worker Reallocation

**Sprint 2 Discovery:** Testing Worker only had 20 min of work

**Brain's Response:**
1. Analyze critical path (GUI was bottleneck at 2-3 hours)
2. Identify alternative roles (GUI Assistant, Algorithm improvements, etc.)
3. **Decision:** Reassign Testing Worker as GUI Assistant after quick task
4. **Result:** Sprint time reduced from 3 hours to 2 hours (33% faster)

**Protocol:**
```bash
# After Testing Worker completes
cd ../book-cataloger-worktrees/book-cataloger-testing
git checkout -b feature/gui-enhancement  # New branch

# Give new task document
cp .ai/GUI_ASSISTANT_TASKS.md .ai/SPRINT_2_TASKS.md

# Tell worker:
"New assignment! You're now GUI Assistant. @.ai/SPRINT_2_TASKS.md"
```

## Success Metrics

### Sprint 1 Results
- **Development time:** 45 minutes parallel (vs ~3 hours sequential)
- **Speedup:** 4x faster
- **Merge conflicts:** 0
- **Test coverage:** 96.6% (85/88 tests passing)
- **Lines added:** 3,117 lines across 3 workers

### Sprint 2 Targets
- **Development time:** 2 hours parallel (vs ~7 hours sequential)
- **Speedup:** 3.5x faster
- **Merge conflicts:** 0 (maintain domain separation)
- **Test coverage:** >95% (total ~165 tests)

## Communication Templates

### Launching Workers
```
I'm the [ROLE] Worker - Sprint [X].

Show me my tasks:
@.ai/SPRINT_X_TASKS.md

I'll build:
- [Task 1 summary]
- [Task 2 summary]

Starting with Task 1: [detailed task]
```

### Monitoring Updates (Every 30 min)
```
Brain: "Status check - GUI Worker?"
GUI Worker: "Task 1 complete (CatalogView), starting Task 2 (AddBooksModal)"
```

### Merge Notification
```
Brain: "Backend Worker merged to main. Integration Worker, you can now use real cover API instead of mock."
```

## Lessons Learned

### Sprint 1
1. **Domain separation works:** Zero conflicts with clear boundaries
2. **Task estimates accurate:** 45 min actual vs 45-60 min estimated
3. **Workers self-sufficient:** Minimal coordination needed during sprint
4. **Testing Worker underutilized:** Need dynamic reallocation

### Sprint 2
1. **Clear dependencies help:** Merge order based on dependencies
2. **Mocking enables parallelism:** Don't wait for other workers
3. **Dynamic reallocation:** Reassigning workers mid-sprint 33% faster
4. **Detailed task documents:** Workers never "lost" with clear tasks

## Future Optimizations

1. **Pattern libraries:** Workers load proven patterns before starting
2. **Agent spawning:** Workers spawn search agents for research
3. **Automated conflict detection:** Pre-merge conflict checking
4. **Worker expertise tracking:** Assign based on specialization
5. **Bottleneck prediction:** Identify critical path before sprint starts

## Tools & Scripts

- **`worktree_status.sh`:** Check all workers' status
- **`setup_worktrees.sh`:** Initial worktree creation
- **`check_conflicts.sh`:** Pre-merge conflict detection
- **`distribute_context.sh`:** Share context across worktrees

## Related Patterns

- Worker specialization profiles
- Pattern library structure
- Agent-based research tasks
- Memory persistence across projects
