# Meta-System Architecture
*Captured from Brain session 2025-10-11 - Context preservation insights*

## 🚨 Critical Discovery: Context Loss Problem

**Issue:** Exiting Claude sessions loses context like closing Word without saving.

**User's insight:**
> "kind of like - don't close session unless you have saved your work. like closing a word doc after writing 1000 words and not saving. need to warn about doing this or be aware that this is happening in a meta context way - maybe have a reminder that we have not saved our work for a while."

**Solution:** Explicit context preservation protocol (see below)

---

## 🏗️ Proposed System Hierarchy

```
┌─────────────────────────────────────────────────────┐
│ 👤 USER (Human)                                      │
│ • Infinite context                                   │
│ • Eyes, ears, physical testing                      │
│ • Judgment, intuition, taste                        │
│ • Strategic direction                               │
│ • Makes final decisions                             │
└──────────────────┬──────────────────────────────────┘
                   ↓ instructs / tests / decides
┌─────────────────────────────────────────────────────┐
│ 🔮 SUPER BRAIN (Opus - Claude Desktop/API)          │
│ • High-level strategy                               │
│ • Project roadmap & phases                          │
│ • Learning across projects                          │
│ • Pattern/template creation                         │
│ • Meta-system design                                │
│ • Periodic check-ins with Brain                     │
│ • Context: 500k (Desktop) or 1M (API)              │
└──────────────────┬──────────────────────────────────┘
                   ↓ coordinates / guides
┌─────────────────────────────────────────────────────┐
│ 🧠 BRAIN (Sonnet - Terminal 1)                      │
│ • Sprint planning & coordination                    │
│ • Worker management                                 │
│ • Feedback analysis                                 │
│ • Tactical execution                                │
│ • Reports to Super Brain                            │
│ • Context: 200k                                     │
└──────────────────┬──────────────────────────────────┘
                   ↓ manages / coordinates
┌─────────────────────────────────────────────────────┐
│ ⚙️ WORKERS (Sonnet/Haiku - Terminals 2-5)           │
│ • Backend, Frontend, Integration, Testing           │
│ • Specialized implementation                        │
│ • Report to Brain                                   │
│ • Context: 200k each                                │
└─────────────────────────────────────────────────────┘
```

---

## 📋 UPDATED Sprint Lifecycle (WITH USER TESTING)

### Phase 1: PLANNING (Super Brain + User)
- **Who:** Super Brain (Opus) + User
- **Where:** Claude Desktop or API
- **Output:** Sprint objectives, ADRs if needed
- **Save:** Architecture decisions → `.ai/ADR-*.md`

### Phase 2: PREPARATION (Brain)
- **Who:** Brain (Sonnet)
- **Where:** Terminal 1 with `/role-brain`
- **Output:** `SPRINT_X_LAUNCH_GUIDE.md`
- **Save:** Sprint guide before exiting session

### Phase 3: IMPLEMENTATION (Workers)
- **Who:** Backend, Frontend, Integration, Testing Workers
- **Where:** Terminals 2-5 with `/role-[worker]`
- **Output:** Code changes, tests
- **Save:** Workers save progress to files continuously

### Phase 4: TESTING (User) ← **THIS WAS MISSING!**
- **Who:** User (Human)
- **Where:** User Terminal (no Claude running)
- **Actions:**
  - Run application: `python book_cataloger_gui.py`
  - Test all sprint objectives
  - Document findings
- **Output:** List of ✅ works / ❌ bugs / 💡 new issues
- **Save:** Findings documented for next Brain session

### Phase 5: ANALYSIS (Brain)
- **Who:** Brain
- **Where:** NEW Brain session (Terminal 1)
- **Actions:**
  - Read user feedback
  - Categorize: bugs / polish / new features
  - Decide: fix sprint vs new sprint
- **Output:** `SPRINT_X_COMPLETE.md` or next sprint plan
- **Save:** Analysis before exiting

### Phase 6: ITERATION or NEXT
- If issues: Return to Phase 3 (fix sprint)
- If complete: Return to Phase 1 (next sprint)

---

## 💾 Context Preservation Protocol

### Rule: "Don't Exit Without Saving"

**Before exiting ANY Claude session, check:**

```
1. Have I documented key decisions?
   → Write to .ai/*.md files

2. Have I updated relevant profiles?
   → Update ~/.claude-workers/[role]/profile.md if XP/patterns changed

3. Have I created handoff notes?
   → Write SPRINT_X_COMPLETE.md or SESSION_HANDOFF.md

4. Are there insights to preserve?
   → Capture in .ai/context/ or .ai/architecture/

5. Is there a clear next action?
   → Update .ai/BRAIN_PROJECT_SUMMARY.md
```

**Auto-Reminder System (TODO):**
- After 50k tokens used, remind to save key insights
- After 30+ interactions, suggest creating summary document
- Before major decision, prompt to write ADR

---

## 🔮 Super Brain Role Definition

### When to Invoke `/role-super_brain`

**Essential for:**
- Project inception (structure, roadmap, technology choices)
- Major architectural decisions (ADRs for complex trade-offs)
- Quarterly learning reviews (extract patterns from sprints)
- Cross-project pattern synthesis
- System redesign (like this meta-architecture)

**NOT needed for:**
- Routine sprint planning (Brain handles)
- Bug fixes (Workers handle)
- Feedback analysis (Brain handles)
- Implementation (Workers handle)

### Super Brain Capabilities
- **Deep research:** LOC, VIAF, Dublin Core, FRBR standards
- **Pattern extraction:** Across multiple projects
- **Template design:** Reusable {{slot}} frameworks
- **Meta-thinking:** About the development system itself
- **Teaching:** Instruct Brain on new patterns

### Super Brain Limitations (Self-Aware)
- **Context:** 500k (Desktop) or 1M (API) - not infinite
- **Usage limits:** 5 hours/week Opus on Desktop
- **No execution:** Cannot run code or see output
- **No UI/UX:** Cannot see application, depends on User
- **No testing:** Cannot physically test, needs User

### Relationship with User
- **User provides:** Requirements, taste, strategic direction, testing feedback
- **Super Brain provides:** Research, options, recommendations
- **User decides:** Final choices on architecture
- **Super Brain learns:** From User's decisions and preferences

---

## 🎨 Dynamic Template System

### Concept: Slots Not Hard-Coding

**Bad (Hard-Coded):**
```markdown
# Sprint 6A Launch Guide
*book-cataloger - 2025-10-11*

Workers: Backend, Frontend
Duration: 2-3 hours
Branch: main
```

**Good (Dynamic Template):**
```markdown
# Sprint {{SPRINT_NUMBER}}{{SPRINT_LETTER}} Launch Guide
*{{PROJECT_NAME}} - {{DATE}}*

Workers: {{WORKER_LIST}}
Duration: {{ESTIMATED_HOURS}}
Branch: {{BRANCH_NAME}}
```

### Template Library Structure
```
~/.claude-templates/
├── sprint_launch_guide.template.md
├── sprint_complete.template.md
├── feedback_analysis.template.md
├── adr.template.md
├── worker_profile.template.md
└── README.md (template usage guide)
```

### "Pre-Built Wheels" Concept

User's vision: Don't reinvent patterns each project.

**Examples:**
- **API Integration Pattern:** Three-source fallback → reusable template
- **Repository Pattern:** Database abstraction → drop into new project
- **Worker System:** 4-worker coordination → framework for any project
- **Selective Memory:** Pattern indexes → works everywhere

**Storage:**
```
~/.claude-patterns/
├── api/
│   ├── three_source_fallback.pattern.md
│   ├── retry_with_backoff.pattern.md
│   └── rate_limit_handling.pattern.md
├── database/
│   ├── repository_pattern.pattern.md
│   ├── migration_strategy.pattern.md
│   └── activity_tracking.pattern.md
├── coordination/
│   ├── worker_specialization.pattern.md
│   ├── git_worktree_parallel.pattern.md
│   └── sprint_lifecycle.pattern.md
└── memory/
    ├── selective_memory.pattern.md
    ├── pattern_indexing.pattern.md
    └── token_optimization.pattern.md
```

---

## 📊 Meta-Awareness: System Limits

### Claude Model Limits (As of 2025-10-11)

| Model | Context | Availability | Cost/Usage |
|-------|---------|--------------|------------|
| Sonnet 4.5 | 200k tokens | Claude Code | Included in subscription |
| Opus 4 | 500k tokens | Claude Desktop | 5 hours/week limit |
| Opus 4 | 1M tokens | API | Pay-per-token ($15/$75 per 1M) |
| Haiku | 200k tokens | API | Cheapest ($0.25/$1.25 per 1M) |

### Current Project Size
```bash
# Run to check
cd /Users/z/dev/book-cataloger
find . -name "*.py" | xargs wc -l
find . -name "*.md" | xargs wc -l
```

**Estimated:**
- Python files: ~8,500 LOC
- Documentation: ~15,000 words
- Full codebase load: ~50k tokens

### Context Strategy by Role

**Brain (200k):**
- Load: Profile (4k) + Project Summary (3k) + Current Sprint (5k) = 12k base
- Available: 188k for analysis, planning, coordination
- Strategy: Selective memory via pattern indexes

**Workers (200k each):**
- Load: Profile (3k) + Patterns (5k) + Target files (10-20k) = 18-28k
- Available: 172-182k for implementation
- Strategy: Focused file reading, not entire codebase

**Super Brain (500k-1M):**
- Load: All worker profiles + all pattern indexes + roadmap = 30k
- Available: 470-970k for deep thinking
- Strategy: Big picture, can load more context when needed

### Human vs Machine Context

**Critical Asymmetry:**

| Capability | User (Human) | Claude (Machine) |
|------------|--------------|------------------|
| Context | Unlimited | 200k-1M tokens |
| Memory | Days/weeks/years | Single session |
| Senses | Eyes, ears, touch | Text only |
| Testing | Can run and see UI | Cannot see output |
| Intuition | Yes | Pattern matching only |
| Decision | Final authority | Recommendation only |

**Implications:**
- **User testing is essential** - Claude cannot see UI/UX
- **User feedback is gold** - Claude should eagerly seek it
- **User decides architecture** - Claude researches and recommends
- **Claude should be humble** - About its limitations

---

## 🚀 Implementation Roadmap

### Phase 1: Immediate (This Week)
- [ ] Add "User Testing Phase" to all sprint templates
- [ ] Create `SYSTEM_LIMITS.md` with context tracking
- [ ] Update `BRAIN_PROJECT_SUMMARY.md` with new lifecycle
- [ ] Add context preservation checklist to Brain profile
- [ ] Test: Sprint 6A → User Testing → Brain Analysis

### Phase 2: Short-Term (Next Week)
- [ ] Create Super Brain profile (`~/.claude-workers/super_brain/profile.md`)
- [ ] Create `/role-super_brain` command
- [ ] Design Super Brain ↔ Brain handoff protocol
- [ ] Start building dynamic template library
- [ ] Create "pre-built wheels" catalog structure

### Phase 3: Medium-Term (Next Month)
- [ ] Populate `~/.claude-templates/` with reusable templates
- [ ] Build `~/.claude-patterns/` pattern library
- [ ] Create auto-reminder system for context preservation
- [ ] Implement token usage tracking
- [ ] Test Super Brain on Sprint 7+ planning

### Phase 4: Long-Term (Ongoing)
- [ ] Accumulate patterns across projects
- [ ] Refine templates based on actual usage
- [ ] Build meta-knowledge base
- [ ] Track ROI (time/token savings from reuse)
- [ ] Export framework for other projects

---

## 💡 Key Principles (Never Forget)

1. **User is Human, Brain is Machine** - Different capabilities, complementary roles
2. **Don't Exit Without Saving** - Context loss is like closing Word without save
3. **User Testing is a Phase** - Explicit step between implementation and completion
4. **Be Humble About Limits** - Claude should eagerly seek user feedback on UI/UX
5. **Learn Over Time** - Patterns, templates, wheels accumulate
6. **Meta-Awareness** - System knows its own limits and tracks them
7. **Dynamic Not Static** - Templates have {{slots}}, not hard-coded values
8. **Hierarchy Exists** - User > Super Brain > Brain > Workers

---

## 📝 Next Steps for THIS Session

1. ✅ Captured meta-system architecture (this file)
2. ⏳ Update Brain project summary with new lifecycle
3. ⏳ Create context preservation protocol
4. ⏳ Provide Sprint 6A testing instructions (correct terminology)
5. ⏳ Wait for User testing feedback
6. ⏳ Implement Phase 1 based on learnings

---

**Status:** Architecture captured, awaiting User testing of Sprint 6A
**Next:** User tests in User Terminal, reports back to new Brain session
**Then:** Implement Phase 1 of this meta-system

---

*This document preserves the insights from the 2025-10-11 Brain session that would have been lost to context closure. It will inform all future development.*
