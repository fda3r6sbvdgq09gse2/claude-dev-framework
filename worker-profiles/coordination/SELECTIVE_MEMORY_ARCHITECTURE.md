# 🧠 Selective Memory Architecture (Advanced)

**Vision:** Workers don't load ALL patterns - they review an index and load only what's needed
**Benefit:** 6.7x token reduction (67k → 10k tokens)
**Analogy:** Library with card catalog - don't read all books, consult catalog first!

---

## 🎯 The Problem with Current System

**Current (Sprint 1-4):**
```
Worker loads:
- Profile: 3k tokens (full history)
- All 32 patterns: 64k tokens
- Total: 67k tokens (33% of 200k context!)

Problem: Most patterns irrelevant to current task!
```

**Example - Backend Worker Sprint 4:**
```
Task: Build SQLite database

Patterns loaded:
✓ ORM Patterns (needed!)
✗ API Fallback (not relevant)
✗ Image Processing (not relevant)
✗ CJK Fonts (not relevant)
✗ 28 other patterns (not relevant)

Result: 64k tokens, only 2k actually used!
```

---

## ✨ The Vision: Selective Memory Loading

### Core Concept

**Memory = Library**
- Patterns stored on disk (not in context)
- Lightweight index always loaded
- Worker selects relevant patterns
- Loads only those

**Worker = Librarian**
- Reviews task requirements
- Consults pattern index
- Fetches relevant patterns
- Combines them to solve task

**Agent = Intelligence**
- Glue that connects patterns
- Selects right memories
- Combines creatively
- Applies to current problem

---

## 🏗️ Architecture

### 1. Pattern Index (Lightweight Catalog)

**File:** `~/.claude-workers/[role]/pattern-index.md` (~3k tokens)

```markdown
# Backend Worker Pattern Index

## 1. ORM Patterns
**File:** patterns/orm-patterns.md
**When to use:** Database models, SQLAlchemy, relationships, foreign keys
**Tags:** #database #orm #sqlalchemy #models
**Size:** 2k tokens
**Used in:** Book Cataloger Sprint 4, Sprint 6
**Effectiveness:** ⭐⭐⭐⭐⭐

## 2. Three-Source API Fallback
**File:** patterns/three-source-api-fallback.md
**When to use:** Multi-source data fetching, fallback chains, resilience
**Tags:** #api #fallback #resilience #multi-source
**Size:** 2k tokens
**Used in:** Book Cataloger Sprint 3
**Effectiveness:** ⭐⭐⭐⭐⭐

## 3. Caching Strategies
**File:** patterns/caching-strategies.md
**When to use:** Performance optimization, local storage, memoization
**Tags:** #cache #performance #optimization
**Size:** 2k tokens
**Used in:** Book Cataloger Sprint 2
**Effectiveness:** ⭐⭐⭐⭐

## 4. Wikidata Query Pattern
**File:** patterns/wikidata-query.md
**When to use:** SPARQL queries, Wikidata API, structured data
**Tags:** #wikidata #sparql #api
**Size:** 2k tokens
**Used in:** Book Cataloger Sprint 3
**Effectiveness:** ⭐⭐⭐⭐⭐

... [28 more patterns]
```

**Index provides:**
- Pattern name & location
- When to use (task matching)
- Tags (semantic search)
- Size (token budget)
- Effectiveness rating

---

### 2. Smart Worker Startup (Pattern Selection)

**Old startup (loads everything):**
```
I'm the Backend Worker - Sprint 4.

Loading profile: @~/.claude-workers/backend/profile.md
Loading all patterns: @~/.claude-workers/backend/patterns/*.md

[67k tokens loaded, most irrelevant]
```

**New startup (selective loading):**
```
I'm the Backend Worker - Sprint 4.

Reading task: Build SQLite database with SQLAlchemy ORM
@.ai/SPRINT_4_TASKS.md

Reviewing pattern index:
@~/.claude-workers/backend/pattern-index.md

Pattern selection analysis:
┌────────────────────────────────┬──────────┬────────────┐
│ Pattern                        │ Relevant?│ Load?      │
├────────────────────────────────┼──────────┼────────────┤
│ ORM Patterns                   │ ✓✓✓      │ ✅ LOAD    │
│ Caching Strategies             │ ✓✓       │ ✅ LOAD    │
│ Three-Source API Fallback      │ ✗        │ ❌ Skip    │
│ Image Processing               │ ✗        │ ❌ Skip    │
│ CJK Font Support               │ ✗        │ ❌ Skip    │
│ Wikidata Query                 │ ✗        │ ❌ Skip    │
│ ... [26 more patterns]         │ ✗        │ ❌ Skip    │
└────────────────────────────────┴──────────┴────────────┘

Reasoning:
- ORM Patterns: Task requires SQLAlchemy models → HIGH relevance
- Caching Strategies: Database often needs caching → MEDIUM relevance
- API Fallback: Not doing API work → LOW relevance
- CJK Fonts: Not doing UI work → LOW relevance

Loading selected patterns (2 patterns):
@~/.claude-workers/backend/patterns/orm-patterns.md
@~/.claude-workers/backend/patterns/caching-strategies.md

Context loaded: 10k tokens (vs 67k with all patterns)
Token savings: 85% reduction!

Ready with focused, relevant knowledge! 🎯
```

---

### 3. Pattern as Modular LEGO Blocks

**Key principle:** Patterns should be **independent and composable**

**Bad pattern (too coupled):**
```markdown
# API + Database + UI Pattern

Use API to fetch data, save to database, display in UI...
[Mixed concerns, can't reuse components]
```

**Good patterns (modular):**
```markdown
# Pattern A: API Fallback Strategy
How to fetch from multiple sources with fallback
[Independent, reusable]

# Pattern B: Database Caching
How to cache database queries
[Independent, reusable]

# Pattern C: UI Data Binding
How to bind data to UI widgets
[Independent, reusable]
```

**Composing patterns:**
```
Task: Build feature that fetches data, caches it, and displays in UI

Worker selects:
1. API Fallback Strategy (fetch)
2. Database Caching (cache)
3. UI Data Binding (display)

Combines them:
fetch_data() [from Pattern A]
  → cache_result() [from Pattern B]
  → bind_to_ui() [from Pattern C]
```

---

## 🎮 Pattern Selection Algorithm

### How Worker Selects Patterns

**Input:**
- Task description
- Required skills
- Current sprint context

**Algorithm:**
```python
def select_patterns(task: str, pattern_index: List[Pattern]) -> List[Pattern]:
    """Select relevant patterns for task."""

    # 1. Extract task keywords
    keywords = extract_keywords(task)
    # ["SQLite", "database", "SQLAlchemy", "ORM", "models"]

    # 2. Score each pattern
    scored_patterns = []
    for pattern in pattern_index:
        score = 0

        # Match keywords
        for keyword in keywords:
            if keyword in pattern.tags:
                score += 3
            if keyword in pattern.when_to_use:
                score += 2

        # Effectiveness bonus
        score += pattern.effectiveness_stars

        scored_patterns.append((pattern, score))

    # 3. Sort by score
    scored_patterns.sort(key=lambda x: x[1], reverse=True)

    # 4. Select top N patterns (budget: 10k tokens)
    selected = []
    tokens_used = 0
    for pattern, score in scored_patterns:
        if score > 5 and tokens_used + pattern.size < 10000:
            selected.append(pattern)
            tokens_used += pattern.size

    return selected
```

**Result:**
- Top 2-5 patterns loaded
- Total: 4-10k tokens
- 85-90% token savings!

---

## 📊 Token Economics

### Before (Current System)

```
Worker Context:
├─ Profile: 3k tokens
├─ Pattern 1: 2k tokens
├─ Pattern 2: 2k tokens
├─ ...
├─ Pattern 32: 2k tokens
└─ Total: 67k tokens (33% of 200k context!)

Remaining for task: 133k tokens
```

### After (Selective Loading)

```
Worker Context:
├─ Profile summary: 1k tokens
├─ Pattern index: 3k tokens
├─ Selected pattern 1: 2k tokens
├─ Selected pattern 2: 2k tokens
├─ Selected pattern 3: 2k tokens
└─ Total: 10k tokens (5% of 200k context!)

Remaining for task: 190k tokens (43% more!)
```

**Impact:**
- 6.7x token reduction
- 43% more context for code
- Faster pattern loading
- Better focus

---

## 🎯 Pattern Structure (Modular Design)

### Pattern Template

```markdown
# Pattern Name

**ID:** backend-orm-patterns-001
**Version:** 1.0
**Tags:** #database #orm #sqlalchemy #models
**Size:** ~2k tokens

---

## When to Use

✅ Use this pattern when:
- Building database models
- Using SQLAlchemy ORM
- Defining relationships
- Need foreign keys

❌ Don't use when:
- Using raw SQL (use sql-queries pattern)
- NoSQL database (use nosql-patterns)
- Simple CSV (use csv-patterns)

---

## Prerequisites

**Knowledge needed:**
- Basic SQL concepts
- Python classes
- Foreign keys

**Patterns that work well with this:**
- Database Migration pattern
- Caching Strategy pattern

---

## The Pattern

[Core solution here - independent, self-contained]

---

## Example

[Concrete example]

---

## Testing

[How to test implementations]

---

## Composition

**Combines well with:**
- Caching Strategy → cache ORM queries
- Migration Pattern → evolve schema
- Validation Pattern → validate models

**Example composition:**
```python
# This pattern (ORM)
class Book(Base):
    ...

# + Caching Strategy
@cache_result(ttl=3600)
def get_book(isbn):
    return session.query(Book).filter_by(isbn=isbn).first()

# + Validation Pattern
class BookValidator:
    def validate(self, book: Book):
        ...
```

---

## Related Patterns

- `database-migration.md` - Evolving ORM schemas
- `query-optimization.md` - Fast ORM queries
- `relationship-patterns.md` - Advanced relationships
```

**Key features:**
- **Self-contained** - can be read alone
- **Tagged** - searchable
- **Composable** - shows how to combine
- **Sized** - knows token cost

---

## 🚀 Implementation Roadmap

### Phase 1: Index Creation (Sprint 5)
- Create pattern index for each worker
- Add tags, when-to-use, size
- Add effectiveness ratings

### Phase 2: Selective Loading (Sprint 6)
- Update worker startup to review index
- Implement pattern selection algorithm
- Load only relevant patterns

### Phase 3: Composition System (Sprint 7)
- Document pattern combinations
- Add composition examples
- Create pattern stacking guides

### Phase 4: Semantic Search (Sprint 8+)
- Vector embeddings for patterns
- Semantic similarity search
- AI-assisted pattern selection

---

## 📈 Benefits

### Token Efficiency
- Current: 67k tokens for patterns
- Selective: 10k tokens for patterns
- **Savings: 85% reduction (6.7x)**

### Focus
- Worker loads only relevant knowledge
- Less distraction from irrelevant patterns
- Better task alignment

### Scalability
- Can have 100+ patterns without context bloat
- Worker selects 2-5 patterns per task
- Linear growth vs quadratic

### Intelligence
- Worker demonstrates reasoning
- Pattern selection shows understanding
- Explains why patterns chosen

---

## 🎭 Theater Analogy (Extended)

**Old system:**
```
Actor memorizes entire library before each play
- Memorizes 32 books (patterns)
- Most books irrelevant to current play
- Exhausting, inefficient
```

**New system:**
```
Actor reviews script, consults index, learns relevant scenes
- Script says "database scene"
- Actor checks index: "ORM patterns needed"
- Learns only ORM patterns (2k tokens)
- Performs scene expertly
- Next scene: different patterns
```

**The agent is the director:**
- Reads the script (task)
- Selects relevant material (patterns)
- Guides the actor (worker)
- Combines creatively

---

## 💡 Key Insight

**The agent/worker is the INTELLIGENCE that:**
1. Understands the task
2. Reviews the pattern catalog (index)
3. Identifies relevant patterns
4. Loads only those
5. Combines them creatively
6. Applies to solve the problem

**Patterns are LEGO blocks:**
- Independent modules
- Well-defined interfaces
- Stackable/composable
- Reusable across projects

**The worker has "rails" (core understanding):**
- Programming fundamentals
- Domain knowledge
- Problem-solving skills

**Patterns "slot into the rails":**
- Worker has understanding
- Patterns provide specific techniques
- Combination creates expertise

---

## 🎯 Success Criteria

### Sprint 5+ Goals

**Pattern Index:**
- [ ] All workers have pattern index
- [ ] Tags and metadata complete
- [ ] Token sizes accurate

**Selective Loading:**
- [ ] Workers review index before loading
- [ ] Pattern selection reasoning shown
- [ ] Only 2-5 patterns loaded per task

**Token Savings:**
- [ ] 85%+ reduction in pattern tokens
- [ ] Context capacity increased 43%
- [ ] No loss in pattern utility

**Modularity:**
- [ ] All patterns independent
- [ ] Composition examples documented
- [ ] Pattern stacking working

---

**This is the future of worker memory!** 🚀

**Current system (Sprint 1-4): Load everything**
**Future system (Sprint 5+): Load what's needed**

**Result:** Smarter, faster, more efficient workers!
