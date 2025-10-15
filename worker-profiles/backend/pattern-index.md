# Backend Worker - Pattern Index

**Purpose:** Lightweight catalog of all patterns (load this first, then select relevant patterns)
**Size:** ~4k tokens (vs 64k for all patterns)
**Usage:** Review task → Select 2-5 relevant patterns → Load only those

---

## Pattern Library (8 patterns)

### 1. Three-Source API Fallback
**File:** `patterns/three-source-api-fallback.md`
**Size:** ~2.5k tokens
**When to use:** Multi-source data fetching, API resilience, fallback chains
**Tags:** #api #fallback #resilience #multi-source #wikidata
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (Wikidata integration)
**Key concept:** Google Books → Open Library → Wikidata → Description mining
**Combines with:** Caching patterns, error handling

### 2. ODS Export with odfpy
**File:** `patterns/ods-export-odfpy.md`
**Size:** ~2k tokens
**When to use:** Spreadsheet export, multilingual data, LibreOffice compatibility
**Tags:** #export #ods #spreadsheet #odfpy #multilingual
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (catalog export)
**Key concept:** UTF-8-sig encoding, column styling, translation fields
**Combines with:** CSV export, data formatting

### 3. SQLAlchemy ORM Patterns
**File:** `patterns/sqlalchemy-orm-patterns.md`
**Size:** ~2.5k tokens
**When to use:** Database models, relationships, foreign keys, SQLite
**Tags:** #database #orm #sqlalchemy #sqlite #models
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (normalized database)
**Key concept:** Declarative base, relationships, session management
**Combines with:** Repository pattern, migration patterns

### 4. Wikidata Entity Query
**File:** `patterns/wikidata-entity-query.md`
**Size:** ~2k tokens
**When to use:** Wikidata API, SPARQL queries, structured data extraction
**Tags:** #wikidata #sparql #api #entity-query #structured-data
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (translation metadata)
**Key concept:** ISBN → Entity ID → Properties (P655, P1476, P364)
**Combines with:** API fallback, caching

### 5. Description Mining with Regex
**File:** `patterns/description-mining-regex.md`
**Size:** ~1.5k tokens
**When to use:** Text extraction, pattern matching, fallback data source
**Tags:** #regex #text-mining #extraction #fallback
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 3 (translator extraction)
**Key concept:** "translated from X by Y" patterns, multiple regex attempts
**Combines with:** API fallback, validation

### 6. Cover Image Multi-Source
**File:** `patterns/cover-image-multi-source.md`
**Size:** ~2k tokens
**When to use:** Image fetching, thumbnail generation, caching
**Tags:** #images #covers #cache #thumbnail #multi-source
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 2 (cover fetching)
**Key concept:** Google Books → Open Library, thumbnail generation, local cache
**Combines with:** Caching strategy, API fallback

### 7. CSV Import/Export
**File:** `patterns/csv-import-export.md`
**Size:** ~1.5k tokens
**When to use:** Simple data export, CSV migration, bulk import
**Tags:** #csv #export #import #migration #bulk
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 4 (CSV → SQLite migration)
**Key concept:** UTF-8-sig encoding, bulk operations, field mapping
**Combines with:** Database patterns, validation

### 8. Photo ISBN Extraction
**File:** `patterns/photo-isbn-extraction.md`
**Size:** ~2k tokens
**When to use:** Barcode detection, image processing, ISBN scanning
**Tags:** #barcode #isbn #pyzbar #opencv #image-processing
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 2 (photo scanning)
**Key concept:** pyzbar detection, multiple ISBN handling, preprocessing
**Combines with:** Validation patterns

---

## Pattern Selection Guide

### For Database Tasks
**Load:** SQLAlchemy ORM Patterns, CSV Import/Export
**Skip:** API patterns, image processing

### For API Integration Tasks
**Load:** Three-Source API Fallback, Wikidata Entity Query, Description Mining
**Skip:** Database patterns, export patterns

### For Export/Import Tasks
**Load:** ODS Export, CSV Import/Export, SQLAlchemy ORM (if from DB)
**Skip:** API patterns, image processing

### For Image/Scanning Tasks
**Load:** Photo ISBN Extraction, Cover Image Multi-Source
**Skip:** Export patterns, database patterns

---

## Pattern Composition Examples

### Example 1: Enrichment with Database Storage
```
Task: Fetch book data, store in database

Select patterns:
1. Three-Source API Fallback (fetch data)
2. SQLAlchemy ORM Patterns (store data)

Combine:
fetch_from_apis() [Pattern 1]
  → transform_to_model() [Pattern 2]
  → session.add(book) [Pattern 2]
```

### Example 2: Export Enriched Catalog
```
Task: Export database to ODS spreadsheet

Select patterns:
1. SQLAlchemy ORM Patterns (query database)
2. ODS Export (write spreadsheet)

Combine:
books = session.query(Book).all() [Pattern 1]
  → export_to_ods(books) [Pattern 2]
```

### Example 3: Complete Enrichment Pipeline
```
Task: Scan ISBN, enrich, store, export

Select patterns:
1. Photo ISBN Extraction (scan)
2. Three-Source API Fallback (enrich)
3. SQLAlchemy ORM Patterns (store)
4. ODS Export (export)

Combine all 4 patterns in sequence
```

---

## Selection Algorithm

**Keywords → Patterns mapping:**
- "database", "SQLite", "models" → SQLAlchemy ORM
- "API", "fetch", "fallback" → Three-Source Fallback
- "Wikidata", "SPARQL" → Wikidata Entity Query
- "export", "spreadsheet", "ODS" → ODS Export
- "CSV", "import", "migrate" → CSV Import/Export
- "image", "cover", "thumbnail" → Cover Image Multi-Source
- "barcode", "ISBN", "scan" → Photo ISBN Extraction
- "mining", "extract", "regex" → Description Mining

---

## Token Budget

**Typical task loads 2-4 patterns:**
- Small task (1 pattern): ~2k tokens
- Medium task (2-3 patterns): ~5k tokens
- Large task (4-5 patterns): ~10k tokens

**Total library: 16k tokens (all 8 patterns)**
**Selective loading: 85% token savings**

---

## Maintenance

**Add new patterns:**
1. Create pattern file in `patterns/` directory
2. Add entry to this index
3. Tag appropriately
4. Document when to use
5. Add to composition examples

**Update existing patterns:**
1. Update pattern file
2. Update effectiveness rating
3. Add "Used in" projects
4. Update size if changed

---

**Last updated:** Sprint 4 (2025-10-10)
**Total patterns:** 8
**Next:** Add async patterns (Sprint 5+)
