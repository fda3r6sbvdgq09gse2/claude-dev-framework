---
name: sprint-planning
description: How we plan and execute 2-3 day sprints with clear goals and tasks
version: 1.0.0
author: Globex Systems / Blackford Inc.
tags: [sprint, planning, agile, ceo, coordination, tasks]
last_updated: 2025-10-18
---

# Sprint Planning Skill

## Overview

This skill documents how the CEO agent plans sprints. We use 2-3 day sprints with clear goals, task breakdowns, and success criteria.

---

## Sprint Structure

### Duration

**Standard:** 2-3 days

**Why:**
- Short enough for focus
- Long enough for meaningful work
- Fits AI agent attention span
- Allows rapid iteration

---

### Sprint Numbering

**Format:** `sprint-{number}{letter}-{name}`

**Examples:**
- `sprint-7A-camera-scanner`
- `sprint-7B-api-optimization`
- `sprint-8A-ui-redesign`

**Why:**
- Number = major milestone
- Letter = iteration within milestone
- Name = descriptive, memorable

---

## Planning Process

### Step 1: Define Goal

**One sentence sprint goal:**
```
Sprint 7A Goal: Implement ISBN recognition via camera input
```

**Success criteria:**
- Camera feed displays in app
- Barcodes detected with >90% accuracy
- Scanned ISBNs auto-populate enrichment
- Users can toggle camera/manual input

---

### Step 2: Break Down Tasks

**Task template:**
```markdown
### TASK-{number}: {Task Name}

**Owner:** {Agent}
**Estimate:** {hours}
**Dependencies:** {TASK-xxx or None}

**Deliverables:**
- [ ] Deliverable 1
- [ ] Deliverable 2

**Technical Notes:**
- Implementation detail
- Edge case to handle

**Test Cases:**
1. Happy path
2. Edge case
```

---

### Step 3: Assign Agents

**Principles:**
- Each agent owns specific tasks
- No file conflicts (different directories)
- Clear dependencies
- Parallelizable when possible

**Example assignment:**
```
Backend: API endpoints (TASK-001, TASK-002)
Frontend: UI components (TASK-003, TASK-004)
Integration: Wire together (TASK-005)
Testing: Validate all (TASK-006)
```

---

### Step 4: Create Sprint Document

**Location:** `execution/sprints/sprint-{N}-{name}.md`

**Template sections:**
1. Sprint Goal
2. Success Criteria
3. Backlog Items (P0, P1, P2)
4. Architecture Diagram
5. Technical Decisions
6. Testing Strategy
7. Sprint Schedule (day-by-day)
8. Definition of Done
9. Retrospective Template

**See:** Sprint 7A for complete example

---

## During Sprint

### Daily Checkpoints

**Morning:**
- Review progress from yesterday
- Update task status (pending → in_progress → completed)
- Identify blockers
- Adjust priorities if needed

**Evening:**
- Commit completed work
- Update sprint document
- Communicate progress

---

### Task Status Updates

**Use:** TodoWrite tool or update sprint doc

```markdown
**Tasks:**
- [x] TASK-001: Camera input (Backend) ✅
- [ ] TASK-002: Barcode detection (Backend) 🏃 In Progress
- [ ] TASK-003: UI component (Frontend) ⏸️ Waiting on TASK-002
```

---

### Handling Blockers

**When blocked:**
1. Document blocker clearly
2. Notify CEO agent
3. Work on independent task
4. CEO reassigns if needed

**Blocker template:**
```markdown
## Blocker: {Description}
**Task:** TASK-002
**Agent:** Backend
**Issue:** Need camera permissions API from frontend
**Impact:** Cannot test camera integration
**Workaround:** Using mock camera for now
**Resolution:** Coordinate with Frontend
```

---

## Sprint Closure

### Definition of Done

**Sprint complete when:**
- [ ] All P0 tasks completed
- [ ] >80% P1 tasks completed
- [ ] Tests passing (unit + integration)
- [ ] Documentation updated
- [ ] No blocking bugs
- [ ] Sprint retrospective done

---

### Retrospective

**Template:**
```markdown
## Sprint {N} Retrospective

### What Went Well
- [Positive 1]
- [Positive 2]

### What Could Improve
- [Improvement 1]
- [Improvement 2]

### Action Items for Next Sprint
- [ ] [Action 1]
- [ ] [Action 2]

### Skills/Patterns Learned
- Document in skills/ if reusable

### Metrics Achieved
- Detection Accuracy: 92%
- Tests Added: 15
- Coverage: 87%
```

---

## Planning Templates

### Feature Sprint

**Focus:** New capability

**Structure:**
```
Goal: Add {feature}
Tasks: Design → Implement → Test → Document
Duration: 2-3 days
Agents: Backend, Frontend, Integration, Testing
```

---

### Bug Fix Sprint

**Focus:** Quality improvement

**Structure:**
```
Goal: Fix {critical bugs}
Tasks: Reproduce → Fix → Verify → Prevent
Duration: 1-2 days
Agents: Relevant specialists
```

---

### Refactor Sprint

**Focus:** Code quality

**Structure:**
```
Goal: Improve {component}
Tasks: Analyze → Refactor → Test → Document
Duration: 2-3 days
Requirement: All tests pass before and after
```

---

## Best Practices

**✅ DO:**
- Start with clear goal (one sentence)
- Break into small tasks (< 4 hours each)
- Assign owners explicitly
- Define success criteria upfront
- Update status daily
- Do retrospective

**❌ DON'T:**
- Vague goals ("improve stuff")
- Massive tasks (> 8 hours)
- Unclear ownership
- Change scope mid-sprint
- Skip retrospective
- Plan beyond 3 days

---

## Example: Sprint 7A Planning Session

**CEO Agent workflow:**

```bash
# 1. Read current state
cat execution/README.md

# 2. Review roadmap
cat vision/FOUR_TIER_ARCHITECTURE.md

# 3. Create sprint doc
vim execution/sprints/sprint-7A-camera-scanner.md

# 4. Break down tasks
# - TASK-001: Camera input (Frontend, 4h)
# - TASK-002: Barcode detection (Backend, 6h)
# - TASK-003: Image preprocessing (Backend, 3h)
# - TASK-004: Integration (Integration, 3h)
# - TASK-005: Testing (Testing, 4h)

# 5. Create architecture diagram

# 6. Define success criteria

# 7. Update execution/README.md
# Current sprint: 7A

# 8. Commit sprint plan
git add execution/sprints/sprint-7A-camera-scanner.md
git commit -m "docs: Add Sprint 7A plan - Camera scanner"
```

---

## Metrics to Track

**Per Sprint:**
- Tasks completed vs planned
- Time estimated vs actual
- Bugs found vs fixed
- Test coverage added
- Skills documented

**Over Time:**
- Sprint velocity (tasks/day)
- Estimation accuracy
- Defect rate
- Agent efficiency
- Skill compounding effect

---

## Related

**Internal:**
- `execution/README.md` - Current sprint status
- `execution/sprints/` - Sprint history
- `vision/` - Long-term roadmap

**Skills:**
- `skills/agent-coordination/SKILL.md` - Multi-agent workflows
- `skills/documentation-workflow/SKILL.md` - Where to document
- `skills/git-workflow/SKILL.md` - How to commit

**Examples:**
- `execution/sprints/sprint-7A-camera-scanner.md` - Complete sprint plan

---

**Status:** 🟢 Active
**Last Updated:** October 18, 2025
