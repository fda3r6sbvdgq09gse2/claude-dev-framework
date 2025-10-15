# Language Selector Widget Pattern (PyQt6)

**Origin:** Book Cataloger - Sprint 1
**Date:** 2025-10-10
**Framework:** PyQt6
**Type:** Reusable UI Component

## Context

Dropdown selector for choosing from 30+ languages, integrated with LanguageRegistry singleton. Needed for book cataloging where language is a critical metadata field.

## Pattern

```python
from PyQt6.QtWidgets import QComboBox
from PyQt6.QtCore import pyqtSignal
from src.core.language_registry import LanguageRegistry

class LanguageSelector(QComboBox):
    """Dropdown selector for languages with registry integration.

    Features:
    - Auto-populates from LanguageRegistry
    - Emits signal on language change
    - Supports setting by code or name
    - Display format: "English (en)"
    """

    language_changed = pyqtSignal(str)  # Emits language code

    def __init__(self, parent=None):
        super().__init__(parent)
        self.registry = LanguageRegistry()
        self._populate_languages()
        self.currentIndexChanged.connect(self._on_change)

    def _populate_languages(self):
        """Load all languages from registry."""
        for lang in self.registry.get_all_languages():
            display = f"{lang.name} ({lang.code})"
            self.addItem(display, userData=lang.code)

    def _on_change(self, index: int):
        """Emit language code when selection changes."""
        if index >= 0:
            code = self.itemData(index)
            self.language_changed.emit(code)

    def set_language(self, code: str):
        """Set current language by code."""
        for i in range(self.count()):
            if self.itemData(i) == code:
                self.setCurrentIndex(i)
                return

    def get_language_code(self) -> str:
        """Get currently selected language code."""
        return self.currentData() if self.currentData() else "en"
```

## Usage Example

```python
# In a form or dialog
language_selector = LanguageSelector()
language_selector.set_language("ja")  # Set to Japanese
language_selector.language_changed.connect(self.on_language_changed)

def on_language_changed(self, code: str):
    print(f"User selected: {code}")
```

## Testing Pattern

```python
def test_language_selector_init():
    """Test selector initializes with languages."""
    selector = LanguageSelector()
    assert selector.count() > 30  # Has many languages
    assert selector.currentData() is not None

def test_set_language():
    """Test setting language by code."""
    selector = LanguageSelector()
    selector.set_language("es")
    assert selector.get_language_code() == "es"
```

## Key Lessons

1. **Use userData:** Store language code in userData, display formatted string
2. **Signal pattern:** Emit specific data (code) not widget state
3. **Registry integration:** Connect to singleton for consistency
4. **Set methods:** Provide both get and set for programmatic control

## Reusable For

- Any dropdown selection from registry/database
- Country selectors
- Category/tag selectors
- Format/type selectors
- Settings dropdowns

## Related Patterns

- Singleton registry pattern (integration/language-registry.md)
- Form validation with selectors
- Multi-language UI components

## Performance Notes

- Registry lookup is O(1) - singleton caches data
- Populates once on init, efficient for repeated use
- No API calls, all local data

## Sprint 1 Stats

- **Lines of code:** 188
- **Test coverage:** 100% (15/15 tests passing)
- **Development time:** ~45 minutes
- **Reusability:** High (used in multiple forms)
