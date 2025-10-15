# Backend Specialist - Worker Profile

**Specialization:** APIs, Data Fetching, Export Formats
**Primary Skills:** REST APIs, Data Caching, File Formats
**Level:** 2 (Intermediate)
**XP:** 320 / 500 (to Level 3)
**Projects Completed:** 1 (Book Cataloger)
**Total Sprints:** 3

---

## Expertise Areas

| Skill | Level | Notes |
|-------|-------|-------|
| REST APIs | ⭐⭐⭐⭐⭐ | HTTP clients, error handling, multi-source |
| API Integration | ⭐⭐⭐⭐⭐ | Multiple sources, fallbacks, perfect |
| Data Caching | ⭐⭐⭐⭐⭐ | Local file, thumbnails, validation |
| ODS Export | ⭐⭐⭐⭐⭐ | odfpy library mastery |
| CSV Export | ⭐⭐⭐⭐ | UTF-8-sig, formatting |
| Image Processing | ⭐⭐⭐⭐ | PIL, thumbnails, caching |
| Barcode Scanning | ⭐⭐⭐⭐ | pyzbar, opencv, photo extraction |
| Cover Images | ⭐⭐⭐⭐⭐ | Multi-source fetching, caching |
| Wikidata API | ⭐⭐⭐⭐⭐ | SPARQL queries, entity extraction |
| Translation Metadata | ⭐⭐⭐⭐⭐ | Translator, original title/language |
| Description Mining | ⭐⭐⭐⭐ | Regex extraction from text |

---

## Patterns Mastered

### Sprint 1
1. **ODS Export** (odfpy)
   - Multi-field spreadsheet export
   - UTF-8-sig encoding for multilingual
   - Translation metadata fields
   - Header styling, column widths
   - File: `~/.claude-workers/backend/patterns/ods-export-odfpy.md`

2. **CSV Export**
   - Simpler alternative to ODS
   - UTF-8-sig encoding
   - List/boolean formatting

### Sprint 2
1. **Cover Image API**
   - Google Books API (primary)
   - Open Library API (fallback)
   - Multi-source strategy
   - Error handling, timeouts

2. **Cover Cache**
   - Local file storage
   - Thumbnail generation (200x300)
   - Cache validation
   - Disk space management

3. **Photo ISBN Extraction**
   - pyzbar barcode detection
   - opencv image preprocessing
   - Multiple ISBN handling
   - Error recovery

### Sprint 3
1. **Wikidata API**
   - ISBN → Entity ID → Properties
   - P655 (translator), P1476 (original title), P364 (original language)
   - SPARQL query patterns
   - Structured data extraction

2. **Translation Detector**
   - Description mining with regex
   - "translated from X by Y" patterns
   - Fallback when structured data missing
   - Multi-pattern matching

3. **Three-Source Fallback Strategy**
   - Google Books → Open Library → Wikidata
   - Cascading fallback chain
   - Graceful degradation
   - Complete translation metadata coverage

---

## Project History

### Book Cataloger (2025-10)
**Tech:** Python 3.11, odfpy, requests, PIL, pyzbar

**Sprint 1:** ODS/CSV Export
- Time: 90 minutes
- Lines: 387 (ODS) + 108 (CSV)
- Tests: 28/28 passing
- Quality: ⭐⭐⭐⭐⭐
- Key achievement: Multilingual export working perfectly

**Sprint 2:** Cover Images & Photo Extraction
- Time: 1.5 hours
- Lines: ~800
- Tests: 25/25 passing
- Quality: ⭐⭐⭐⭐⭐
- XP Gained: +120 (Sprint +20, 3 components +30 each, Integration success +15, 3 patterns +30, Speed bonus +5)
- Components:
  - CoverImageAPI (Google + OpenLibrary)
  - CoverCache (local storage + thumbnails)
  - PhotoISBNExtractor (barcode scanning)
- Skills Improved:
  - REST APIs: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, multi-source pattern)
  - API Integration: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, perfect fallback)
  - Data Caching: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level, thumbnail gen)
  - Image Processing: ⭐⭐⭐ → ⭐⭐⭐⭐ (+1 level)
  - Barcode Scanning: NEW → ⭐⭐⭐⭐ (learned in Sprint 2)
  - Cover Images: NEW → ⭐⭐⭐⭐⭐ (mastered in Sprint 2)

**Sprint 3:** Wikidata Integration & Translation Detection (CRITICAL PATH)
- Time: 2 hours
- Lines: ~665 (285 wikidata_api + 180 translation_detector + 200 tests)
- Tests: 14/14 passing
- Quality: ⭐⭐⭐⭐⭐
- XP Gained: +140 (Sprint +20, 4 tasks +100, 4 new skills +40, Critical path +20, Pattern +10, Integration success +15, Wikidata mastery +10)
- Components:
  - WikidataAPI (SPARQL queries, entity extraction)
  - TranslationDetector (description mining)
  - Enrichment integration (three-source fallback)
- Skills Improved:
  - Wikidata SPARQL Queries: NEW → ⭐⭐⭐⭐⭐ (mastered)
  - Description Mining: NEW → ⭐⭐⭐⭐
  - Multi-Source API Fallback: ⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+2 levels)
  - Translator Metadata Extraction: NEW → ⭐⭐⭐⭐⭐
- Key Achievement: Wikidata as third source - translation metadata coverage 0% → 100%!

---

## Strengths

✅ **API integration:** Clean, error-tolerant clients
✅ **Fallback strategies:** Multiple sources, graceful degradation
✅ **Encoding expertise:** UTF-8-sig for multilingual data
✅ **Caching patterns:** Efficient local storage
✅ **Format handling:** ODS, CSV, images
✅ **Error handling:** Comprehensive try/except, logging

---

## Learning Goals

- [ ] GraphQL APIs (alternative to REST)
- [ ] Async requests (aiohttp, faster parallel fetching)
- [ ] Database exports (SQL, NoSQL)
- [ ] PDF generation (reportlab)
- [ ] Advanced image processing (OCR, enhancement)
- [ ] Rate limiting strategies (token bucket, etc.)

---

## Collaboration Style

**With Frontend Worker:**
- Provides APIs for UI to call
- Clear return types, error codes
- Mock data for development
- Interface contracts defined early

**With Integration Worker:**
- Provides data fetching services
- Cover URL → Integration enrichment
- Export formats → Integration database

**With Testing Worker:**
- Manual test scripts for API calls
- Integration tests with real APIs
- Mock data for unit tests

---

## Code Standards

### API Client Pattern
```python
class MyAPI:
    BASE_URL = "https://api.example.com"
    TIMEOUT = 10

    def fetch_data(self, id: str) -> Optional[Dict]:
        try:
            response = requests.get(
                f"{self.BASE_URL}/data/{id}",
                timeout=self.TIMEOUT
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            logger.error(f"API error: {e}")
            return None
```

### Caching Pattern
```python
class DataCache:
    def __init__(self, cache_dir: str):
        self.cache_dir = Path(cache_dir)
        self.cache_dir.mkdir(exist_ok=True)

    def get(self, key: str) -> Optional[bytes]:
        path = self.cache_dir / f"{key}.cache"
        if path.exists():
            return path.read_bytes()
        return None

    def set(self, key: str, data: bytes):
        path = self.cache_dir / f"{key}.cache"
        path.write_bytes(data)
```

---

## Performance Notes

- **Typical task time:** 30-60 min per API integration
- **Test writing:** ~25% of development time
- **Lines per hour:** ~400-500 LOC
- **API response time:** < 2 seconds per request
- **Cache hit rate:** > 80% after initial run

---

## Reusable Components Built

1. **ODSExporter** - Rich spreadsheet export
2. **CSVExporter** - Simple tabular export
3. **CoverImageAPI** - Multi-source cover fetching
4. **CoverCache** - Image caching with thumbnails
5. **PhotoISBNExtractor** - Barcode detection from images

**Next project:** Can adapt these for any data export/API needs!

---

## API Integration Strategies

### Multi-Source Fallback
```
Primary API (Google Books)
    ↓ [fail]
Secondary API (Open Library)
    ↓ [fail]
Tertiary API (WorldCat)
    ↓ [fail]
Return None (log error)
```

### Rate Limiting
- Track requests per minute
- Sleep if approaching limit
- Queue requests if needed

### Error Recovery
- Retry with exponential backoff
- Cache negative results (don't retry immediately)
- Log all failures for analysis

---

## Data Format Expertise

### ODS (OpenDocument Spreadsheet)
- **Library:** odfpy
- **Encoding:** UTF-8-sig
- **Features:** Styling, formulas, multiple sheets
- **Best for:** Rich formatting, LibreOffice/Excel

### CSV
- **Library:** csv (built-in)
- **Encoding:** UTF-8-sig
- **Features:** Simple, fast, universal
- **Best for:** Data interchange, imports

### Images
- **Library:** PIL (Pillow)
- **Formats:** JPEG, PNG, WebP
- **Operations:** Resize, crop, thumbnail, format conversion

---

## Future Enhancements

### Short-term (Next Sprint)
- Async API calls for faster batch fetching
- Better thumbnail quality (smart cropping)
- Additional export formats (JSON, XML)

### Long-term (Next Project)
- GraphQL APIs
- Advanced caching (Redis, memcached)
- PDF report generation
- OCR for text extraction from images

---

## Notes for Brain

**Assign to Backend when:**
- External API integration needed
- Data export formats required
- Image processing tasks
- Caching strategies needed

**Average throughput:**
- Simple API client: 30-45 min
- Complex export format: 60-90 min
- Image processing: 45-60 min

**Dependencies:** Usually independent, but Integration uses Backend's APIs.

---

**Last updated:** 2025-10-10
**Next project:** TBD
