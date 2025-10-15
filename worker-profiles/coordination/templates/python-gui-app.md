# Python GUI Application Template

**Origin:** Book Cataloger project (2025-10)
**Tech Stack:** Python 3.11+, PyQt6, pytest
**Pattern:** 5-Terminal Parallel Development

---

## Architecture Overview

```
src/
├── ui/              → Frontend Worker
│   ├── main_window.py
│   ├── dialogs/
│   └── widgets/
├── api/             → Backend Worker
│   ├── external_apis/
│   └── data_fetching/
├── core/            → Integration Worker
│   ├── data_models.py
│   ├── database.py
│   └── workflows.py
├── export/          → Backend Worker
│   ├── csv_exporter.py
│   └── ods_exporter.py
└── utils/           → Shared (any worker)
    └── helpers.py

tests/
├── unit/            → Each worker writes own
└── integration/     → Quality Worker
```

---

## Worker Assignment

### Frontend Worker (Terminal 2)
**Owns:** `src/ui/`
**Responsibilities:**
- Main window design
- Dialog/modal implementations
- Widget components
- PyQt6 signals/slots
- UI event handling

**Typical Sprint Tasks:**
- Main window layout (60-90 min)
- Modal dialogs (30-60 min each)
- Custom widgets (30-45 min each)
- Wiring/integration (30 min)

**Dependencies:**
- Needs Integration's data models
- Needs Integration's workflow classes
- Can mock initially

### Backend Worker (Terminal 3)
**Owns:** `src/api/`, `src/export/`
**Responsibilities:**
- External API integrations
- Data fetching/caching
- Export formats (CSV, ODS, PDF, etc.)
- Image processing
- File I/O

**Typical Sprint Tasks:**
- API client (30-60 min)
- Caching system (30-45 min)
- Export format (60-90 min for ODS)
- Image processing (45-60 min)

**Dependencies:**
- Usually independent
- Provides services to Integration

### Integration Worker (Terminal 4)
**Owns:** `src/core/`, modifies `src/enrichment/`
**Responsibilities:**
- Core data models
- Database/storage layer
- Business logic orchestration
- Service integration
- Workflow coordination

**Typical Sprint Tasks:**
- Data model definition (30-45 min)
- Database implementation (45-90 min)
- Workflow orchestration (60-90 min)
- Registry/singleton patterns (45-60 min)

**Dependencies:**
- Uses Backend's APIs
- Provides to Frontend

### Quality Worker (Terminal 5)
**Owns:** `tests/integration/`, bug fixes anywhere
**Responsibilities:**
- Integration testing
- Bug fixes
- Test strategy
- Code review

**Typical Sprint Tasks:**
- Integration tests (15-30 min each)
- Bug fixes (10-20 min each)
- Test strategy (30-60 min)

**Special Note:** Often underutilized (workers write own unit tests)
**Recommendation:** Consider dynamic reallocation if < 1 hour of work

---

## Technology Stack

### Core
```python
# requirements.txt
PyQt6>=6.5.0           # GUI framework
pytest>=7.0.0          # Testing
pytest-qt>=4.0.0       # Qt testing support
```

### Backend (as needed)
```python
requests>=2.31.0       # API calls
pillow>=10.0.0         # Image processing
odfpy>=1.4.1          # ODS export
pyzbar>=0.1.9         # Barcode scanning
opencv-python>=4.8.0   # Image processing
```

### Development
```python
black>=23.0.0          # Code formatting
mypy>=1.5.0           # Type checking
pytest-cov>=4.1.0     # Coverage
```

---

## Sprint Planning Template

### Sprint 1: Foundation
**Goal:** Core data structures + basic UI + export

**Frontend:**
- Main window skeleton (45 min)
- Key widget components (30-60 min each)

**Backend:**
- Export format implementation (60-90 min)
- Any external APIs (30-60 min each)

**Integration:**
- Data models (30-45 min)
- Registry/singleton if needed (45-60 min)
- Core business logic (60 min)

**Quality:**
- Fix any broken tests (15-30 min)
- 1-2 integration tests (15-30 min)

**Expected:** 45-90 minutes parallel

### Sprint 2: Features
**Goal:** Complete user workflows

**Frontend:**
- Main UI views (60-90 min each)
- Modal dialogs (30-60 min each)
- Full window wiring (30 min)

**Backend:**
- Additional APIs (30-60 min each)
- Caching systems (30-45 min)
- Image handling (45-60 min)

**Integration:**
- Database layer (45-90 min)
- Workflow orchestration (60-90 min)
- Feature validation (20-30 min)

**Quality:**
- Integration tests (15-30 min each)
- Bug fixes (as needed)

**Expected:** 2-3 hours parallel

---

## Key Patterns to Reuse

### From Book Cataloger

1. **LanguageSelector Widget** (Frontend)
   - Registry-backed dropdown
   - Custom signals
   - Get/set methods
   - Pattern: `~/.claude-workers/frontend/patterns/language-selector-pyqt6.md`

2. **ODS Export** (Backend)
   - UTF-8-sig encoding
   - Multilingual support
   - Styled headers
   - Pattern: `~/.claude-workers/backend/patterns/ods-export-odfpy.md`

3. **Singleton Registry** (Integration)
   - Thread-safe
   - Lazy/eager initialization
   - Pattern: `~/.claude-workers/integration/patterns/language-registry-singleton.md`

4. **CSV Database** (Integration)
   - Simple, effective storage
   - Thread-safe operations
   - Good for < 10,000 records

5. **API Multi-Source** (Backend)
   - Primary + fallback APIs
   - Error handling
   - Caching

---

## Domain Separation Rules

### ✅ Frontend CAN:
- Read/write `src/ui/`
- Import from `src/core/` (data models)
- Import from `src/utils/`
- Call Integration workflows

### ❌ Frontend CANNOT:
- Modify `src/api/`, `src/export/`, `src/core/`
- Implement business logic
- Call Backend APIs directly (use Integration layer)

### ✅ Backend CAN:
- Read/write `src/api/`, `src/export/`
- Import from `src/utils/`
- Provide APIs for Integration

### ❌ Backend CANNOT:
- Modify `src/ui/`, `src/core/`
- Implement UI components
- Handle workflows (Integration's job)

### ✅ Integration CAN:
- Read/write `src/core/`
- Modify enrichment/orchestration files
- Import from `src/api/`, `src/export/`
- Import from `src/utils/`

### ❌ Integration CANNOT:
- Modify `src/ui/`
- Implement UI components

**Result:** Zero merge conflicts with proper separation!

---

## File Structure Template

```
project-name/
├── .ai/                           # AI context
│   ├── FIVE_TERMINAL_FRAMEWORK.md
│   ├── BRAIN_CONTEXT.md
│   ├── START_HERE_5_TERMINALS.md
│   └── scripts/
│       ├── setup_worktrees.sh
│       └── worktree_status.sh
├── src/
│   ├── __init__.py
│   ├── ui/                        # Frontend Worker
│   │   ├── __init__.py
│   │   ├── main_window.py
│   │   ├── dialogs/
│   │   └── widgets/
│   ├── api/                       # Backend Worker
│   │   ├── __init__.py
│   │   └── [api_clients]/
│   ├── core/                      # Integration Worker
│   │   ├── __init__.py
│   │   ├── data_models.py
│   │   ├── database.py
│   │   └── workflows.py
│   ├── export/                    # Backend Worker
│   │   ├── __init__.py
│   │   └── [exporters]/
│   └── utils/                     # Shared
│       ├── __init__.py
│       └── helpers.py
├── tests/
│   ├── __init__.py
│   ├── unit/                      # Each worker
│   │   ├── test_ui_components.py
│   │   ├── test_api_clients.py
│   │   ├── test_core_models.py
│   │   └── test_exporters.py
│   └── integration/               # Quality Worker
│       └── test_workflows.py
├── requirements.txt
├── pytest.ini
├── README.md
└── CLAUDE.md                      # Project context
```

---

## Coordination Protocols

### Launch Sequence
1. Brain creates worktrees (5 min)
2. Brain creates task documents for each worker
3. Brain launches workers with copy/paste instructions
4. Workers work in parallel
5. Brain monitors every 30-60 min

### Merge Order
1. Quality/Testing (quick fixes)
2. Backend (APIs, export)
3. Integration (core logic, workflows)
4. Frontend (UI components)

**Why:** Dependencies flow Backend → Integration → Frontend

### Status Checks
```bash
# Brain runs every 30-60 min
.ai/scripts/worktree_status.sh

# Look for COMPLETE.txt
find ../project-worktrees -name "COMPLETE.txt"

# Check git status
for worker in gui backend integration quality; do
  cd ../project-worktrees/project-$worker && git status --short
done
```

---

## Success Metrics

### From Book Cataloger
- **Parallel speedup:** 3-4x faster than sequential
- **Merge conflicts:** 0 (with proper domain separation)
- **Test coverage:** 95%+
- **Development time:** Sprint 1: 45 min, Sprint 2: 2-3 hours

### Expected for New Project
- **Setup time:** 15-30 min (worktrees + task docs)
- **Sprint 1:** 60-90 min parallel
- **Sprint 2:** 2-3 hours parallel
- **Total to MVP:** 3-4 hours parallel (vs 12-15 hours sequential)

---

## Common Pitfalls

### ❌ Workers Modifying Shared Files
**Problem:** Multiple workers edit `src/core/models.py`
**Solution:** Clear domain ownership, Integration owns core models

### ❌ Frontend Calling Backend APIs Directly
**Problem:** UI logic mixed with API logic
**Solution:** Frontend calls Integration workflows, Integration calls Backend

### ❌ Testing Worker Underutilized
**Problem:** Only 20 min of work in 3-hour sprint
**Solution:** Dynamic reallocation (GUI Assistant, etc.)

### ❌ Workers Blocked Waiting for Dependencies
**Problem:** Integration waiting for Backend to finish APIs
**Solution:** Mock initially, integrate after Backend merges

---

## Reuse Checklist for New Project

- [ ] Copy `.ai/` framework files
- [ ] Set up 5 worktrees with feature branches
- [ ] Create `SPRINT_X_TASKS.md` for each worker
- [ ] Load relevant patterns from `~/.claude-workers/*/patterns/`
- [ ] Define domain separation (what each worker owns)
- [ ] Launch workers with clear instructions
- [ ] Monitor and merge in dependency order

---

## Related Documents

- `~/.claude-workers/coordination/protocols/brain-worker-coordination.md`
- `~/.claude-workers/frontend/patterns/` (UI patterns)
- `~/.claude-workers/backend/patterns/` (API, export patterns)
- `~/.claude-workers/integration/patterns/` (data, workflow patterns)

---

**Use this template for:** Any Python GUI application with data processing, external APIs, and export features. Expected 3-4x speedup over sequential development!
