# Testing Worker - Pattern Index

**Purpose:** Lightweight catalog of all patterns (load this first, then select relevant patterns)
**Size:** ~3k tokens (vs 64k for all patterns)
**Usage:** Review task → Select 2-5 relevant patterns → Load only those

---

## Pattern Library (8 patterns)

### 1. Field Coverage Validation
**File:** `patterns/field-coverage-validation.md`
**Size:** ~2.5k tokens
**When to use:** Quality measurement, enrichment validation, coverage targets
**Tags:** #validation #coverage #quality #metrics #bronze-silver-gold
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (world-class enrichment validation)
**Key concept:** Bronze (60%), Silver (75%), Gold (90%) coverage tiers
**Combines with:** World-class validation, integration testing

### 2. Database Unit Testing
**File:** `patterns/database-unit-testing.md`
**Size:** ~2k tokens
**When to use:** SQLite testing, CRUD validation, relationship testing
**Tags:** #database #sqlite #crud #relationships #in-memory
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (19 database tests, 87% coverage)
**Key concept:** In-memory database, fixture patterns, relationship validation
**Combines with:** Integration testing, bug hunting

### 3. pytest Marker Organization
**File:** `patterns/pytest-marker-organization.md`
**Size:** ~1.5k tokens
**When to use:** Test organization, slow/fast separation, CI/CD
**Tags:** #pytest #markers #organization #slow #integration
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (pytest.ini configuration)
**Key concept:** @pytest.mark.slow, @pytest.mark.integration, selective execution
**Combines with:** Field coverage, integration testing

### 4. Stub-First Development
**File:** `patterns/stub-first-development.md`
**Size:** ~1.5k tokens
**When to use:** Testing before implementation, unblocking team, interface design
**Tags:** #stub #test-first #interface #unblock
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 3 (WikidataAPI stub)
**Key concept:** Define interface → Write tests → Stub implementation → Real implementation
**Combines with:** Integration testing, API testing

### 5. World-Class Validation
**File:** `patterns/world-class-validation.md`
**Size:** ~2k tokens
**When to use:** Real ISBN testing, production quality validation, benchmark testing
**Tags:** #validation #real-data #benchmark #isbn #production
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (Art of War, Seneca validation)
**Key concept:** Test with real ISBNs, compare to BOOKS2.ods standards
**Combines with:** Field coverage, integration testing

### 6. Integration Workflow Testing
**File:** `patterns/integration-workflow-testing.md`
**Size:** ~2k tokens
**When to use:** End-to-end testing, multi-component validation, workflow testing
**Tags:** #integration #workflow #end-to-end #multi-component
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (translation workflow), Sprint 4 (catalog integration)
**Key concept:** Complete workflow from start to finish, all components together
**Combines with:** Field coverage, world-class validation

### 7. Language Registry Testing
**File:** `patterns/language-registry-testing.md`
**Size:** ~1.5k tokens
**When to use:** Singleton testing, registry validation, language data
**Tags:** #singleton #registry #language #thread-safe
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (16 tests, 100% coverage)
**Key concept:** Singleton pattern testing, variant codes, romanization detection
**Combines with:** Integration workflow testing

### 8. Bug Hunting Patterns
**File:** `patterns/bug-hunting-patterns.md`
**Size:** ~2k tokens
**When to use:** Finding bugs during testing, edge case discovery, field mapping
**Tags:** #bugs #edge-cases #field-mapping #quality
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 4 (found 3 critical bugs)
**Key concept:** Comprehensive tests reveal bugs, test-driven debugging
**Combines with:** Database testing, integration testing

---

## Pattern Selection Guide

### For Database Testing Tasks
**Load:** Database Unit Testing, Bug Hunting, pytest Markers
**Skip:** Stub patterns, world-class validation

### For Quality Validation Tasks
**Load:** Field Coverage Validation, World-Class Validation, Integration Workflow
**Skip:** Database patterns, stub patterns

### For Test Organization Tasks
**Load:** pytest Marker Organization, Integration Workflow
**Skip:** Bug hunting, coverage patterns

### For Stub/Interface Tasks
**Load:** Stub-First Development, Integration Workflow
**Skip:** Database patterns, coverage patterns

---

## Pattern Composition Examples

### Example 1: Comprehensive Database Testing
```
Task: Test SQLite database operations

Select patterns:
1. Database Unit Testing (CRUD tests)
2. Bug Hunting (find field mapping issues)
3. pytest Markers (organize fast/slow tests)

Combine:
test_crud_operations() [Pattern 1]
  → find_field_mapping_bugs() [Pattern 2]
  → mark_as_integration() [Pattern 3]
```

### Example 2: Quality Validation Suite
```
Task: Validate enrichment meets world-class standards

Select patterns:
1. Field Coverage Validation (measure completeness)
2. World-Class Validation (real ISBN testing)
3. Integration Workflow (end-to-end)

Combine:
test_real_isbn() [Pattern 2]
  → calculate_coverage() [Pattern 1]
  → test_full_workflow() [Pattern 3]
```

### Example 3: Stub-First Development
```
Task: Create tests before API implementation

Select patterns:
1. Stub-First Development (interface design)
2. Integration Workflow (end-to-end planning)
3. pytest Markers (mark as pending)

Combine:
define_interface() [Pattern 1]
  → write_integration_tests() [Pattern 2]
  → mark_as_skip(reason="API not implemented") [Pattern 3]
```

---

## Selection Algorithm

**Keywords → Patterns mapping:**
- "database", "SQLite", "CRUD", "relationships" → Database Unit Testing
- "coverage", "quality", "validation", "percentage" → Field Coverage
- "real", "ISBN", "world-class", "benchmark" → World-Class Validation
- "marker", "organize", "slow", "fast" → pytest Markers
- "stub", "interface", "before implementation" → Stub-First Development
- "integration", "workflow", "end-to-end" → Integration Workflow
- "bug", "edge-case", "field-mapping" → Bug Hunting
- "singleton", "registry", "language" → Language Registry Testing

---

## Token Budget

**Testing Worker patterns are focused (8 total):**
- Small task (1-2 patterns): ~2-4k tokens
- Medium task (3 patterns): ~5-7k tokens
- Large task (4-5 patterns): ~9-12k tokens

**Total library: 15k tokens (all 8 patterns)**
**Selective loading: 85% token savings**

---

## Pattern Dependencies

**Core testing patterns (load frequently):**
- Database Unit Testing (Sprint 4+)
- Integration Workflow (all sprints)
- pytest Markers (organization)

**Quality patterns (load for validation):**
- Field Coverage
- World-Class Validation
- Bug Hunting

**Development patterns (early sprints):**
- Stub-First Development
- Language Registry Testing (Sprint 1 specific)

---

## Coverage Targets

**By pattern:**
- Database Unit Testing → 85%+ target
- Integration Workflow → End-to-end validation (not coverage-based)
- Field Coverage → 60% (Bronze), 75% (Silver), 90% (Gold)
- World-Class Validation → Real ISBN comparison

**Sprint 4 achievement: 87% coverage on catalog_database.py!**

---

## Bug Discovery Pattern

**Sprint 4 bug hunting process:**
1. Write comprehensive tests (Pattern 1: Database Unit Testing)
2. Run tests → failures reveal bugs
3. Fix bugs in source code
4. Re-run tests → all passing
5. Document bugs found (Pattern 8: Bug Hunting)

**3 critical bugs found and fixed in Sprint 4:**
- Field mapping bug (BookMetadata → DB schema)
- Exception import bug (EnrichmentError → CatalogError)
- Missing stats fields (translations, non_translations)

---

## Maintenance

**Add new patterns:**
1. Build test suite
2. Document approach
3. Tag appropriately
4. Note effectiveness after 2-3 uses

**Pattern evolution:**
- Stub patterns → Real implementation patterns
- Simple tests → Edge case coverage
- Manual → Automated testing

---

**Last updated:** Sprint 4 (2025-10-10)
**Total patterns:** 8
**Sprint 4 achievement:** 87% coverage, 3 bugs found, 22 new tests
**Next:** Performance testing patterns, mutation testing (Sprint 5+)
