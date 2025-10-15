# Brain Worker - Pattern Index

**Purpose:** Coordination and architecture patterns for any software project
**Size:** ~5k tokens (vs 36k for all patterns)
**Usage:** Brain reviews task → Selects relevant patterns → Loads only those
**Specialization:** Cross-project applicable patterns (not domain-specific)

---

## Pattern Library (12 patterns)

### 1. Parallel Task Decomposition
**File:** `patterns/parallel-task-decomposition.md`
**Size:** ~3k tokens
**When to use:** Complex feature requires multiple components, parallel development
**Tags:** #coordination #parallel #task-decomposition #workers
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** All sprints (core coordination pattern)
**Key concept:** Break complex work into independent worker tasks, minimize dependencies
**Combines with:** Git worktree architecture, Worker XP balancing
**Cross-project:** ✅ Works for any multi-component software project

### 2. Git Worktree Architecture
**File:** `patterns/git-worktree-architecture.md`
**Size:** ~2.5k tokens
**When to use:** Parallel development, multiple feature branches, context preservation
**Tags:** #git #worktree #parallel #isolation #context
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (foundation), used in all sprints
**Key concept:** 1 repo, 5 directories (main + 4 workers), zero context loss on switching
**Combines with:** Parallel task decomposition, Merge conflict resolution
**Cross-project:** ✅ Standard git feature, universally applicable

### 3. Selective Memory Architecture
**File:** `patterns/selective-memory-architecture.md`
**Size:** ~3.5k tokens
**When to use:** Pattern library > 10 patterns, context budget constraints
**Tags:** #context #memory #optimization #tokens #patterns
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (80% token savings)
**Key concept:** Pattern index (catalog) + keyword selection + selective loading
**Combines with:** Pattern index design, Token budgeting
**Cross-project:** ✅ Essential for any AI-assisted project with pattern library

### 4. Feedback Cycle Integration
**File:** `patterns/feedback-cycle-integration.md`
**Size:** ~2.5k tokens
**When to use:** Multi-sprint projects, user-facing features, strategic alignment
**Tags:** #feedback #testing #cycle #user #strategy
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (workflow formalization)
**Key concept:** Sprint → User Testing → Feedback → Strategize → Next Sprint
**Combines with:** Sprint planning, User workflow patterns
**Cross-project:** ✅ Critical for any user-facing software development

### 5. Worker XP Balancing
**File:** `patterns/worker-xp-balancing.md`
**Size:** ~2k tokens
**When to use:** Multi-sprint projects, worker specialization, skill tracking
**Tags:** #xp #leveling #balance #motivation #workers
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 2-4 (XP distribution)
**Key concept:** Balance task complexity so workers level at similar rates
**Combines with:** Parallel task decomposition, Sprint planning
**Cross-project:** ✅ Gamification works for any parallel development system

### 6. Merge Conflict Resolution
**File:** `patterns/merge-conflict-resolution.md`
**Size:** ~2k tokens
**When to use:** Merging parallel feature branches, overlapping code changes
**Tags:** #git #merge #conflicts #resolution #strategy
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3-4 (branch merging)
**Key concept:** Understand context, choose correct implementation (production vs stub)
**Combines with:** Git worktree architecture, Parallel task decomposition
**Cross-project:** ✅ Universal git workflow pattern

### 7. Sprint Planning with Token Budgets
**File:** `patterns/sprint-planning-token-budgets.md`
**Size:** ~2.5k tokens
**When to use:** Multi-agent projects, context budget constraints
**Tags:** #planning #tokens #budget #context #sprint
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** All sprints (resource allocation)
**Key concept:** 200k tokens split across 5 agents, balance context usage
**Combines with:** Selective memory, Task decomposition
**Cross-project:** ✅ Essential for any AI-assisted development with context limits

### 8. Pattern Index Design
**File:** `patterns/pattern-index-design.md`
**Size:** ~3k tokens
**When to use:** Pattern library > 5 patterns, need fast pattern discovery
**Tags:** #patterns #index #catalog #search #metadata
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (selective memory foundation)
**Key concept:** Lightweight catalog with tags, size, effectiveness, when-to-use
**Combines with:** Selective memory architecture
**Cross-project:** ✅ Library pattern applicable everywhere

### 9. Architecture Decision Records
**File:** `patterns/architecture-decision-records.md`
**Size:** ~2k tokens
**When to use:** Major technology choices, design decisions, trade-off analysis
**Tags:** #architecture #decisions #documentation #trade-offs
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (SQLAlchemy), Sprint 4 (normalized database)
**Key concept:** Document decision, context, alternatives, consequences
**Combines with:** System design patterns
**Cross-project:** ✅ Best practice for any software project

### 10. Test Coverage Strategy
**File:** `patterns/test-coverage-strategy.md`
**Size:** ~2.5k tokens
**When to use:** Quality targets, test planning, bug prevention
**Tags:** #testing #coverage #quality #targets #strategy
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (87% coverage achieved)
**Key concept:** 85%+ for critical modules, use coverage to reveal bugs
**Combines with:** Bug hunting, Integration testing
**Cross-project:** ✅ Universal testing best practice

### 11. API Interface Design
**File:** `patterns/api-interface-design.md`
**Size:** ~2.5k tokens
**When to use:** Component boundaries, service interfaces, backward compatibility
**Tags:** #api #interface #design #clean #abstraction
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 2 (Repository), Sprint 4 (ActivityTracker)
**Key concept:** Clean interfaces, backward compatibility, version management
**Combines with:** Repository pattern, Transform layer
**Cross-project:** ✅ Essential design principle for any system

### 12. Database Migration Strategy
**File:** `patterns/database-migration-strategy.md`
**Size:** ~2.5k tokens
**When to use:** Database schema changes, storage evolution, data migration
**Tags:** #database #migration #schema #evolution #data
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (CSV → SQLite)
**Key concept:** Repository pattern enables clean migrations, test thoroughly
**Combines with:** Repository pattern, Test coverage strategy
**Cross-project:** ✅ Every evolving system needs migration patterns

---

## Pattern Selection Guide

### For Coordination Tasks
**Load:** Parallel Task Decomposition, Worker XP Balancing, Sprint Planning
**Skip:** Architecture patterns, Migration patterns

### For Architecture Tasks
**Load:** Architecture Decision Records, API Interface Design, Database Migration
**Skip:** Coordination patterns, Git patterns

### For Context Optimization Tasks
**Load:** Selective Memory Architecture, Pattern Index Design, Sprint Planning with Token Budgets
**Skip:** Git patterns, Migration patterns

### For Sprint Management Tasks
**Load:** Feedback Cycle Integration, Sprint Planning with Token Budgets, Worker XP Balancing
**Skip:** Database patterns, API patterns

### For Integration Tasks
**Load:** Merge Conflict Resolution, Git Worktree Architecture, Feedback Cycle
**Skip:** Architecture patterns (unless conflicts involve architecture)

---

## Pattern Composition Examples

### Example 1: Starting a New Sprint
```
Task: Plan Sprint 5 with user feedback

Select patterns:
1. Feedback Cycle Integration (read user feedback)
2. Sprint Planning with Token Budgets (allocate resources)
3. Parallel Task Decomposition (break into worker tasks)
4. Worker XP Balancing (distribute XP fairly)

Combine:
read_user_feedback() [Pattern 1]
  → estimate_token_budgets() [Pattern 2]
  → decompose_tasks_for_workers() [Pattern 3]
  → balance_xp_rewards() [Pattern 4]
```

### Example 2: Merging Sprint Branches
```
Task: Merge 4 feature branches to main

Select patterns:
1. Git Worktree Architecture (understand structure)
2. Merge Conflict Resolution (handle conflicts)
3. Test Coverage Strategy (verify quality post-merge)

Combine:
merge_sequential() [Pattern 1]
  → resolve_conflicts() [Pattern 2]
  → run_tests_verify_coverage() [Pattern 3]
```

### Example 3: Growing Pattern Library
```
Task: Pattern library reached 35 patterns, context bloat

Select patterns:
1. Selective Memory Architecture (solution design)
2. Pattern Index Design (catalog creation)
3. Sprint Planning with Token Budgets (measure savings)

Combine:
design_selective_memory() [Pattern 1]
  → create_pattern_indexes() [Pattern 2]
  → measure_token_savings() [Pattern 3]
```

### Example 4: Architecture Decision
```
Task: Choose between CSV and SQLite for storage

Select patterns:
1. Architecture Decision Records (document decision)
2. Database Migration Strategy (plan migration path)
3. Test Coverage Strategy (ensure quality)

Combine:
analyze_alternatives() [Pattern 1]
  → document_decision() [Pattern 1]
  → plan_migration() [Pattern 2]
  → define_test_coverage() [Pattern 3]
```

---

## Selection Algorithm

**Keywords → Patterns mapping:**
- "sprint", "plan", "tasks" → Sprint Planning, Parallel Task Decomposition
- "feedback", "testing", "user" → Feedback Cycle Integration
- "merge", "conflict", "branches" → Merge Conflict Resolution, Git Worktree
- "memory", "context", "tokens" → Selective Memory, Pattern Index, Token Budgets
- "architecture", "design", "decision" → Architecture Decision Records, API Interface Design
- "xp", "balance", "workers" → Worker XP Balancing
- "database", "migration", "schema" → Database Migration Strategy
- "coverage", "quality", "tests" → Test Coverage Strategy
- "patterns", "index", "catalog" → Pattern Index Design

---

## Token Budget

**Brain patterns are strategic (12 total, some large):**
- Small task (1-2 patterns): ~3-5k tokens
- Medium task (3-4 patterns): ~8-10k tokens
- Large task (5-6 patterns): ~14-18k tokens

**Total library: 30k tokens (all 12 patterns)**
**Selective loading: 80% token savings**

---

## Pattern Dependencies

**Core coordination patterns (load frequently):**
- Parallel Task Decomposition (every sprint)
- Sprint Planning with Token Budgets (every sprint)
- Feedback Cycle Integration (between sprints)

**Git patterns (merge operations):**
- Git Worktree Architecture (setup, explanation)
- Merge Conflict Resolution (sprint merges)

**Context optimization patterns (as needed):**
- Selective Memory Architecture (pattern library growth)
- Pattern Index Design (catalog creation)

**Architecture patterns (major decisions):**
- Architecture Decision Records (technology choices)
- API Interface Design (component boundaries)
- Database Migration Strategy (storage evolution)

**Quality patterns (testing focus):**
- Test Coverage Strategy (quality targets)

**Meta patterns (system management):**
- Worker XP Balancing (fairness)

---

## Cross-Project Applicability

### ✅ Universal Patterns (Work for ANY project)
1. **Selective Memory Architecture** - AI context optimization
2. **Parallel Task Decomposition** - Breaking down complex work
3. **Git Worktree Architecture** - Parallel development
4. **Feedback Cycle Integration** - User-driven development
5. **Worker XP Balancing** - Skill tracking and motivation
6. **Merge Conflict Resolution** - Git workflow
7. **Sprint Planning with Token Budgets** - Resource allocation
8. **Pattern Index Design** - Knowledge organization
9. **Architecture Decision Records** - Design documentation
10. **Test Coverage Strategy** - Quality assurance
11. **API Interface Design** - Component architecture
12. **Database Migration Strategy** - Data evolution

### 🔄 Adaptation Required (Domain-specific patterns in worker libraries)
- Translation detection patterns (Integration worker)
- CJK font patterns (Frontend worker)
- ISBN scanning patterns (Backend worker)
- Database testing patterns (Testing worker - partially reusable)

### 🎯 Brain Specialization
**Brain patterns are COORDINATION and ARCHITECTURE patterns**
- Not implementation patterns (workers own those)
- Not domain-specific patterns (workers own those)
- Focus on system design and team management
- 100% cross-project reusable

---

## Pattern Evolution

### Sprint 1-2 (Foundation)
- Git Worktree Architecture established
- Parallel Task Decomposition refined
- Worker XP Balancing introduced

### Sprint 3 (Optimization)
- Merge Conflict Resolution proven
- Architecture Decision Records formalized

### Sprint 4 (Meta-Learning)
- Selective Memory Architecture created (80% savings!)
- Pattern Index Design implemented
- Feedback Cycle Integration formalized

### Sprint 5+ (Expansion)
- Performance optimization patterns (planned)
- Deployment automation patterns (planned)
- Cross-project pattern library (planned)
- Multi-project pattern reuse (planned)

---

## Maintenance

### Add New Patterns
1. Experience pattern across 2+ sprints
2. Document in `patterns/` directory
3. Add to this index with metadata
4. Tag for searchability
5. Note cross-project applicability

### Update Existing Patterns
1. Track effectiveness across sprints
2. Update ⭐ rating after 3+ uses
3. Document new combinations
4. Add "Used in" projects

### Deprecate Patterns
1. If pattern consistently ineffective (⭐⭐ or less)
2. If better pattern supersedes it
3. Move to `patterns/deprecated/`
4. Document why deprecated

---

## Token Economics

### Before Selective Memory (Sprint 3)
- **Brain patterns:** ~30k tokens (if all loaded)
- **Worker patterns:** ~69k tokens (all 4 workers)
- **Total:** ~99k tokens (50% of context!)
- **Code space:** ~101k tokens

### After Selective Memory (Sprint 4)
- **Brain patterns:** ~5k tokens (index + 2-3 patterns)
- **Worker patterns:** ~10k tokens (4 indexes + selective loading)
- **Total:** ~15k tokens (7.5% of context)
- **Code space:** ~185k tokens (+84%)

**Impact:** 85% reduction in pattern overhead, 84% more context for code!

---

## Brain vs Worker Patterns

### Brain Owns
- **Coordination:** How to manage workers
- **Architecture:** System design decisions
- **Strategy:** Sprint planning, feedback cycles
- **Context:** Token budgets, selective memory
- **Cross-project:** Universally applicable patterns

### Workers Own
- **Implementation:** How to code specific features
- **Domain:** Translation detection, ISBN scanning
- **Technology:** SQLAlchemy usage, PyQt6 widgets
- **Testing:** Unit tests, integration tests
- **Project-specific:** Book cataloger patterns

### Synergy
- Brain coordinates → Workers implement
- Brain designs architecture → Workers build components
- Brain plans sprints → Workers complete tasks
- Brain optimizes context → Workers write more code
- Brain extracts patterns → Workers reuse patterns

---

## Next-Level Patterns (Sprint 5+)

### Performance Optimization
- Async API calls pattern
- Caching strategy pattern
- Query optimization pattern
- Memory profiling pattern

### Deployment Automation
- CI/CD pipeline pattern
- Package building pattern
- Distribution pattern
- Update mechanism pattern

### Scaling Patterns
- Multi-user database pattern
- Concurrent access pattern
- Transaction handling pattern
- Backup and restore pattern

### Cross-Project Patterns
- Pattern generalization process
- Pattern library transfer
- Project bootstrapping pattern
- Worker onboarding pattern

---

**Last updated:** Sprint 4 completion (2025-10-10)
**Total patterns:** 12 (100% cross-project applicable!)
**Token savings:** 85% vs loading all patterns
**Brain level:** 3 (Advanced)
**Next:** Apply to new project to validate cross-project reusability

---

*"Brain patterns coordinate. Worker patterns implement. Together, they build world-class software."*
