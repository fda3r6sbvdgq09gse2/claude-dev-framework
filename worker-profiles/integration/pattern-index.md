# Integration Worker - Pattern Index

**Purpose:** Lightweight catalog of all patterns (load this first, then select relevant patterns)
**Size:** ~4k tokens (vs 72k for all patterns)
**Usage:** Review task → Select 2-5 relevant patterns → Load only those

---

## Pattern Library (12 patterns - Largest collection!)

### 1. Multi-Signal Confidence Scoring
**File:** `patterns/multi-signal-confidence-scoring.md`
**Size:** ~3k tokens
**When to use:** Classification with incomplete data, translation detection, weak signal combination
**Tags:** #ml #classification #confidence #signal-fusion #translation
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (fixed Art of War & Seneca detection)
**Key concept:** Combine multiple weak signals (0.3-0.4 each) into strong decision (>0.5)
**Combines with:** Script detection, author origin detection

### 2. Language Registry Singleton
**File:** `patterns/language-registry-singleton.md`
**Size:** ~2.5k tokens
**When to use:** Global registry, thread-safe singleton, language data
**Tags:** #singleton #registry #thread-safe #languages #patterns
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (39 languages)
**Key concept:** Double-checked locking, variant codes (zh-CN, zh-TW), romanization detection
**Combines with:** Language formatting, translation detection

### 3. Unicode Script Detection
**File:** `patterns/unicode-script-detection.md`
**Size:** ~2k tokens
**When to use:** Text script identification, multilingual support, romanization
**Tags:** #unicode #script #hanzi #cyrillic #arabic #detection
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (ScriptDetector utility)
**Key concept:** unicodedata.name() parsing, dominant script (>50% chars)
**Combines with:** Romanization, translation detection

### 4. Transform Layer Design
**File:** `patterns/transform-layer-design.md`
**Size:** ~2.5k tokens
**When to use:** Data model conversion, DB ↔ Domain model, serialization
**Tags:** #transform #serialization #db #domain-model #mapping
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (BookMetadata ↔ DB Book)
**Key concept:** Bidirectional transforms, JSON serialization for complex fields
**Combines with:** Repository pattern, validation

### 5. Repository Pattern
**File:** `patterns/repository-pattern.md`
**Size:** ~2k tokens
**When to use:** Database abstraction, clean API layer, ORM wrapping
**Tags:** #repository #database #abstraction #clean-api
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (DatabaseManager)
**Key concept:** Workflow → Manager → Models, session management
**Combines with:** Transform layer, ORM patterns

### 6. Place Deduplication
**File:** `patterns/place-deduplication.md`
**Size:** ~1.5k tokens
**When to use:** Entity deduplication, get-or-create pattern, normalized storage
**Tags:** #deduplication #normalization #entity #get-or-create
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (PlaceRegistry)
**Key concept:** get_or_create(name, city) prevents "Edinburgh" duplication
**Combines with:** Repository pattern, activity tracking

### 7. Activity Lifecycle Tracking
**File:** `patterns/activity-lifecycle-tracking.md`
**Size:** ~2k tokens
**When to use:** Event tracking, timeline queries, book journey
**Tags:** #events #lifecycle #timeline #history #tracking
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (ActivityTracker)
**Key concept:** purchase → read → lend event chain, chronological queries
**Combines with:** Place deduplication, repository pattern

### 8. CJK Romanization
**File:** `patterns/cjk-romanization.md`
**Size:** ~1.5k tokens
**When to use:** Chinese/Japanese/Korean to Latin conversion, search support
**Tags:** #cjk #romanization #unidecode #conversion
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 3 (Romanizer utility)
**Key concept:** unidecode library with graceful fallback, 孙子兵法 → Sun Tzu Bing Fa
**Combines with:** Script detection, translation detection

### 9. Author Origin Detection
**File:** `patterns/author-origin-detection.md`
**Size:** ~2k tokens
**When to use:** Cultural inference, translation detection, author analysis
**Tags:** #author #origin #cultural #inference #surnames
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 3 (Chinese surnames, classical authors)
**Key concept:** Sun Tzu → Chinese, Seneca → Latin, confidence scoring
**Combines with:** Multi-signal scoring, translation detection

### 10. Workflow Orchestration
**File:** `patterns/workflow-orchestration.md`
**Size:** ~2k tokens
**When to use:** Multi-step processes, service coordination, error boundaries
**Tags:** #workflow #orchestration #coordination #error-handling
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 2, Sprint 4 (EnrichmentWorkflow)
**Key concept:** High-level coordination, doesn't implement (delegates to services)
**Combines with:** Repository pattern, transform layer

### 11. Language Formatting
**File:** `patterns/language-formatting.md`
**Size:** ~2k tokens
**When to use:** Language-specific formatting, author names, display
**Tags:** #formatting #language #author-names #display
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 1 (LanguageFormatter)
**Key concept:** FAMILYNAME, FirstName for CJK/Hungarian, romanization display
**Combines with:** Language registry, script detection

### 12. Catalog Database (CSV)
**File:** `patterns/catalog-database-csv.md`
**Size:** ~2k tokens
**When to use:** Simple CSV storage, prototyping, small datasets
**Tags:** #csv #database #simple #storage
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 1-3 (before SQLite)
**Key concept:** UTF-8-sig, thread-safe, edit history, < 10k rows
**Combines with:** Migration patterns, validation

---

## Pattern Selection Guide

### For Translation Detection Tasks
**Load:** Multi-Signal Confidence Scoring, Script Detection, Author Origin Detection
**Skip:** Database patterns, workflow patterns

### For Database Integration Tasks
**Load:** Repository Pattern, Transform Layer Design, Place Deduplication
**Skip:** Translation patterns, formatting patterns

### For Activity Tracking Tasks
**Load:** Activity Lifecycle Tracking, Place Deduplication, Repository Pattern
**Skip:** Translation patterns, script detection

### For Multilingual Data Tasks
**Load:** Language Registry, Unicode Script Detection, CJK Romanization, Language Formatting
**Skip:** Database patterns, activity patterns

### For Workflow Design Tasks
**Load:** Workflow Orchestration, Repository Pattern, Transform Layer
**Skip:** Script detection, formatting patterns

---

## Pattern Composition Examples

### Example 1: Translation Detection Pipeline
```
Task: Detect if book is translation

Select patterns:
1. Multi-Signal Confidence Scoring (main algorithm)
2. Author Origin Detection (author name heuristics)
3. Script Detection (original script inference)

Combine:
signals = []
signals.append(author_origin()) [Pattern 2]
signals.append(script_mismatch()) [Pattern 3]
is_translation = score_signals(signals) [Pattern 1]
```

### Example 2: Database Integration
```
Task: Integrate enrichment with SQLite database

Select patterns:
1. Repository Pattern (database API)
2. Transform Layer Design (BookMetadata ↔ DB)
3. Workflow Orchestration (high-level flow)

Combine:
workflow [Pattern 3]
  → transform_to_db() [Pattern 2]
  → repository.save() [Pattern 1]
```

### Example 3: Activity Tracking System
```
Task: Build activity tracking for books

Select patterns:
1. Activity Lifecycle Tracking (event system)
2. Place Deduplication (reusable places)
3. Repository Pattern (database access)

Combine:
place = deduplicate_place() [Pattern 2]
  → activity = create_activity(place) [Pattern 1]
  → repository.save(activity) [Pattern 3]
```

---

## Selection Algorithm

**Keywords → Patterns mapping:**
- "translation", "detect", "confidence" → Multi-Signal Scoring
- "database", "repository", "CRUD" → Repository Pattern
- "transform", "convert", "map" → Transform Layer
- "script", "unicode", "Hanzi" → Script Detection
- "romanization", "CJK", "pinyin" → CJK Romanization
- "activity", "tracking", "timeline" → Activity Lifecycle
- "place", "deduplicate", "reuse" → Place Deduplication
- "workflow", "orchestrate", "coordinate" → Workflow Orchestration
- "language", "registry", "singleton" → Language Registry
- "author", "origin", "surname" → Author Origin Detection
- "format", "display", "author-name" → Language Formatting
- "CSV", "simple", "storage" → Catalog Database

---

## Token Budget

**Integration Worker has most patterns (12) but selective loading keeps it efficient:**
- Small task (1-2 patterns): ~3-4k tokens
- Medium task (3-4 patterns): ~7-9k tokens
- Large task (5-6 patterns): ~12-15k tokens

**Total library: 25k tokens (all 12 patterns)**
**Selective loading: 70-85% token savings**

---

## Pattern Dependencies

**Core patterns (load frequently):**
- Repository Pattern (database access)
- Transform Layer (data conversion)
- Workflow Orchestration (high-level coordination)

**Specialized patterns (load as needed):**
- Translation detection cluster (Multi-Signal, Author Origin, Script)
- Multilingual cluster (Language Registry, Formatting, Romanization)
- Activity tracking cluster (Lifecycle, Place Deduplication)

---

## Maintenance

**Add new patterns:**
1. Create pattern file
2. Add to index with tags
3. Document combinations
4. Update effectiveness after 2-3 uses

**Pattern evolution:**
- Simple → Complex as requirements grow
- Independent → Composable over time
- Document composition patterns

---

**Last updated:** Sprint 4 (2025-10-10)
**Total patterns:** 12 (largest collection!)
**Next:** Advanced query patterns (Sprint 5+)
