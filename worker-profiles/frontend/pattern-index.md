# Frontend Worker - Pattern Index

**Purpose:** Lightweight catalog of all patterns (load this first, then select relevant patterns)
**Size:** ~3k tokens (vs 56k for all patterns)
**Usage:** Review task → Select 2-5 relevant patterns → Load only those

---

## Pattern Library (7 patterns)

### 1. CJK Font Support for PyQt6
**File:** `patterns/cjk-font-support-pyqt6.md`
**Size:** ~2.5k tokens
**When to use:** Chinese/Japanese/Korean display, cross-platform fonts, PyQt6/Tkinter
**Tags:** #cjk #fonts #pyqt6 #tkinter #multilingual #unicode
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 3 (Chinese characters 孙子兵法 display perfectly)
**Key concept:** Font detection with fallback (Noto Sans CJK → Arial Unicode → PingFang)
**Combines with:** Multilingual table display, translation badges

### 2. Language Selector Widget
**File:** `patterns/language-selector-pyqt6.md`
**Size:** ~1.5k tokens
**When to use:** Dropdown for language selection, registry integration
**Tags:** #widget #dropdown #language #pyqt6 #signals
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 1 (language selector)
**Key concept:** QComboBox + custom signals, registry integration
**Combines with:** Registry patterns, form validation

### 3. Modal Dialog Patterns
**File:** `patterns/modal-dialog-patterns.md`
**Size:** ~2k tokens
**When to use:** Multi-input forms, validation, user confirmation
**Tags:** #dialog #modal #forms #validation #pyqt6
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 2 (AddBooksModal), Sprint 4 (PurchaseDialog)
**Key concept:** QDialog, input validation, state management (locked/unlocked)
**Combines with:** Form validation, data binding

### 4. CatalogView with QTableWidget
**File:** `patterns/catalog-view-qtablewidget.md`
**Size:** ~2.5k tokens
**When to use:** Database display, sortable tables, custom columns
**Tags:** #table #catalog #qtablewidget #display #sorting
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 2, Sprint 3 (translation columns)
**Key concept:** QTableWidget, column sizing, row selection, CJK font support
**Combines with:** CJK fonts, translation badges, context menus

### 5. Translation Badge Widget
**File:** `patterns/translation-badge-widget.md`
**Size:** ~1k tokens
**When to use:** Visual indicators, boolean states, colored badges
**Tags:** #widget #badge #visual #indicator
**Effectiveness:** ⭐⭐⭐⭐
**Used in:** Sprint 3 (green for translations, gray for originals)
**Key concept:** Reusable visual indicator, color coding
**Combines with:** Catalog view, data binding

### 6. Context Menu Patterns (Cross-Platform)
**File:** `patterns/context-menu-cross-platform.md`
**Size:** ~1.5k tokens
**When to use:** Right-click menus, PyQt6/Tkinter compatibility
**Tags:** #context-menu #right-click #cross-platform #tkinter #pyqt6
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (book history view)
**Key concept:** Right-click → action menu, works in both PyQt6 and Tkinter
**Combines with:** Catalog view, activity display

### 7. Stub Integration Pattern
**File:** `patterns/stub-integration-backend.md`
**Size:** ~2k tokens
**When to use:** Building UI before backend ready, interface definitions
**Tags:** #stub #integration #backend-ready #interface #decoupling
**Effectiveness:** ⭐⭐⭐⭐⭐
**Used in:** Sprint 4 (ActivityTracker stub)
**Key concept:** Define backend interfaces, implement stubs, document for integration
**Combines with:** Modal dialogs, data binding

---

## Pattern Selection Guide

### For Multilingual UI Tasks
**Load:** CJK Font Support, Language Selector, CatalogView
**Skip:** Context menus, stub patterns

### For Form/Dialog Tasks
**Load:** Modal Dialog Patterns, Form Validation
**Skip:** Table patterns, font patterns

### For Table/Display Tasks
**Load:** CatalogView, CJK Font Support, Translation Badge
**Skip:** Modal dialogs, language selector

### For Integration Tasks
**Load:** Stub Integration, Context Menu (if cross-platform)
**Skip:** Font patterns, badge patterns

---

## Pattern Composition Examples

### Example 1: Multilingual Catalog Display
```
Task: Display catalog with CJK characters

Select patterns:
1. CJK Font Support (font detection)
2. CatalogView (table display)
3. Translation Badge (visual indicators)

Combine:
setup_cjk_fonts() [Pattern 1]
  → create_table_widget() [Pattern 2]
  → add_translation_badges() [Pattern 3]
```

### Example 2: Purchase Dialog with Places
```
Task: Create purchase recording form

Select patterns:
1. Modal Dialog (form structure)
2. Stub Integration (backend interface)
3. Language Selector (if place has language context)

Combine:
dialog = PurchaseDialog() [Pattern 1]
  → stub_tracker = ActivityTrackerStub() [Pattern 2]
  → dialog.record_purchase(stub_tracker)
```

### Example 3: Context Menu with Activity History
```
Task: Right-click book → show history

Select patterns:
1. Context Menu (right-click handling)
2. CatalogView (table integration)
3. Stub Integration (backend interface)

Combine:
table.contextMenuEvent() [Pattern 2]
  → create_context_menu() [Pattern 1]
  → stub_tracker.get_book_history() [Pattern 3]
```

---

## Selection Algorithm

**Keywords → Patterns mapping:**
- "CJK", "Chinese", "font", "multilingual" → CJK Font Support
- "dialog", "modal", "form", "input" → Modal Dialog
- "table", "catalog", "display", "grid" → CatalogView
- "badge", "indicator", "visual", "color" → Translation Badge
- "language", "selector", "dropdown" → Language Selector
- "context", "right-click", "menu" → Context Menu
- "stub", "integration", "backend-ready" → Stub Integration

---

## Token Budget

**Frontend has focused patterns (7 total):**
- Small task (1 pattern): ~1.5-2k tokens
- Medium task (2-3 patterns): ~4-6k tokens
- Large task (4-5 patterns): ~8-10k tokens

**Total library: 13k tokens (all 7 patterns)**
**Selective loading: 85% token savings**

---

## Pattern Dependencies

**Core UI patterns (load frequently):**
- CatalogView (main display)
- Modal Dialog (user input)
- CJK Font Support (if multilingual)

**Specialized patterns (load as needed):**
- Translation Badge (specific to translations)
- Language Selector (language-specific features)
- Context Menu (advanced interactions)
- Stub Integration (during development)

---

## Framework Adaptation

**PyQt6 → Tkinter adaptation:**
- Most patterns work in both frameworks
- CJK Font Support: QFont → tkinter Font
- Modal Dialog: QDialog → Toplevel
- CatalogView: QTableWidget → ttk.Treeview
- Context Menu: QMenu → Menu

**Sprint 4 demonstrated cross-platform mastery!**

---

## Maintenance

**Add new patterns:**
1. Build feature in PyQt6 first
2. Document pattern
3. Note Tkinter equivalents
4. Add to index with tags

**Cross-platform notes:**
- Always document both PyQt6 and Tkinter approaches
- CJK font names differ by platform
- Test on macOS, Windows, Linux

---

**Last updated:** Sprint 4 (2025-10-10)
**Total patterns:** 7
**Framework proficiency:** PyQt6 ⭐⭐⭐⭐⭐, Tkinter ⭐⭐⭐⭐⭐
**Next:** Animation patterns, async UI updates (Sprint 5+)
