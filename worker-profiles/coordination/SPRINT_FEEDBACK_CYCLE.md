# Sprint Feedback Cycle

**Purpose:** Structured workflow for sprint completion → user testing → feedback → next sprint

## The Cycle

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  1. Worker Sprint (Parallel)                           │
│     • All 4 workers complete tasks                     │
│     • Code written, tests passing                       │
│     • Workers update profiles & patterns                │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  2. User Testing (Integration)                         │
│     • Merge sprint branches                            │
│     • Run integration tests                            │
│     • Try features hands-on                            │
│     • Note what works, what breaks                     │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  3. User Feedback (Critical)                           │
│     • What features worked well?                       │
│     • What needs fixing?                               │
│     • What features to build next?                     │
│     • Strategic direction                              │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  4. Strategize (Brain + Opus if needed)                │
│     • Brain: Architecture decisions                    │
│     • Brain: Task decomposition                        │
│     • Opus: Complex strategy (if needed)               │
│     • Plan next sprint                                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
       │
       └──► Back to step 1 (next sprint)
```

## Why This Matters

### Without Feedback Cycle ❌
- Workers build features user doesn't need
- Bugs compound across sprints
- Strategic direction drifts
- Wasted XP on wrong patterns

### With Feedback Cycle ✅
- User-driven feature priority
- Bugs caught early (cheaper to fix)
- Strategic alignment maintained
- Workers learn from real usage

## Current Status (Post-Sprint 4)

### Sprint 4 Completed ✅
- Backend: SQLite database foundation (480 XP)
- Integration: Activity tracking system (510 XP, Level 3!)
- Frontend: Purchase tracking UI (420 XP)
- Testing: 87% coverage, 3 bugs found (350 XP)

### Next Step: **User Testing Phase** 🧪

**User should:**
1. Merge Sprint 4 branches
2. Run the application
3. Test:
   - Book enrichment to SQLite (not CSV)
   - Purchase tracking dialog
   - Activity history view
   - Place deduplication
4. Provide feedback:
   - Does enrichment work?
   - Is purchase dialog intuitive?
   - Any crashes or errors?
   - What features matter most?

### Then: **Strategize Sprint 5** 🧠

**Brain should:**
1. Review user feedback
2. Prioritize fixes vs features
3. Decompose into worker tasks
4. Estimate XP rewards

**Opus (if needed) for:**
- Major architectural changes
- Performance optimization strategy
- New technology integration

## Testing Checklist Template

After each sprint, user should test:

```markdown
### Sprint X Testing Results

**Date:** [date]
**Branch:** main (post-merge)

#### Features Tested
- [ ] Feature 1: [pass/fail] - [notes]
- [ ] Feature 2: [pass/fail] - [notes]
- [ ] Feature 3: [pass/fail] - [notes]

#### Bugs Found
1. [Description] - [severity: critical/major/minor]
2. ...

#### User Feedback
**What worked well:**
- [feature/aspect]
- ...

**What needs improvement:**
- [feature/aspect]
- ...

**Feature requests for next sprint:**
1. [feature] - [priority: high/medium/low]
2. ...

#### Strategic Direction
[Any high-level guidance for next sprint]
```

## Sprint 5 Planning - BLOCKED

**Status:** ⏸️ Waiting for user testing feedback on Sprint 4

**DO NOT plan Sprint 5 until:**
1. User merges Sprint 4
2. User tests integrated system
3. User provides feedback
4. User explicitly requests Sprint 5 planning

**This prevents:**
- Building wrong features
- Compounding bugs
- Wasting worker XP
- Context thrash

## Integration with CLAUDE.md Workflow

This aligns with existing workflow in `/Users/z/dev/book-cataloger/CLAUDE.md`:

1. **User tests** (outside Claude Code)
2. **User runs** `python .ai/scripts/start_session.py` (records feedback)
3. **Claude reads** feedback at session start
4. **Claude fixes** issues, continues work

**Key difference:** Parallel system needs feedback BETWEEN sprints, not just within a sprint.

## Updated Sprint Cycle

### Old (incorrect):
```
Sprint 3 complete → Auto-plan Sprint 4 → Launch workers
Sprint 4 complete → Auto-plan Sprint 5 → Launch workers  ❌
```

### New (correct):
```
Sprint 3 complete → User tests → User feedback → Brain strategizes → Plan Sprint 4 → Launch workers
Sprint 4 complete → User tests → User feedback → Brain strategizes → Plan Sprint 5 → Launch workers  ✅
```

## Communication Template

**When workers finish sprint:**
```
🎉 Sprint X Complete!

All 4 workers finished:
- Backend: [achievement] (+XP)
- Integration: [achievement] (+XP)
- Frontend: [achievement] (+XP)
- Testing: [achievement] (+XP)

🧪 NEXT STEP: User Testing Required

Please:
1. Merge Sprint X branches
2. Test the integrated system
3. Provide feedback:
   - What works well?
   - What breaks?
   - What to build next?

Then we'll strategize Sprint X+1 together!
```

## Example: Sprint 4 → 5 Transition

### Current State (Sprint 4 Complete)
- Workers finished ✅
- Selective memory implemented ✅
- Pattern indexes created ✅

### Required Before Sprint 5
- [ ] User merges Sprint 4 branches
- [ ] User tests:
  - [ ] Book enrichment → SQLite
  - [ ] Purchase tracking dialog
  - [ ] Activity history
  - [ ] Place deduplication
- [ ] User provides feedback
- [ ] Brain + User strategize Sprint 5

### Only Then
- Plan Sprint 5 tasks
- Launch workers

---

**Last updated:** Sprint 4 completion (2025-10-10)
**Status:** Feedback cycle integrated into coordination system
**Next:** Wait for user testing feedback before Sprint 5
