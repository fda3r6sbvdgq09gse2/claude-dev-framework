# Brain's Sprint Templates
*World-class sprint lifecycle framework*

## 📚 Template Overview

Brain uses these templates to maintain consistency and quality across sprints.

### Template Types

1. **SPRINT_LAUNCH_GUIDE_TEMPLATE.md** - Starting a sprint
   - Worker assignments with absolute paths
   - Detailed task breakdowns
   - Success criteria
   - Timeline projections
   - XP calculations

2. **SPRINT_COMPLETE_TEMPLATE.md** - Finishing a sprint
   - Deliverable tracking
   - Test results
   - XP awards
   - Learning capture
   - User testing status

3. **FEEDBACK_ANALYSIS_TEMPLATE.md** - Post-testing analysis
   - Issue categorization (bugs/polish/architecture)
   - World-class best practice research
   - Sprint split recommendations
   - ADR identification

4. **ADR_TEMPLATE.md** - Architecture decisions
   - Options analysis
   - Industry standard research
   - Trade-off evaluation
   - Implementation plan
   - Success metrics

---

## 🎯 When to Use Each Template

### Launch Guide
**Use when:** User approves a sprint plan and it's time to launch workers

**Process:**
1. Copy template to `.ai/SPRINT_[N][L]_LAUNCH_GUIDE.md`
2. Fill in all sections
3. Provide worker prompts with absolute paths
4. User launches workers

### Complete Report
**Use when:** All workers finish their tasks

**Process:**
1. Copy template to `.ai/SPRINT_[N][L]_COMPLETE.md`
2. Document what was delivered
3. Calculate XP awards
4. Capture learnings
5. Request user testing

### Feedback Analysis
**Use when:** User tests and reports issues/feedback

**Process:**
1. Copy template to `.ai/SPRINT_[N]_FEEDBACK_ANALYSIS.md`
2. Categorize all issues
3. Research best practices for complex items
4. Recommend sprint split if needed
5. Propose next steps

### ADR
**Use when:** Major architectural decision needs documentation

**Process:**
1. Copy template to `.ai/adr/ADR-[XXX]_[topic].md`
2. Research industry standards
3. Analyze options with trade-offs
4. Make recommendation
5. Get user approval

---

## 📋 Template Usage Best Practices

### Always Use Absolute Paths
```
✅ @/Users/z/.claude-workers/backend profile.md
❌ @~/.claude-workers/backend profile.md
❌ @backend/profile.md
```

### Be Specific with Estimates
```
✅ "15-30 minutes"
✅ "2-2.5 hours"
❌ "A while"
❌ "Not long"
```

### Research Before Recommending
```
✅ "Library of Congress uses format X, VIAF uses Y, we'll use X because..."
❌ "I think we should do X"
```

### Break Down Complex Sprints
```
✅ Sprint 6A (2-3 hours) + Sprint 6B (5-6 hours)
❌ Sprint 6 (7-9 hours, too long!)
```

---

## 🎮 XP Calculation Guidelines

**Base XP:**
- Sprint participation: +20
- Per task completed: +25
- Per new skill learned: +10
- Pattern created: +10
- Pattern reused: +5

**Bonuses:**
- Critical path: +20
- Integration success: +15
- Speed bonus (under estimate): +5
- Mastery achievement: +10
- Level up: +0 (but celebrate!)

**Example:**
```
Backend Worker - Sprint 6A:
- Sprint: +20
- 1 task (MOLIERE fix): +25
- Speed bonus (15 min vs 30 est): +5
Total: +50 XP
```

---

## 🏆 Success Criteria Standards

**Every sprint should define:**

### Worker-Level Success
- ✅ Specific file created/modified
- ✅ Test count (N+ tests passing)
- ✅ Manual verification (with exact steps)

### Sprint-Level Success
- ✅ All worker tasks complete
- ✅ No regressions
- ✅ User testing checklist items

### Quality Standards
- Test coverage: Maintain 85%+
- No critical bugs introduced
- Documentation updated
- Patterns documented (if new)

---

## 📊 World-Class Sprint Workflow

```
User Tests → Feedback → Brain Analyzes → Sprint Plan → Launch Workers
                 ↓                           ↓              ↓
           FEEDBACK_ANALYSIS         LAUNCH_GUIDE    Workers Execute
                 ↓                                          ↓
           ADRs (if needed)                          COMPLETE Report
                 ↓                                          ↓
           Sprint Plan(s)                            User Tests
                                                           ↓
                                                       (repeat)
```

---

## 🔄 Template Evolution

**These templates should evolve based on:**
- What worked well in past sprints
- User feedback on documentation quality
- Worker feedback on clarity
- New patterns discovered

**To update a template:**
1. Identify improvement opportunity
2. Update template with learning
3. Document why change was made
4. Apply to next sprint

---

## 📚 Related Documents

**Brain's Identity:**
- `/Users/z/dev/book-cataloger/.claude/commands/role-brain md` - Slash command
- `/Users/z/.claude-workers/brain profile.md` - XP, skills, history
- `/Users/z/.claude-workers/brain RESTART_PROTOCOL.md` - How to reload

**Worker Profiles:**
- `/Users/z/.claude-workers/backend profile.md`
- `/Users/z/.claude-workers/integration profile.md`
- `/Users/z/.claude-workers/frontend profile.md`
- `/Users/z/.claude-workers/testing profile.md`

**Pattern Libraries:**
- `/Users/z/.claude-workers/[worker]/patterns/` - Individual patterns
- `/Users/z/.claude-workers/brain pattern-index.md` - Master catalog

---

## 💡 Template Customization

**For your project:**
These templates are designed for book-cataloger but can be adapted:
- Change file paths
- Adjust XP scales
- Modify success criteria
- Add project-specific sections

**Keep the structure:**
- Clear objectives
- Detailed breakdowns
- Absolute paths
- Success metrics
- Learning capture

---

**Templates Version:** 1.0
**Last Updated:** 2025-10-10
**Maintained By:** Brain Worker
