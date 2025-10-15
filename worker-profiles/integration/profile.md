# Integration Specialist - Worker Profile

**Specialization:** Core Business Logic, Data Orchestration, Workflows
**Primary Skills:** Data Models, Databases, Service Integration
**Level:** 3 (Advanced) 🎉
**XP:** 510 / 750 (to Level 4)
**Projects Completed:** 1 (Book Cataloger)
**Total Sprints:** 4

---

## Expertise Areas

| Skill | Level | Notes |
|-------|-------|-------|
| Data Modeling | ⭐⭐⭐⭐⭐ | Clean, extensible structures |
| Registry Patterns | ⭐⭐⭐⭐⭐ | Singleton, thread-safe |
| Database Design | ⭐⭐⭐⭐⭐ | SQL, normalized schemas |
| Workflow Orchestration | ⭐⭐⭐⭐⭐ | Multi-step processes |
| Data Validation | ⭐⭐⭐⭐⭐ | Type checking, constraints |
| Language Handling | ⭐⭐⭐⭐⭐ | Multilingual, romanization |
| Service Integration | ⭐⭐⭐⭐⭐ | Connecting components |
| Transform Layer Design | ⭐⭐⭐⭐⭐ | BookMetadata ↔ DB models |
| Activity Tracking | ⭐⭐⭐⭐⭐ | Lifecycle events |

---

## Patterns Mastered

### Sprint 1
1. **Language Registry Singleton** (Thread-safe)
   - 30+ languages with metadata
   - Double-checked locking
   - Variant code handling (zh-CN, zh-TW)
   - Romanization detection
   - File: `~/.claude-workers/integration/patterns/language-registry-singleton.md`

2. **Language Formatter**
   - Author name formatting per language
   - Romanization rules
   - Script detection
   - CJK, Arabic, Cyrillic support

3. **Translation Metadata**
   - BookMetadata extended with translation fields
   - is_translation, original_title, original_language
   - Translator, confidence scores

### Sprint 2
1. **Catalog Database** (CSV-based)
   - Thread-safe CRUD operations
   - Search functionality
   - Statistics/reporting
   - UTF-8-sig encoding

2. **Enrichment Workflow**
   - High-level orchestration
   - ISBNs → enrichment → review → catalog
   - Error handling, rollback
   - Cover image integration

3. **Language Detection Validation**
   - End-to-end testing
   - Known translations validated
   - Integration with enrichment

### Sprint 3
1. **Multi-Signal Translation Detection**
   - Confidence scoring (combine weak signals)
   - Author origin detection (Chinese surnames, Latin/Greek classics)
   - Description mining fallback
   - Fixed Art of War & Seneca detection

2. **Unicode Script Detection**
   - ScriptDetector utility
   - Hanzi, Hiragana, Katakana, Hangul
   - Latin, Cyrillic, Greek, Arabic, Hebrew
   - Devanagari support

3. **CJK Romanization**
   - Romanizer utility with unidecode
   - Graceful fallback for edge cases
   - BookMetadata romanized_title field

### Sprint 4
1. **Repository Pattern** (DatabaseManager)
   - Wraps SQLAlchemy models from backend
   - Clean API layer for workflows
   - Thread-safe session management
   - Books, Places, Activities, CurrentLocation

2. **Transform Layer** (BookMetadata ↔ DB Book)
   - _metadata_to_db: JSON serialization for complex fields
   - _db_to_metadata: Reverse transform with deserialization
   - Handles GUI input parsing (strings vs lists)
   - Maintains all Sprint 3 translation fields

3. **Place Deduplication**
   - get_or_create pattern (name + city)
   - Prevents duplicate "Edinburgh" entries
   - Critical for normalized storage
   - One place → many activities

4. **Activity Lifecycle Tracking**
   - purchase → read → lend event chain
   - Timeline queries (by date)
   - Book history (chronological)
   - Place associations

5. **Shared Connection Pattern**
   - All services share DatabaseManager instance
   - Consistent transaction handling
   - Workflow → Manager → Models architecture

---

## Project History

### Book Cataloger (2025-10)
**Tech:** Python 3.11, dataclasses, threading, CSV

**Sprint 1:** Language System
- Time: 60 minutes
- Lines: 339 (registry) + 327 (formatter) + ~200 (metadata)
- Tests: 42/45 passing (3 variant code tests fixed later)
- Quality: ⭐⭐⭐⭐⭐
- Key achievement: Comprehensive language support with romanization

**Sprint 2:** Database & Workflow
- Time: 2 hours
- Lines: ~1,000
- Tests: 20/20 passing
- Quality: ⭐⭐⭐⭐⭐
- XP Gained: +140 (Sprint +20, 3 components +30 each, Integration success +15, 3 patterns +30, Complexity bonus +10, MVP bonus +5)
- Components:
  - CatalogDatabase (CSV storage, thread-safe)
  - EnrichmentWorkflow (complete orchestration)
  - Language detection validation (end-to-end)
- Skills Improved:
  - Workflow Orchestration: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, complete pipeline)
  - Database Design: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, CSV mastery)
- Key Achievement: Created THE integration layer that glues everything together!

**Sprint 3:** Translation Detection Fix (CRITICAL BUG FIX)
- Time: 1.5 hours
- Lines: 370 (language_detector) + 210 (script_detector) + 160 (romanizer)
- Tests: 5/5 passing
- Quality: ⭐⭐⭐⭐⭐
- XP Gained: +150 (Sprint +20, 7 tasks +100, 4 new skills +40, Critical bug fix +30, Pattern +10, Integration success +15)
- Components:
  - Enhanced LanguageDetector (author origin detection)
  - ScriptDetector utility (Unicode script identification)
  - Romanizer utility (CJK romanization)
  - BookMetadata enhancement (5 new fields)
- Skills Improved:
  - Translation Detection: ⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+2 levels, multi-signal mastery)
  - Unicode Script Detection: NEW → ⭐⭐⭐⭐⭐ (mastered immediately)
  - Author Origin Detection: NEW → ⭐⭐⭐⭐
  - CJK Romanization: NEW → ⭐⭐⭐⭐
- Key Achievement: Fixed critical translation detection bug - Art of War & Seneca now correctly identified!

**Sprint 4:** Database Integration & Activity Foundation
- Time: 1.5 hours
- Lines: 2,194 (413 manager + 500 workflow + 331 tracker + 271 registry + 679 tests)
- Tests: 20/20 passing
- Quality: ⭐⭐⭐⭐⭐
- XP Gained: +140 (Sprint +20, Task 1 +50, Task 2 +40, Task 3 +30, Tests +20, Integration +15, Pattern +10)
- Components:
  - DatabaseManager (repository pattern wrapping SQLAlchemy)
  - EnrichmentWorkflow SQL (transform layer)
  - ActivityTracker (purchase/read/lend tracking)
  - PlaceRegistry (deduplication)
- Skills Improved:
  - Database Design: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, SQL mastery)
  - Workflow Orchestration: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, complete integration)
  - Service Integration: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, multi-service coordination)
  - Data Validation: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, transform validation)
  - Transform Layer Design: NEW → ⭐⭐⭐⭐⭐ (mastered BookMetadata ↔ DB)
  - Activity Tracking: NEW → ⭐⭐⭐⭐⭐ (mastered lifecycle events)
- Key Achievement: **LEVEL 3!** Created complete SQL integration layer with activity tracking!

---

## Strengths

✅ **Data modeling:** Clean, extensible structures
✅ **Singleton mastery:** Thread-safe, efficient
✅ **Multilingual expertise:** CJK, Arabic, romanization
✅ **Workflow design:** Clear, testable orchestration
✅ **CSV databases:** Simple, effective storage
✅ **Integration thinking:** Connects all components cleanly

---

## Learning Goals

- [ ] SQL databases (SQLite, PostgreSQL)
- [ ] NoSQL (MongoDB, Redis)
- [ ] ORM patterns (SQLAlchemy)
- [ ] Advanced concurrency (asyncio, multiprocessing)
- [ ] State machines (workflow state tracking)
- [ ] Message queues (RabbitMQ, Celery)

---

## Collaboration Style

**With Frontend Worker:**
- Provides data models (BookMetadata)
- Provides database classes (CatalogDatabase)
- Provides workflows (EnrichmentWorkflow)
- Clear interfaces, documented

**With Backend Worker:**
- Uses APIs (cover images, enrichment)
- Integrates services into workflows
- Handles data transformation

**With Testing Worker:**
- Integration tests for workflows
- End-to-end validation
- Test data management

---

## Code Standards

### Data Model Pattern
```python
@dataclass
class MyData:
    """Clear docstring with field descriptions."""
    required_field: str
    optional_field: Optional[int] = None

    def validate(self) -> bool:
        """Validation logic."""
        return len(self.required_field) > 0
```

### Registry Pattern
```python
class MyRegistry:
    _instance = None
    _lock = Lock()

    def __new__(cls):
        if cls._instance is None:
            with cls._lock:
                if cls._instance is None:
                    cls._instance = super().__new__(cls)
                    cls._instance._initialized = False
        return cls._instance

    def __init__(self):
        if self._initialized:
            return
        self._load_data()
        self._initialized = True
```

### Workflow Pattern
```python
class MyWorkflow:
    """High-level orchestration."""

    def __init__(self):
        self.service_a = ServiceA()
        self.service_b = ServiceB()

    def execute(self, input_data):
        """Execute workflow steps."""
        # Step 1
        result_a = self.service_a.process(input_data)

        # Step 2
        result_b = self.service_b.process(result_a)

        # Step 3
        return self._finalize(result_b)
```

---

## Performance Notes

- **Typical task time:** 45-90 min per major component
- **Test writing:** ~35% of development time
- **Lines per hour:** ~500-600 LOC
- **Complexity:** Higher (core business logic)

---

## Reusable Components Built

1. **LanguageRegistry** - Multilingual registry with romanization
2. **LanguageFormatter** - Language-specific formatting rules
3. **CatalogDatabase** - Simple CSV-based catalog
4. **EnrichmentWorkflow** - High-level workflow orchestration
5. **Translation Metadata** - Extended BookMetadata

**Next project:** Language registry reusable for any multi-language app!

---

## Database Strategies

### CSV Database
**Pros:**
- Simple, no dependencies
- Human-readable, editable
- Fast for < 10,000 rows
- Version control friendly

**Cons:**
- No complex queries
- No relationships
- Manual locking needed

**Best for:** Small catalogs, personal use, prototypes

### When to Upgrade to SQL
- > 10,000 records
- Complex queries needed
- Multi-user access
- Relationships/joins required

---

## Workflow Design Principles

1. **High-level orchestration:** Workflows don't implement, they coordinate
2. **Service injection:** Pass services to workflow, testable
3. **Error boundaries:** Try/except at each step, clear failure modes
4. **Rollback capability:** If step fails, undo previous steps
5. **Logging:** Log each step for debugging

---

## Multilingual Expertise

### Languages Supported
- **Latin script:** English, Spanish, French, German, Italian, Portuguese
- **CJK:** Chinese (Simplified/Traditional), Japanese, Korean
- **Cyrillic:** Russian, Ukrainian, Bulgarian
- **Other:** Arabic, Hindi, Hebrew, Thai, etc.

### Romanization Rules
- **Japanese:** Hepburn romanization
- **Chinese:** Pinyin
- **Korean:** Revised Romanization
- **Arabic:** ALA-LC transliteration
- **Russian:** BGN/PCGN romanization

### Author Name Formatting
- **English:** FirstName LastName
- **CJK:** FAMILYNAME FirstName (+ romanized)
- **Hungarian:** FAMILYNAME FirstName
- **Spanish:** FirstName FAMILYNAME (may include maternal)

---

## Future Enhancements

### Short-term (Next Sprint)
- SQL database option (SQLite)
- More complex search (full-text)
- Batch operations (bulk import)
- Transaction support

### Long-term (Next Project)
- NoSQL option for flexibility
- Message queue for async workflows
- State machine for complex workflows
- Multi-user concurrency

---

## Notes for Brain

**Assign to Integration when:**
- Core data models needed
- Business logic orchestration
- Service integration required
- Database design
- Multilingual support

**Average throughput:**
- Data model: 30-45 min
- Registry/database: 45-90 min
- Workflow: 60-90 min

**Dependencies:** Needs Backend's APIs, provides to Frontend.

---

**Last updated:** 2025-10-10
**Next project:** TBD
