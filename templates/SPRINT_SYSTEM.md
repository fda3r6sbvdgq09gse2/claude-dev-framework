# Sprint System
*Dynamic Sprint Management for Claude Multi-Agent Framework*
*Version: 2.0.0 - Integrated with Turn-Based Model*

---

## 🎯 Overview

The Sprint System coordinates **multi-agent development cycles** with **human-in-the-loop feedback**, integrating seamlessly with the turn-based interaction model.

**Key Principle**: Each sprint is a series of turns between humans and AI agents, with structured handoffs and feedback loops.

---

## 📊 Sprint Lifecycle

### The Complete Cycle

```
┌──────────────────────────────────────────────────────────────┐
│  STAGE 1: Planning (Human + CEO)                             │
│  • User provides sprint goals                                │
│  • CEO breaks down into agent tasks                          │
│  • Tasks assigned to agents                                  │
│  • Success criteria defined                                  │
│  Duration: 30-60 min                                         │
└──────────────────────────────────────────────────────────────┘
              ↓
┌──────────────────────────────────────────────────────────────┐
│  STAGE 2: Execution (Agents Working)                         │
│  • Agents work in parallel (via worktrees)                   │
│  • Each agent has multiple turns                             │
│  • Context managed per agent                                 │
│  • Regular commits to feature branches                       │
│  Duration: 2-8 hours (varies by sprint)                      │
└──────────────────────────────────────────────────────────────┘
              ↓
┌──────────────────────────────────────────────────────────────┐
│  STAGE 3: Integration (DevOps + Testing)                     │
│  • Merge feature branches to main                            │
│  • Run full test suite                                       │
│  • Resolve conflicts                                         │
│  • Deploy to test environment                                │
│  Duration: 30-60 min                                         │
└──────────────────────────────────────────────────────────────┘
              ↓
┌──────────────────────────────────────────────────────────────┐
│  STAGE 4: User Testing (Human Turn)                          │
│  • User tests integrated system                              │
│  • User captures bugs (jam.dev)                              │
│  • User documents feedback                                   │
│  • User decides: fix bugs or continue                        │
│  Duration: 30-120 min                                        │
└──────────────────────────────────────────────────────────────┘
              ↓
┌──────────────────────────────────────────────────────────────┐
│  STAGE 5: Feedback & Retrospective (Human + UX/Product)      │
│  • What worked well?                                         │
│  • What needs improvement?                                   │
│  • Critical bugs to fix?                                     │
│  • Features for next sprint?                                 │
│  Duration: 15-30 min                                         │
└──────────────────────────────────────────────────────────────┘
              ↓
    ┌─────────────────┐
    │  Bug Fix Needed?│
    └─────────────────┘
        │         │
      Yes        No
        │         │
        ↓         ↓
    Bug Fix   Next Sprint
    Sprint    (back to Stage 1)
```

---

## 📋 Sprint Stages (Detailed)

### Stage 1: Planning

**Participants**: Human (Creator) + CEO Agent

**Human Turn** (Planning Input):
```markdown
**Sprint Goal**: [What we're building]

**Priority Features**:
1. [Feature 1] - [Why it matters]
2. [Feature 2] - [Why it matters]
3. [Feature 3] - [Why it matters]

**Constraints**:
- Time: [hours available]
- Budget: [token/cost limit]
- Dependencies: [what must work first]

**Success Criteria**:
- [Measurable outcome 1]
- [Measurable outcome 2]
```

**AI Turn** (CEO - Task Decomposition):
```markdown
CEO Analysis:

Sprint: [Number][Letter] - [Name]
Duration Estimate: [X-Y hours] parallel

**Task Breakdown**:

Backend Agent:
- Task 1: [description] (2h, 50 XP)
- Task 2: [description] (1.5h, 35 XP)

Frontend Agent:
- Task 1: [description] (3h, 60 XP)
- Task 2: [description] (1h, 25 XP)

Integration Agent:
- Task 1: [description] (2h, 45 XP)

Testing Agent:
- Task 1: [description] (2h, 40 XP)
- Task 2: [description] (1h, 20 XP)

**Dependencies**:
- Frontend Task 1 → Backend Task 1
- Integration → Backend + Frontend complete

**Deliverables**:
- [Deliverable 1]
- [Deliverable 2]

═══════════════════════════════════════
YOUR TURN:

Approve this plan?
- Yes: "Launch sprint"
- Modify: "Change [specific aspect]"
- Postpone: "Not ready, because [reason]"
═══════════════════════════════════════
```

**Handoff**: Human approves → Move to Stage 2

---

### Stage 2: Execution

**Parallel Agent Work** (Multiple Terminals/Worktrees):

**Terminal 1 - Backend Agent**:
```bash
# Human turn: Launch agent
cd book-cataloger-backend
claude
/role-backend

# AI turns (multiple):
Turn 1: Read existing code, plan implementation
Turn 2: Implement feature part 1
Turn 3: Write tests
Turn 4: Implement feature part 2
Turn 5: Final testing, commit

# Each turn includes:
- Context check
- Focused file loading
- Implementation
- Testing
- Handoff with status
```

**Terminal 2 - Frontend Agent**:
```bash
cd book-cataloger-frontend
claude
/role-frontend

# Multiple AI turns for UI implementation
```

**Terminal 3 - Integration Agent** (starts after dependencies):
```bash
cd book-cataloger-integration
claude
/role-integration

# Coordinates backend + frontend
```

**Terminal 4 - Testing Agent**:
```bash
cd book-cataloger
claude
/role-testing

# Writes tests as others complete features
```

**Key Rules During Execution**:
1. ✅ Each agent commits to feature branch
2. ✅ Context checked every turn
3. ✅ Agent exits when task complete
4. ✅ Human reviews output before continuing
5. ✅ No agent works beyond their domain

**Handoff**: All agents complete → Move to Stage 3

---

### Stage 3: Integration

**Participants**: DevOps Agent + Testing Agent + Human

**DevOps Turn** (Merge & Deploy):
```bash
/role-devops

Tasks:
1. Review all feature branches
2. Check for conflicts
3. Merge to main sequentially:
   - feature/backend → main
   - feature/frontend → main
   - feature/integration → main
4. Run full test suite
5. Tag release (e.g., sprint-6B)
6. Deploy to test environment

Deliverable:
- All branches merged ✅
- Tests passing: [X/Y] ✅
- Deployed to: [environment]

═══════════════════════════════════════
YOUR TURN:

Test the integrated system:
1. Run: [start command]
2. Test: [key workflows]
3. Report results
═══════════════════════════════════════
```

**Handoff**: Integration complete → Move to Stage 4

---

### Stage 4: User Testing

**Human Turn** (Critical Testing Phase):

```markdown
## User Testing - Sprint [X]

**Date**: [date]
**Duration**: [time spent]

### Test Environment
- Branch: main (post-merge)
- Version: sprint-[X]
- Command: [how to run]

### Features Tested

#### Feature 1: [Name]
- Test: [What was tested]
- Result: ✅ PASS / ❌ FAIL
- Notes: [observations]
- jam.dev: [link if bug found]

#### Feature 2: [Name]
- Test: [What was tested]
- Result: ✅ PASS / ⚠️ PARTIAL
- Notes: [observations]

### Bugs Found

🔴 **Critical**:
1. [Bug description]
   - jam.dev: [link]
   - Impact: [blocks usage]

🟡 **Important**:
1. [Bug description]
   - jam.dev: [link]
   - Impact: [degraded experience]

🟢 **Minor**:
1. [Bug description]
   - Impact: [cosmetic]

### What Worked Well
- [Positive feedback 1]
- [Positive feedback 2]

### What Needs Improvement
- [Issue 1]
- [Issue 2]

### Decision

Choose one:
[ ] Fix critical bugs → Bug Fix Sprint
[ ] Bugs are minor → Continue to retrospective
[ ] Major issues → Rollback and redesign
```

**Handoff Decision**:
- Critical bugs → Launch Bug Fix Sprint (mini sprint)
- No critical bugs → Move to Stage 5

---

### Stage 5: Retrospective & Next Planning

**Participants**: Human + UX/Product Agent + CEO Agent

**UX/Product Agent Turn** (Synthesize Feedback):
```markdown
## Sprint [X] Feedback Synthesis

### User Satisfaction
- Overall: [rating/10]
- Feature usefulness: [rating/10]
- UX quality: [rating/10]

### Feature Performance
Feature 1: ⭐⭐⭐⭐⭐ (loved it!)
Feature 2: ⭐⭐⭐⭐ (good, minor issues)
Feature 3: ⭐⭐ (needs work)

### Pain Points Identified
1. [User friction point]
2. [Confusing aspect]
3. [Performance issue]

### Feature Requests
🔥 High Priority:
1. [User requested feature]
2. [User requested feature]

🟡 Medium Priority:
1. [User requested feature]

### Recommended Next Steps
Based on feedback:
1. [Recommendation 1]
2. [Recommendation 2]
```

**CEO Agent Turn** (Strategic Planning):
```markdown
## Sprint [X] Retrospective

### What Went Well
- [Success 1]
- [Success 2]
- Agent performance: [summary]

### What Needs Improvement
- [Area 1]
- [Area 2]
- Process improvements: [recommendations]

### Agent Performance

Backend: +[XP], now Level [N]
  Skills improved: [list]

Frontend: +[XP], now Level [N]
  Skills improved: [list]

Integration: +[XP], now Level [N]
  Skills improved: [list]

Testing: +[XP], now Level [N]
  Skills improved: [list]

### Next Sprint Recommendations

**Priority 1** (Critical):
- [Must-have feature/fix]

**Priority 2** (Important):
- [Should-have feature]

**Priority 3** (Nice-to-have):
- [Could-have feature]

**Estimated Effort**:
- [X-Y hours] parallel
- [Z agent-hours] total

═══════════════════════════════════════
YOUR TURN:

Ready to plan next sprint?
- Yes: "Plan Sprint [X+1]"
- No: "Let's wait, because [reason]"
- Different priority: "Actually, let's focus on [X]"
═══════════════════════════════════════
```

**Handoff**: Human approves → Back to Stage 1 for next sprint

---

## 🔄 Special Sprint Types

### 1. Bug Fix Sprint (Mini Sprint)

**Trigger**: Critical bugs found in Stage 4

**Characteristics**:
- Duration: 30-120 minutes
- Single agent usually
- No planning phase (bugs already defined)
- Fast integration
- Immediate user testing

**Process**:
```
1. Human: Document bug (jam.dev + description)
2. Triage: Assign to agent (Backend/Frontend/Integration)
3. Agent: Fix bug (single turn or few turns)
4. Testing Agent: Verify fix
5. Human: Test fix
6. If fixed: Merge to main
7. If not fixed: Another turn
```

---

### 2. Research Sprint

**Trigger**: New technology or approach needed

**Characteristics**:
- CEO (Opus) + specialized agent
- Plan Mode for research
- No code written
- Deliverable: Decision document

**Example**:
```
Goal: "Should we use Playwright or Selenium for UI testing?"

CEO (Plan Mode):
- Research both options
- Compare pros/cons
- Recommend approach
- Document decision rationale

Deliverable: .ai/decisions/ui-testing-framework.md
```

---

### 3. Refactoring Sprint

**Trigger**: Tech debt accumulation

**Characteristics**:
- Backend or Integration lead
- Testing Agent heavily involved
- No new features
- Success = all tests still pass

**Example**:
```
Goal: "Refactor authentication module"

Backend Agent:
- Restructure code
- Improve maintainability
- Keep all existing functionality

Testing Agent:
- Ensure all tests pass
- Add regression tests
- Verify no breaking changes
```

---

## 📊 Sprint Metrics

### Track Per Sprint

```yaml
Sprint: 6B
Date: 2025-01-15
Duration: 4.5 hours parallel (18 agent-hours total)

Agents Involved: 4
  - Backend
  - Frontend
  - Integration
  - Testing

Features Delivered: 3
  - Feature 1 ✅
  - Feature 2 ✅
  - Feature 3 ✅

Tests Added: 24
Test Coverage: 87% → 91% (+4%)
Bugs Introduced: 0
Bugs Fixed: 2

Cost:
  Total: $4.25
  Per agent:
    Backend: $1.50
    Frontend: $1.25
    Integration: $1.00
    Testing: $0.50

Context Management:
  Refreshes needed: 2
  Peak context: 68%
  Average context: 42%

XP Earned:
  Backend: +65 XP (Level 2 → 385/500)
  Frontend: +75 XP (Level 2 → 340/500)
  Integration: +55 XP (Level 2 → 295/500)
  Testing: +40 XP (Level 1 → 180/250)

User Satisfaction: 9/10
Sprint Success: ✅ Complete
```

---

## 📝 Sprint Documentation Files

### Required Files Per Sprint

```
.ai/sprints/sprint-[X]/
├── plan.md                   # Stage 1: Planning output
├── assignments.md            # Agent task assignments
├── execution-log.md          # Stage 2: Turn-by-turn log
├── integration-results.md    # Stage 3: Merge & test results
├── user-testing.md           # Stage 4: User test results
├── retrospective.md          # Stage 5: Feedback & learnings
└── metrics.yaml              # Sprint metrics
```

### Continuous Documentation

```
.ai/current_sprint.md         # Current sprint status
.ai/turn_log.md              # Detailed turn tracking
.ai/context/current_task.md  # Active tasks per agent
```

---

## 🎯 Sprint Templates

### Use These Templates

1. **Planning**: `.../templates/sprint/01-planning-template.md`
2. **Execution**: `.../templates/sprint/02-execution-template.md`
3. **Integration**: `.../templates/sprint/03-integration-template.md`
4. **User Testing**: `.../templates/sprint/04-user-testing-template.md`
5. **Retrospective**: `.../templates/sprint/05-retrospective-template.md`

---

## ✅ Sprint Quality Checklist

### Before Starting Sprint
- [ ] Clear sprint goal defined
- [ ] Success criteria measurable
- [ ] Agent assignments clear
- [ ] Dependencies identified
- [ ] Estimated effort reasonable

### During Sprint
- [ ] Each agent checks context regularly
- [ ] Commits made incrementally
- [ ] Tests written alongside features
- [ ] Agents stay in their domains
- [ ] Turn handoffs are clear

### Before Integration
- [ ] All agent tasks complete
- [ ] Feature branches pushed
- [ ] Individual tests passing
- [ ] No obvious conflicts

### Before User Testing
- [ ] Branches merged cleanly
- [ ] Full test suite passing
- [ ] Deployed to test environment
- [ ] Test instructions provided

### After User Testing
- [ ] Feedback documented
- [ ] Bugs categorized (critical/important/minor)
- [ ] jam.dev captures attached
- [ ] Decision made (fix/continue/rollback)

### During Retrospective
- [ ] What worked well documented
- [ ] Improvements identified
- [ ] Agent XP updated
- [ ] Next sprint priorities set

---

## 🔗 Integration with Framework

### With Turn-Based Model
- Each stage is a series of turns
- Clear handoffs between stages
- Context managed per stage

### With Agents
- Agents activated via `/role-*` commands
- Each agent has dedicated worktree
- Agents work in parallel

### With Hooks
- `session-start.sh`: Initialize sprint context
- `track-agent.sh`: Log agent activity
- `cost-alert.sh`: Monitor sprint budget

### With Memory
- Sprint plan in `CLAUDE.md`
- Current tasks in `.ai/context/`
- Patterns referenced, not loaded

### With Statusline
- Shows current agent
- Shows sprint cost
- Shows sprint progress

---

## 📚 Resources

**Templates**:
- `templates/SPRINT_LAUNCH_GUIDE_TEMPLATE.md`
- `templates/SPRINT_COMPLETE_TEMPLATE.md`
- `templates/sprint/` (individual stage templates)

**Documentation**:
- [Turn-Based Interaction](../../docs/TURN_BASED_INTERACTION.md)
- [Context Optimization](../../docs/CONTEXT_OPTIMIZATION.md)
- [Agent Employment Model](../../docs/AGENT_EMPLOYMENT_MODEL.md)

**Scripts**:
- `scripts/start-sprint.sh` (coming soon)
- `scripts/complete-sprint.sh` (coming soon)

---

**Version**: 2.0.0
**Last Updated**: 2025-01-15
**Status**: Integrated with turn-based model and all framework systems
