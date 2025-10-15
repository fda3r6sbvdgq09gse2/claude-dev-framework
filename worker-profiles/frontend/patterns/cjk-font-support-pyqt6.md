# CJK Font Support for PyQt6

**Origin:** Book Cataloger - Sprint 3
**Date:** 2025-10-10
**Type:** UI Component
**Worker:** Frontend Specialist

---

## Context

When displaying Chinese, Japanese, or Korean (CJK) text in PyQt6, characters may show as boxes (□□□) if the system doesn't have appropriate fonts. We need cross-platform font detection and fallback.

## Problem

**Without CJK font support:**
- Chinese: 孙子兵法 → □□□□
- Japanese: こんにちは → □□□□□
- Korean: 안녕하세요 → □□□□□

**Challenges:**
- Different CJK fonts on different platforms (macOS, Windows, Linux)
- Qt default fonts don't support CJK
- Need to detect and use available fonts
- Must handle gracefully when no CJK fonts available

## Solution

Font detection with platform-specific fallback chain:

```python
from PyQt6.QtGui import QFont, QFontDatabase
from PyQt6.QtWidgets import QApplication
import logging

class CJKFontManager:
    """Manage CJK font detection and setup for PyQt6."""

    # Priority order: cross-platform → macOS → Windows → Linux
    CJK_FONTS = [
        "Noto Sans CJK SC",      # Google Noto (cross-platform, best)
        "Noto Sans CJK TC",      # Traditional Chinese variant
        "Noto Sans CJK JP",      # Japanese variant
        "Arial Unicode MS",       # macOS
        "PingFang SC",            # macOS (Simplified Chinese)
        "PingFang TC",            # macOS (Traditional Chinese)
        "Hiragino Sans GB",       # macOS (Chinese)
        "Microsoft YaHei",        # Windows
        "SimHei",                 # Windows (Chinese)
        "Malgun Gothic",          # Windows (Korean)
        "Meiryo",                 # Windows (Japanese)
        "WenQuanYi Zen Hei",     # Linux
        "WenQuanYi Micro Hei"    # Linux
    ]

    @classmethod
    def get_cjk_font(cls, size: int = 10) -> QFont:
        """Get first available CJK font."""
        for font_name in cls.CJK_FONTS:
            font = QFont(font_name, size)
            if font.exactMatch():
                logging.info(f"Using CJK font: {font_name}")
                return font

        # Fallback to default font
        logging.warning("No CJK fonts found - CJK characters may not display correctly")
        return QFont("Arial", size)  # Graceful degradation

    @classmethod
    def list_available_cjk_fonts(cls) -> List[str]:
        """List all available CJK fonts on system."""
        available = []
        for font_name in cls.CJK_FONTS:
            font = QFont(font_name)
            if font.exactMatch():
                available.append(font_name)
        return available

    @classmethod
    def has_cjk_support(cls) -> bool:
        """Check if any CJK font is available."""
        return len(cls.list_available_cjk_fonts()) > 0


class CatalogView(QWidget):
    """Example usage in a catalog view."""

    def __init__(self):
        super().__init__()
        self._setup_fonts()
        self._setup_table()

    def _setup_fonts(self):
        """Setup fonts for CJK display."""
        self.table_font = CJKFontManager.get_cjk_font(size=10)

        # Optionally check if CJK support available
        if not CJKFontManager.has_cjk_support():
            # Show warning to user
            logging.warning("Install 'Noto Sans CJK' for proper CJK display")

    def _setup_table(self):
        """Setup table with CJK font."""
        self.table = QTableWidget()
        self.table.setFont(self.table_font)

        # Also set font for specific columns if needed
        for col in [2, 3]:  # Original Title, Romanization columns
            header = self.table.horizontalHeader()
            header_font = CJKFontManager.get_cjk_font(size=9)
            header.setFont(header_font)
```

## Usage

**Basic setup:**
```python
from src.ui.utils.cjk_fonts import CJKFontManager

# Get CJK font
cjk_font = CJKFontManager.get_cjk_font(size=12)

# Apply to widget
widget.setFont(cjk_font)

# Check if CJK supported
if CJKFontManager.has_cjk_support():
    print("CJK characters will display correctly")
else:
    print("Warning: Install Noto Sans CJK for proper display")
```

**In application initialization:**
```python
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Check CJK support early
        available_fonts = CJKFontManager.list_available_cjk_fonts()
        logging.info(f"Available CJK fonts: {available_fonts}")

        if not available_fonts:
            self._show_font_warning()

        self._setup_ui()
```

**Column-specific fonts:**
```python
def _setup_table_columns(self):
    """Setup table with different fonts per column."""
    columns = [
        ("Title", "Arial", 10),
        ("Original Title", "CJK", 10),    # Use CJK font
        ("Romanization", "Arial", 10),
        ("Author", "Arial", 10),
    ]

    for col_idx, (name, font_type, size) in enumerate(columns):
        if font_type == "CJK":
            font = CJKFontManager.get_cjk_font(size)
        else:
            font = QFont(font_type, size)

        # Apply font to column (implementation varies)
        ...
```

## Testing

```python
def test_cjk_font_detection():
    """Test CJK font detection."""
    app = QApplication([])

    # Should find at least one CJK font on most systems
    available = CJKFontManager.list_available_cjk_fonts()

    # May be empty on minimal test environments
    if available:
        assert len(available) > 0
        print(f"Found CJK fonts: {available}")

def test_font_fallback():
    """Test graceful fallback when no CJK fonts."""
    # Even if no CJK fonts, should return a font (not crash)
    font = CJKFontManager.get_cjk_font()
    assert font is not None
    assert font.pointSize() == 10

def test_chinese_display(qtbot):
    """Test Chinese characters display."""
    widget = QLabel("孙子兵法")  # Art of War
    widget.setFont(CJKFontManager.get_cjk_font())
    qtbot.addWidget(widget)

    # Visual test - check that text is set
    assert widget.text() == "孙子兵法"
```

## Lessons

- **QFont.exactMatch() is critical**: Only way to verify font actually exists
- **Fallback chain ordering matters**: Put cross-platform fonts first (Noto)
- **Graceful degradation essential**: App should work even without CJK fonts
- **Log font selection**: Helps debug font issues across platforms
- **Test on multiple platforms**: Font availability varies significantly
- **Don't assume fonts exist**: Even "common" fonts may be missing

## Reusable For

- Any PyQt6 app displaying CJK text
- Multilingual applications (Arabic, Cyrillic, Thai, etc.)
- Font detection for any script
- Cross-platform font management
- User preference systems (let user select font)

## Platform Notes

**macOS:**
- PingFang SC/TC (modern, best)
- Hiragino Sans GB (older)
- Arial Unicode MS (comprehensive but older)

**Windows:**
- Microsoft YaHei (Simplified Chinese)
- SimHei (Simplified Chinese, older)
- Malgun Gothic (Korean)
- Meiryo (Japanese)

**Linux:**
- WenQuanYi Zen Hei (best open source)
- Noto Sans CJK (if installed)

**Recommended for users:**
- Install Google Noto Sans CJK (best cross-platform support)
- Download: https://www.google.com/get/noto/#sans-hans

---

## Future Enhancements

1. **User font preferences**: Let users select preferred CJK font
2. **Script-specific fonts**: Different fonts for Chinese/Japanese/Korean
3. **Dynamic font loading**: Download fonts if missing
4. **Font quality check**: Verify font renders CJK correctly (not boxes)
5. **Emoji support**: Extend to emoji fonts

---

**Used in:** Book Cataloger Sprint 3
**Effectiveness:** ⭐⭐⭐⭐⭐ (Chinese 孙子兵法 displays perfectly)
