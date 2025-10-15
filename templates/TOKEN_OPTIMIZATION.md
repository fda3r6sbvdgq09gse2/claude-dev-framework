# Token Optimization Strategies
**Version:** 1.0
**Purpose:** Minimize token usage while maintaining quality in AI-assisted development
**Framework:** Part of Parallel Development Framework

---

## 🎯 Why Token Optimization Matters

### Cost Perspective
| Model | Input ($/1M tokens) | Output ($/1M tokens) | Use Case |
|-------|---------------------|----------------------|----------|
| Opus 4 | $15 | $75 | Architecture, complex decisions |
| Sonnet 4.5 | $3 | $15 | Implementation, most work |
| Haiku 3.5 | $0.80 | $4 | Tests, docs, simple tasks |

**Example Savings:**
- Bad: 200k tokens × Opus 4 = $3 + $15 = **$18**
- Good: 50k tokens × Opus 4 + 150k tokens × Sonnet = $0.75 + $4.50 + $2.25 = **$7.50** (58% savings)

### Performance Perspective
- **Smaller context = Lower latency**
- **Focused context = Better quality**
- **Less reading = Faster iteration**

---

## 📊 Token Usage Patterns

### Typical Session Breakdown

```
Total: 200k tokens
├─ System prompt: 5k (2.5%)
├─ Project context: 30k (15%)
│  ├─ Architecture docs: 10k
│  ├─ Code standards: 5k
│  └─ Current state: 15k
├─ Code reading: 100k (50%)
│  ├─ Necessary files: 40k
│  └─ Unnecessary files: 60k  ⚠️ WASTE
├─ User messages: 15k (7.5%)
└─ Assistant responses: 50k (25%)
```

**Optimization Target:** Eliminate that 60k of unnecessary reading!

---

## 🔧 Optimization Techniques

### 1. Lazy Context Loading

❌ **BAD - Eager Loading:**
```
Session starts:
→ Load entire codebase structure (50k tokens)
→ Read all relevant modules (80k tokens)
→ Load all documentation (20k tokens)
Total: 150k tokens before doing anything
```

✅ **GOOD - Lazy Loading:**
```
Session starts:
→ Load only task description (2k tokens)
→ Read files as needed during work (30k tokens total)
Total: 32k tokens, 78% savings
```

**Implementation:**
```markdown
# Context file structure

## Your Task
[Specific task description]

## Files You'll Need
Check these files ONLY when you need them:
- src/ui/language_selector.py (new file - create it)
- src/core/language_registry.py (import reference - read if needed)
- .ai/patterns/ui_patterns.md (patterns - read if needed)

## DO NOT read proactively
- Other UI files (unless you need to understand patterns)
- Backend code (you won't touch it)
- Test files (create new ones)
```

---

### 2. Reference by Path, Not Content

❌ **BAD:**
````
Here's the LanguageRegistry class:
```python
[Paste 500 lines of code]
```
Now use it in your widget.
````
Tokens: ~2000

✅ **GOOD:**
```
Use the LanguageRegistry from src/core/language_registry.py

Key API:
- get_language_registry() -> LanguageRegistry
- registry.get_all_languages() -> List[Tuple[str, Language]]
- registry.get_display_name(code: str) -> str

Read the file if you need implementation details.
```
Tokens: ~100 (95% savings)

---

### 3. Incremental Context Building

❌ **BAD - Start with Everything:**
```
Session 1: Load 100 files, implement 1 feature
Session 2: Load 100 files again, implement 1 feature
Session 3: Load 100 files again, implement 1 feature
Total: 300k tokens of loading
```

✅ **GOOD - Incremental:**
```
Session 1: Load task (2k) + create stub (write 5k) = 7k tokens
Session 2: Load previous + add logic (read 5k + write 8k) = 13k tokens
Session 3: Load current + add tests (read 8k + write 10k) = 18k tokens
Total: 38k tokens (87% savings)
```

**Pattern:**
```markdown
# Session 1
Task: Create LanguageSelector skeleton
Context: Task description only
Output: Class stub with method signatures

# Session 2
Task: Implement autocomplete
Context: Previous session's code + task
Output: Working autocomplete

# Session 3
Task: Add custom language dialog
Context: Current file + task
Output: Complete feature
```

---

### 4. Agent-Based Search

❌ **BAD - Read Everything:**
```
To find all usages of 'language_code':
1. Read 20 files (40k tokens)
2. Manually scan for the pattern
3. Report findings
Total: 45k tokens
```

✅ **GOOD - Use Search Agent:**
```
Use Task tool with search agent:
"Find all usages of 'language_code' in src/"

Agent uses grep internally, returns results
Total: 5k tokens (89% savings)
```

**When to use search agents:**
- Finding function definitions
- Locating all imports of a module
- Discovering similar patterns
- Dependency analysis

---

### 5. Hierarchical Context

Structure context from general to specific, allow stopping early:

```markdown
# Level 1: Executive Summary (500 tokens)
- What: Language selector widget
- Why: User needs to choose book language
- Where: src/ui/language_selector.py
- Status: Not started

# Level 2: Technical Approach (1k tokens)
[Only read if you need implementation guidance]
- Use tk.Combobox for dropdown
- Integrate with LanguageRegistry
- Add autocomplete functionality

# Level 3: Detailed Specifications (5k tokens)
[Only read if you need specific details]
- Event handling details
- Edge cases
- Integration points

# Level 4: Code Examples (10k tokens)
[Only read if you need reference implementations]
- Similar widget implementations
- Integration examples
```

**Usage:**
- Simple task: Read Level 1 only (500 tokens)
- Medium task: Read Levels 1-2 (1.5k tokens)
- Complex task: Read all levels (16.5k tokens)

---

### 6. Caching Strategy

Use Claude's prompt caching effectively:

```python
# Structure prompts to maximize cache hits

# CACHED (changes rarely)
system_prompt = """
You are a GUI specialist.
[Role description - 2k tokens]
"""

coding_standards = """
[Project coding standards - 5k tokens]
"""

ui_patterns = """
[UI implementation patterns - 8k tokens]
"""

# NOT CACHED (changes frequently)
current_task = """
[Specific task for this session - 2k tokens]
"""

current_code = """
[Code being worked on - varies]
"""
```

**Result:**
- First request: 17k tokens charged
- Subsequent requests: 2k tokens + code (cache hit on 15k tokens)
- Savings: 88% on repeated context

---

### 7. Summarization Pattern

For long files or complex codebases:

❌ **BAD:**
```
Here's the entire enrichment_orchestrator.py (1000 lines, 4k tokens):
[Full file content]
```

✅ **GOOD:**
```
enrichment_orchestrator.py summary:
- Purpose: Coordinates data enrichment from multiple APIs
- Key classes: EnrichmentOrchestrator
- Key methods:
  - enrich_isbn(isbn) -> BookMetadata
  - _merge_api_responses(responses) -> dict
- Integration: Called by UI after ISBN scan

[Read full file only if you need to modify it]
```
Tokens: 200 tokens (95% savings)

**Auto-summarization script:**
```python
# .ai/scripts/summarize_file.py

def summarize_python_file(filepath):
    """Generate token-efficient summary of Python file."""
    # Extract: docstring, class names, public methods, key logic
    # Skip: implementation details, private methods
    return summary
```

---

### 8. Diff-Based Updates

When working on existing code:

❌ **BAD:**
````
Current file (500 lines, 2k tokens):
```python
[Entire file]
```

Make this change: [...]
````

✅ **GOOD:**
```
File: src/ui/language_selector.py
Current state: Implements basic dropdown

Change needed: Add autocomplete on line 45
Context (lines 40-50 only):
[Show only relevant section]

Make the change.
```
Tokens: 300 tokens (85% savings)

---

### 9. Smart Tool Selection

Choose the most efficient tool:

| Task | Bad Tool | Good Tool | Savings |
|------|----------|-----------|---------|
| Find files | Read many files | Glob pattern | 90% |
| Search code | Read all files | Grep | 85% |
| Simple edit | Read + Write | Edit tool | 70% |
| Create file | Read old + Write | Write only | 100% |

**Example:**
```bash
# Find all test files
❌ BAD: Read 50 files to find tests (100k tokens)
✅ GOOD: Glob "tests/**/*.py" (1k tokens)

# Search for function usage
❌ BAD: Read 30 files (60k tokens)
✅ GOOD: Grep "def process_isbn" (2k tokens)

# Edit one function
❌ BAD: Read 500 lines, write 500 lines (4k tokens)
✅ GOOD: Edit tool, change 10 lines (0.5k tokens)
```

---

### 10. Batch Operations

Group related operations:

❌ **BAD - Sequential:**
```
Request 1: Create file A (2k tokens context)
Request 2: Create file B (2k tokens context)
Request 3: Create file C (2k tokens context)
Total: 6k tokens context overhead
```

✅ **GOOD - Batched:**
```
Request: Create files A, B, C in one go
Total: 2k tokens context overhead
Savings: 67%
```

---

## 📈 Measuring Token Usage

### Built-in Monitoring

```python
# Track token usage per session

import anthropic

client = anthropic.Anthropic()

response = client.messages.create(
    model="claude-sonnet-4.5-20250929",
    max_tokens=4096,
    messages=[{"role": "user", "content": "Hello"}]
)

print(f"Input tokens: {response.usage.input_tokens}")
print(f"Output tokens: {response.usage.output_tokens}")
print(f"Total tokens: {response.usage.input_tokens + response.usage.output_tokens}")
```

### Custom Tracking

```bash
# .ai/scripts/token_tracker.sh

#!/bin/bash
# Log token usage for each worktree session

LOG_FILE=".ai/logs/token_usage.csv"

echo "$(date),worktree,task,input_tokens,output_tokens,total_cost" >> $LOG_FILE

# Parse from Claude Code output or API logs
```

### Budget Alerts

```python
# .ai/scripts/token_budget.py

class TokenBudget:
    def __init__(self, monthly_limit=10_000_000):
        self.monthly_limit = monthly_limit
        self.current_usage = self.load_usage()

    def check_budget(self, estimated_tokens):
        if self.current_usage + estimated_tokens > self.monthly_limit:
            print("⚠️  WARNING: Approaching token budget limit!")
            print(f"   Used: {self.current_usage:,} / {self.monthly_limit:,}")
            print(f"   Remaining: {self.monthly_limit - self.current_usage:,}")
            return False
        return True

    def suggest_model_downgrade(self):
        """Suggest cheaper model if budget running low."""
        if self.current_usage > 0.8 * self.monthly_limit:
            return "haiku-3.5"  # Switch to cheaper model
        return "sonnet-4.5"
```

---

## 🎯 Optimization by Development Phase

### Phase 1: Architecture (Opus 4)

**Budget:** 10% of tokens
**Strategy:** High-quality planning to reduce iteration

```markdown
Task: Design parallel development strategy

Context (minimal):
- Project goals
- Team size
- Timeline

Output:
- Workstream definitions
- File ownership map
- Integration plan

Tokens: ~20k (but saves 100k+ in implementation)
```

### Phase 2: Implementation (Sonnet 4.5)

**Budget:** 60% of tokens
**Strategy:** Focused context, incremental building

```markdown
Per worktree session:
- Task description: 2k
- Relevant files only: 10-20k
- Incremental changes: 5-10k

Total per session: 17-32k tokens
```

### Phase 3: Testing (Haiku 3.5)

**Budget:** 15% of tokens
**Strategy:** Use cheaper model for repetitive work

```markdown
Task: Generate tests for module

Context:
- Module to test: 5k
- Test patterns: 3k

Output: Test file: 8k

Total: 16k tokens at Haiku pricing
```

### Phase 4: Integration (Sonnet 4.5)

**Budget:** 15% of tokens
**Strategy:** Targeted review and merge

```markdown
Task: Review and integrate worktrees

Context:
- Conflict report: 2k
- Changed files: 20k
- Integration plan: 3k

Total: 25k tokens
```

---

## 💰 Cost Optimization Examples

### Example 1: New Feature Development

**Scenario:** Add language selector widget (typical feature)

**Naive Approach:**
```
Session 1 (Opus 4): Understand codebase (100k tokens) = $1.50 + $7.50 = $9.00
Session 2 (Opus 4): Implement widget (100k tokens) = $9.00
Session 3 (Opus 4): Add tests (100k tokens) = $9.00
Total: $27.00
```

**Optimized Approach:**
```
Session 1 (Opus 4): Design approach (20k tokens) = $0.30 + $1.50 = $1.80
Session 2 (Sonnet): Implement (30k tokens) = $0.09 + $0.45 = $0.54
Session 3 (Haiku): Tests (20k tokens) = $0.02 + $0.08 = $0.10
Session 4 (Sonnet): Integration (15k tokens) = $0.05 + $0.23 = $0.28
Total: $2.72 (90% savings!)
```

### Example 2: Bug Fix

**Naive:**
```
Read entire codebase to find bug (150k tokens × Sonnet) = $1.95
```

**Optimized:**
```
Use grep agent to find relevant code (5k tokens × Sonnet) = $0.06
Read only relevant files (10k tokens × Sonnet) = $0.13
Total: $0.19 (90% savings)
```

### Example 3: Refactoring

**Naive:**
```
Read all files (200k tokens × Opus) = $18.00
```

**Optimized:**
```
Use AST parser to analyze structure (10k tokens × Sonnet) = $0.28
Read only files needing changes (50k tokens × Sonnet) = $0.90
Total: $1.18 (93% savings)
```

---

## 🔬 Advanced Techniques

### 1. Context Compression

```python
# Compress large codebases into minimal context

def compress_codebase_context(directory):
    """Create minimal context file."""
    context = {
        "structure": generate_tree(directory),  # File tree
        "apis": extract_public_apis(directory),  # Public interfaces
        "patterns": identify_patterns(directory),  # Common patterns
    }

    # Output: 5k tokens instead of 100k tokens
    return context
```

### 2. Differential Context

```python
# Only load what changed since last session

def differential_context(previous_session, current_session):
    """Load only new/changed context."""
    changes = git_diff(previous_session, current_session)

    context = {
        "new_files": changes.added,
        "modified_files": changes.modified,
        "deleted_files": changes.deleted,
    }

    # Tokens: Only changed content, not entire codebase
    return context
```

### 3. Smart Caching with Versions

```python
# Version context for better cache hits

context_template = f"""
# Project Context v2.1 (cache this)
{project_description}
{coding_standards}
{architecture}

# Current Task (don't cache)
{current_task}
"""

# v2.1 stays cached across many sessions
# Only current_task changes
```

---

## 📋 Optimization Checklist

### Before Starting Session

- [ ] Define specific task (not "improve the system")
- [ ] Identify minimum files needed
- [ ] Choose appropriate model for task
- [ ] Prepare focused context (< 20k tokens)
- [ ] Check if search agent can help

### During Session

- [ ] Use lazy loading (read files when needed)
- [ ] Use Edit tool for small changes
- [ ] Use Grep/Glob before Read
- [ ] Batch related operations
- [ ] Stop reading when you have enough info

### After Session

- [ ] Log token usage
- [ ] Update context for next session
- [ ] Review: Could this have been done cheaper?
- [ ] Document learnings

---

## 🎓 Best Practices Summary

1. **Right Model for Job**
   - Opus: Architecture, complex reasoning
   - Sonnet: Most implementation work
   - Haiku: Tests, docs, simple tasks

2. **Lazy Loading**
   - Don't load files until needed
   - Reference by path, not content
   - Use hierarchical context

3. **Smart Tools**
   - Grep/Glob for searching
   - Edit for small changes
   - Task agents for complex searches

4. **Incremental Building**
   - Start with skeleton
   - Add functionality incrementally
   - Build on previous work

5. **Caching**
   - Structure prompts for cache hits
   - Separate static vs dynamic context
   - Version stable context

6. **Measurement**
   - Track token usage
   - Monitor budget
   - Learn from expensive sessions

---

## 📚 Related Documents

- [Parallel Development Framework](PARALLEL_DEV_FRAMEWORK.md)
- [Agent Templates](AGENT_TEMPLATES.md)
- [Worktree Setup Guide](WORKTREE_GUIDE.md)

---

**Version:** 1.0
**Last Updated:** 2025-10-10
**License:** MIT

**Remember:** The best token is the one you don't use! 🎯
