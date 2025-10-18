---
name: python-testing
description: Our pytest conventions, test structure patterns, and coverage requirements
version: 1.0.0
author: Globex Systems / Blackford Inc.
tags: [python, pytest, testing, tdd, coverage, test-structure]
external_reference: https://docs.pytest.org/
last_updated: 2025-10-18
---

# Python Testing Skill

## Overview

This skill documents our Python testing conventions using pytest. We follow Test-Driven Development (TDD) principles with a focus on clear test structure, high coverage, and maintainable test code.

---

## Our Conventions

### Test File Organization

**Official way:** pytest discovers test files automatically

**Our way:** **Structured test directory mirroring src/**

**Why:**
- Clear test-to-source mapping
- Easy to find tests for any module
- Scalable as project grows

**Structure:**
```
project/
├── src/
│   ├── core/
│   │   ├── isbn_scanner.py
│   │   └── data_enrichment.py
│   └── api/
│       └── openlibrary_api.py
└── tests/
    ├── core/
    │   ├── test_isbn_scanner.py
    │   └── test_data_enrichment.py
    └── api/
        └── test_openlibrary_api.py
```

---

### Test Naming

**Our convention:**
```python
def test_{function_name}_{scenario}_{expected_result}():
    """Test description"""
```

**Examples:**
```python
def test_validate_isbn_with_valid_isbn13_returns_true():
    """Test ISBN validation with valid ISBN-13"""

def test_validate_isbn_with_invalid_checksum_returns_false():
    """Test ISBN validation rejects invalid checksum"""

def test_enrich_book_with_missing_api_raises_exception():
    """Test enrichment handles missing API gracefully"""
```

**Why:**
- Readable test names (self-documenting)
- Clear intent from name alone
- Easy to filter tests (`pytest -k "isbn"`)

---

### Test Structure (Arrange-Act-Assert)

**Our pattern:**
```python
def test_feature():
    # Arrange - Set up test data
    input_data = create_test_data()
    expected_output = define_expected_result()

    # Act - Execute the function under test
    actual_output = function_under_test(input_data)

    # Assert - Verify results
    assert actual_output == expected_output
```

**Real example:**
```python
def test_validate_isbn_with_valid_isbn13_returns_true():
    # Arrange
    valid_isbn13 = "978-0-596-52068-7"

    # Act
    result = validate_isbn(valid_isbn13)

    # Assert
    assert result is True
```

**Why:**
- Consistent test structure
- Easy to understand test flow
- Clear separation of concerns
- Maintainable tests

---

### Coverage Requirements

**Our standard:** **85% minimum coverage**

**Why 85%?**
- High enough to catch most issues
- Not so high that we test trivial code
- Industry best practice

**How to measure:**
```bash
# Run tests with coverage
pytest --cov=src tests/

# Generate HTML report
pytest --cov=src --cov-report=html tests/

# View report
open htmlcov/index.html
```

**What to exclude:**
```python
# .coveragerc
[run]
omit =
    */tests/*
    */venv/*
    */__init__.py
    */config.py
```

---

## Patterns We Use

### Pattern: Fixture-Based Test Data

**When to use:** Reusable test data across multiple tests

**How to implement:**
```python
import pytest

@pytest.fixture
def sample_book_data():
    """Provide sample book metadata for testing"""
    return {
        "isbn": "978-0-596-52068-7",
        "title": "Programming Python",
        "author": "Lutz, Mark",
        "year": 2010
    }

def test_create_book_with_valid_data(sample_book_data):
    # Arrange (using fixture)
    data = sample_book_data

    # Act
    book = Book.from_dict(data)

    # Assert
    assert book.isbn == data["isbn"]
    assert book.title == data["title"]
```

**Why it works:**
- DRY (Don't Repeat Yourself)
- Consistent test data
- Easy to update test data centrally

---

### Pattern: Parametrized Tests

**When to use:** Testing multiple inputs with same logic

**How to implement:**
```python
import pytest

@pytest.mark.parametrize("isbn,expected", [
    ("978-0-596-52068-7", True),   # Valid ISBN-13
    ("0-596-52068-9", True),        # Valid ISBN-10
    ("123-4-567-89012-3", False),  # Invalid checksum
    ("invalid", False),             # Invalid format
])
def test_validate_isbn_with_various_inputs(isbn, expected):
    # Act
    result = validate_isbn(isbn)

    # Assert
    assert result == expected
```

**Why it works:**
- Test many scenarios with minimal code
- Easy to add new test cases
- Clear documentation of edge cases

---

### Pattern: Mocking External Dependencies

**When to use:** Testing code that calls external APIs or services

**How to implement:**
```python
from unittest.mock import Mock, patch

def test_fetch_book_metadata_calls_api_correctly():
    # Arrange
    isbn = "978-0-596-52068-7"
    mock_response = {
        "title": "Programming Python",
        "authors": ["Mark Lutz"]
    }

    # Act
    with patch('src.api.openlibrary_api.requests.get') as mock_get:
        mock_get.return_value.json.return_value = mock_response
        result = fetch_book_metadata(isbn)

    # Assert
    assert result["title"] == "Programming Python"
    mock_get.assert_called_once_with(
        f"https://openlibrary.org/api/books?bibkeys=ISBN:{isbn}"
    )
```

**Why it works:**
- Fast tests (no real API calls)
- Deterministic (no network issues)
- Can test error scenarios easily

---

### Pattern: Test Exceptions

**When to use:** Testing error handling

**How to implement:**
```python
import pytest

def test_parse_isbn_with_invalid_input_raises_ValueError():
    # Arrange
    invalid_isbn = "not-an-isbn"

    # Act & Assert
    with pytest.raises(ValueError, match="Invalid ISBN format"):
        parse_isbn(invalid_isbn)
```

**Why it works:**
- Ensures error handling works
- Validates error messages
- Documents expected failures

---

## Patterns We Avoid

### Anti-pattern: Tests Without Assertions

**What:** Tests that run code but don't verify results

```python
# BAD
def test_create_book():
    book = Book("978-0-596-52068-7", "Test Book")
    # No assertion!
```

**Why we avoid:**
- Doesn't actually test anything
- Passes even if code is broken
- False confidence

**Alternative:**
```python
# GOOD
def test_create_book():
    book = Book("978-0-596-52068-7", "Test Book")
    assert book.isbn == "978-0-596-52068-7"
    assert book.title == "Test Book"
```

---

### Anti-pattern: Testing Implementation Details

**What:** Testing internal methods instead of public API

```python
# BAD - testing private method
def test_internal_isbn_validation():
    validator = ISBNValidator()
    assert validator._calculate_checksum("978059652068") == 7
```

**Why we avoid:**
- Brittle (breaks when refactoring)
- Couples tests to implementation
- Misses actual behavior

**Alternative:**
```python
# GOOD - testing public interface
def test_validate_isbn_with_valid_isbn13():
    assert validate_isbn("978-0-596-52068-7") is True
```

---

### Anti-pattern: Overly Complex Tests

**What:** Tests with loops, conditionals, complex logic

```python
# BAD - test has complex logic
def test_multiple_books():
    books = [create_book(i) for i in range(10)]
    for book in books:
        if book.year > 2000:
            assert book.is_modern
        else:
            assert not book.is_modern
```

**Why we avoid:**
- Tests should be simple and obvious
- Complex tests are hard to debug
- Who tests the tests?

**Alternative:**
```python
# GOOD - simple, focused tests
def test_book_published_after_2000_is_modern():
    book = Book(isbn="...", year=2005)
    assert book.is_modern is True

def test_book_published_before_2000_is_not_modern():
    book = Book(isbn="...", year=1995)
    assert book.is_modern is False
```

---

## Learned the Hard Way

### Lesson 1: Always Use Virtual Environments

**Problem:** Tests pass locally, fail in CI

**Cause:** Different Python versions or dependencies

**Solution:**
```bash
# Always activate venv before running tests
source venv/bin/activate

# Verify correct Python
which python  # Should show venv path

# Run tests
pytest
```

---

### Lesson 2: Isolate Test Data

**Problem:** Tests interfere with each other

**Cause:** Shared mutable test data

**Solution:**
```python
# BAD - shared mutable data
SHARED_DATA = {"count": 0}

def test_one():
    SHARED_DATA["count"] += 1  # Mutates shared state

def test_two():
    assert SHARED_DATA["count"] == 0  # Fails if test_one ran first!

# GOOD - isolated data via fixtures
@pytest.fixture
def test_data():
    return {"count": 0}  # Fresh data each time

def test_one(test_data):
    test_data["count"] += 1  # Isolated

def test_two(test_data):
    assert test_data["count"] == 0  # Always passes
```

---

### Lesson 3: Test File I/O Carefully

**Problem:** Tests create/modify files, causing side effects

**Solution:** Use `tmp_path` fixture
```python
def test_save_book_to_file(tmp_path):
    # Arrange
    book = Book("978-0-596-52068-7", "Test")
    file_path = tmp_path / "book.json"

    # Act
    save_book(book, file_path)

    # Assert
    assert file_path.exists()
    # Cleanup automatic (tmp_path is deleted after test)
```

---

## Quick Reference

### Running Tests

```bash
# All tests
pytest

# Specific file
pytest tests/core/test_isbn_scanner.py

# Specific test
pytest tests/core/test_isbn_scanner.py::test_validate_isbn

# With coverage
pytest --cov=src tests/

# Verbose output
pytest -v

# Stop on first failure
pytest -x

# Show print statements
pytest -s

# Run tests matching pattern
pytest -k "isbn"
```

---

### Coverage Commands

```bash
# Basic coverage report
pytest --cov=src tests/

# HTML report
pytest --cov=src --cov-report=html tests/

# Missing lines report
pytest --cov=src --cov-report=term-missing tests/

# Fail if coverage below 85%
pytest --cov=src --cov-fail-under=85 tests/
```

---

### Useful pytest Markers

```python
import pytest

# Skip test
@pytest.mark.skip(reason="Not implemented yet")
def test_future_feature():
    pass

# Skip conditionally
@pytest.mark.skipif(sys.version_info < (3, 9), reason="Requires Python 3.9+")
def test_modern_python():
    pass

# Mark as slow
@pytest.mark.slow
def test_long_running_operation():
    pass

# Run slow tests with: pytest -m slow
# Skip slow tests with: pytest -m "not slow"
```

---

## Related

**Internal:**
- `implementation/testing-strategy.md` - Overall testing approach
- `skills/git-workflow/SKILL.md` - How we commit tests

**External:**
- pytest docs: https://docs.pytest.org/
- Coverage.py: https://coverage.readthedocs.io/
- unittest.mock: https://docs.python.org/3/library/unittest.mock.html

**Examples:**
- See `tests/` directory for real examples
- All our tests follow these patterns

---

## Changelog

- **2025-10-18:** Initial version with core testing patterns
- **2025-10-13:** Established 85% coverage requirement
- **2025-10-11:** Adopted Arrange-Act-Assert pattern

---

**Status:** 🟢 Active - This is our current testing approach
**Last Updated:** October 18, 2025
