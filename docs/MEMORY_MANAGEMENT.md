# Memory Management
*World-Class Memory Setup for Claude Multi-Agent Framework*
*Based on: [Official Memory Documentation](https://docs.claude.com/en/docs/claude-code/memory)*

---

## 🎯 Overview

Claude Code uses **memory files (CLAUDE.md)** to load instructions and context at session start. Proper memory management is **critical** for:

1. **Context Efficiency**: Load only what's needed
2. **Token Optimization**: Stay under 200k token limit
3. **Session Continuity**: Maintain state across sessions
4. **Team Consistency**: Share project standards

---

## 📚 The Three-Tier Memory System

**Based on**: [Memory Hierarchy](https://docs.claude.com/en/docs/claude-code/memory)

```
Priority (loaded in order):
1. Enterprise Memory     (N/A for solo/small teams)
2. User Memory          (~/.claude/CLAUDE.md)
3. Project Memory       (./CLAUDE.md or ./.claude/CLAUDE.md)

Later memories override earlier ones.
```

---

## 👤 User Memory

### Location
```bash
~/.claude/CLAUDE.md
```

### Purpose
**Personal preferences** that apply to **ALL your projects**.

### Scope
- Individual developer
- Persists across all projects
- Not in version control

### What Belongs Here

✅ **DO include**:
- Personal code style preferences
- Your workflow habits
- Tools you use (editor, terminal)
- Communication style preferences
- Framework agent references

❌ **DON'T include**:
- Project-specific information
- Team standards (put in project memory)
- Large documentation (use imports)
- Secrets or personal info

### Token Budget
**Target**: < 5,000 tokens (keep it lean!)

### Template
```bash
# Use our template
cp ~/dev/claude-dev-framework/config/memory/user-CLAUDE.md ~/.claude/CLAUDE.md

# Edit with your preferences
code ~/.claude/CLAUDE.md
```

### Example User Memory

```markdown
# Personal Claude Instructions

## Framework
Using claude-multi-agent-framework with persistent agents.

## Code Style
- Python: Type hints always, Black formatting, pytest
- TypeScript: Prefer functional components, named exports
- Line length: 100 characters

## Workflow
- Check /context every 30 minutes
- Load patterns selectively (one at a time)
- Commit after each completed subtask

## Communication
- Prefer concise explanations
- Always ask before destructive operations
- Detailed code comments appreciated

## Import Agents
@~/.claude/agents/backend.md
@~/.claude/agents/frontend.md
@~/.claude/agents/ceo.md

## Framework Docs (reference only)
@~/dev/claude-dev-framework/docs/CONFIGURATION_ARCHITECTURE.md
```

---

## 📁 Project Memory

### Location

**Option 1**: Project root (recommended for visibility)
```bash
your-project/
└── CLAUDE.md
```

**Option 2**: In `.claude/` directory (recommended for organization)
```bash
your-project/
└── .claude/
    └── CLAUDE.md
```

Both work! Choose based on preference.

### Purpose
**Team-shared project instructions** for this specific project.

### Scope
- Entire team
- This project only
- Checked into git
- Versioned with code

### What Belongs Here

✅ **DO include**:
- Project architecture overview
- Tech stack and frameworks used
- Current sprint/task references
- Code standards for this project
- Testing requirements
- Deployment instructions
- Import references to detailed docs

❌ **DON'T include**:
- Personal preferences (put in user memory)
- Full documentation (use imports)
- Secrets or credentials
- Generated code
- Large file contents (use imports)

### Token Budget
**Target**: < 10,000 tokens

### Template
```bash
# Copy template to your project
cp ~/dev/claude-dev-framework/config/memory/project-CLAUDE.md your-project/CLAUDE.md

# Or to .claude/ directory
mkdir -p your-project/.claude
cp ~/dev/claude-dev-framework/config/memory/project-CLAUDE.md your-project/.claude/CLAUDE.md

# Edit for your project
code your-project/CLAUDE.md
```

### Example Project Memory

```markdown
# Project: Book Cataloger

## Architecture
- Backend: Python FastAPI
- Frontend: Tkinter (native macOS)
- Database: SQLite with normalized schema
- Testing: pytest + Playwright

## Current Work
@.ai/context/current_task.md

## Standards
@.ai/rules/code_standards.md
@.ai/rules/module_size.md

## Patterns
@.ai/patterns/api_integration.md

## Testing
- Coverage target: 85%
- Run: `pytest tests/`
- E2E: `playwright test`

## Agents Active
- Backend, Frontend, Integration, Testing, CEO

## Import User Prefs
@~/.claude/CLAUDE.md
```

---

## 🔗 Memory Imports

### Syntax

```markdown
@path/to/file
@relative/path
@~/absolute/from/home
```

### How Imports Work

- **On-Demand Loading**: Files referenced with `@` are loaded when needed
- **Not Recursive in Code**: Imports inside code blocks are ignored
- **Max Depth**: 5 hops maximum
- **Relative Paths**: Relative to the CLAUDE.md file location

### Import Best Practices

✅ **DO**:
```markdown
# Import references (lightweight)
@README.md
@.ai/context/current_task.md
@.ai/patterns/api_integration.md

# Import from home directory
@~/.claude/agents/backend.md
```

❌ **DON'T**:
```markdown
# Don't import huge files
@node_modules/package/README.md  # Too large!

# Don't import generated files
@dist/bundle.js  # Generated code

# Don't import binary files
@image.png  # Not text
```

### Conditional Imports

```markdown
## Backend Work
@.ai/patterns/api_integration.md

## Frontend Work
@.ai/patterns/ui_patterns.md

## Testing
@.ai/patterns/testing_patterns.md

# Claude loads these sections contextually based on task
```

---

## 🎯 Memory Optimization Strategies

### 1. Use Imports, Not Full Content

❌ **Bad** (wastes tokens):
```markdown
# Code Standards

[Paste entire 5000-line code standards document]
```

✅ **Good** (efficient):
```markdown
# Code Standards
@.ai/rules/code_standards.md
```

### 2. Structure for Selectivity

```markdown
# Project Memory

## Always Load
- Project name: Book Cataloger
- Stack: Python + FastAPI

## Load on Demand
### Backend Work
@.ai/patterns/api_integration.md

### Frontend Work
@.ai/patterns/ui_patterns.md

### Testing
@.ai/patterns/testing_patterns.md
```

### 3. Keep Summaries, Reference Details

✅ **Good**:
```markdown
## Architecture

**Backend**: Python FastAPI
- API routes in `src/api/`
- Services in `src/services/`

Full details: @ARCHITECTURE.md
```

### 4. Use Contextual Sections

```markdown
## When Working on APIs
- Review: @.ai/patterns/api_integration.md
- Standards: @.ai/rules/api_standards.md

## When Working on UI
- Review: @.ai/patterns/ui_patterns.md
- Components: @src/ui/README.md
```

---

## 🔄 Memory Discovery & Loading

### How Claude Finds Memory

1. **Recursive Search**: Looks for CLAUDE.md in current directory and parent directories
2. **Priority**: Project-level overrides user-level
3. **Merge**: Both are loaded and merged (project wins conflicts)

### Loading Order

```
1. Enterprise (N/A for us)
2. ~/.claude/CLAUDE.md (your personal preferences)
3. ./CLAUDE.md or ./.claude/CLAUDE.md (project specifics)
4. Imports are resolved from these files
```

---

## ✏️ Quick Add Memories

### Using the `#` Shortcut

During a Claude session:

```
# Add to memory quickly
> # Remember: We use pytest-asyncio for async tests

# This gets added to current project's CLAUDE.md
```

### Using `/memory` Command

```
> /memory

# Opens CLAUDE.md for editing
```

---

## 📊 Memory Token Budget

### Recommended Budgets

```yaml
User Memory (~/.claude/CLAUDE.md):
  Target: 5,000 tokens
  Maximum: 10,000 tokens

Project Memory (./CLAUDE.md):
  Target: 10,000 tokens
  Maximum: 20,000 tokens

Total Memory Budget:
  Target: 15,000 tokens (7.5% of 200k)
  Maximum: 30,000 tokens (15% of 200k)

Remaining for Active Context:
  170,000+ tokens available for actual work
```

### Check Token Usage

```bash
# Count approximate tokens (rough estimate: 1 token ≈ 4 characters)
wc -c ~/.claude/CLAUDE.md
wc -c ./CLAUDE.md

# Should be:
# ~/.claude/CLAUDE.md:     ~20,000 characters (5k tokens)
# ./CLAUDE.md:             ~40,000 characters (10k tokens)
```

---

## 🔧 Memory Maintenance

### Regular Reviews

**User Memory**: Review quarterly
```bash
# Review and update
code ~/.claude/CLAUDE.md

# Check size
wc -c ~/.claude/CLAUDE.md
```

**Project Memory**: Review at sprint start
```bash
# Update current task
code .claude/CLAUDE.md

# Or in project root
code CLAUDE.md
```

### Cleanup Checklist

- [ ] Remove outdated information
- [ ] Update task references
- [ ] Verify imports still exist
- [ ] Check token budget
- [ ] Remove completed TODOs
- [ ] Update agent list if changed

---

## 🎯 Best Practices Summary

### ✅ DO

1. **Keep it Lean**: < 5k tokens user, < 10k tokens project
2. **Use Imports**: Reference files, don't paste content
3. **Structure Contextually**: Section by when it's needed
4. **Update Regularly**: Keep current task fresh
5. **Separate Concerns**: User vs Project memory
6. **Version Control**: Commit project memory
7. **Test Imports**: Ensure referenced files exist

### ❌ DON'T

1. **Don't Paste Docs**: Use imports instead
2. **Don't Include Secrets**: Never in memory files
3. **Don't Overload**: Respect token budgets
4. **Don't Duplicate**: If it's in user memory, don't repeat in project
5. **Don't Import Large Files**: Be selective
6. **Don't Leave Stale Info**: Update regularly
7. **Don't Put Personal in Project**: Keep separation

---

## 📋 Setup Checklist

### One-Time User Setup

```bash
# 1. Create user memory directory
mkdir -p ~/.claude

# 2. Copy template
cp ~/dev/claude-dev-framework/config/memory/user-CLAUDE.md ~/.claude/CLAUDE.md

# 3. Customize with your preferences
code ~/.claude/CLAUDE.md

# 4. Verify size (should be < 20KB)
wc -c ~/.claude/CLAUDE.md
```

### Per-Project Setup

```bash
cd your-project

# 1. Copy template (choose location)
# Option A: Project root
cp ~/dev/claude-dev-framework/config/memory/project-CLAUDE.md ./CLAUDE.md

# Option B: .claude directory
mkdir -p .claude
cp ~/dev/claude-dev-framework/config/memory/project-CLAUDE.md .claude/CLAUDE.md

# 2. Customize for your project
code CLAUDE.md  # or .claude/CLAUDE.md

# 3. Commit to git
git add CLAUDE.md  # or .claude/CLAUDE.md
git commit -m "Add Claude memory configuration"

# 4. Verify size (should be < 40KB)
wc -c CLAUDE.md
```

---

## 🐛 Troubleshooting

### Memory Not Loading

```bash
# Check if file exists
ls -la ~/.claude/CLAUDE.md
ls -la ./CLAUDE.md
ls -la ./.claude/CLAUDE.md

# Check file is readable
cat ~/.claude/CLAUDE.md

# Verify no syntax errors (should be valid Markdown)
```

### Imports Not Working

```bash
# Check import path exists
# In CLAUDE.md: @.ai/context/current_task.md
ls -la .ai/context/current_task.md

# Use absolute path if needed
@~/dev/your-project/.ai/context/current_task.md
```

### Too Much Memory Loaded

```bash
# Check total size
wc -c ~/.claude/CLAUDE.md
wc -c ./CLAUDE.md

# If too large:
1. Remove duplicated content
2. Convert content to imports
3. Remove completed/stale sections
```

---

## 📚 Resources

**Official Documentation**:
- [Memory Management](https://docs.claude.com/en/docs/claude-code/memory)
- [Quick Add with #](https://docs.claude.com/en/docs/claude-code/memory#quickly-add-memories)
- [Memory Best Practices](https://docs.claude.com/en/docs/claude-code/memory#memory-best-practices)

**Framework Documentation**:
- [Configuration Architecture](./CONFIGURATION_ARCHITECTURE.md)
- [Context Optimization](./CONTEXT_OPTIMIZATION.md)

**Templates**:
- User Memory: `config/memory/user-CLAUDE.md`
- Project Memory: `config/memory/project-CLAUDE.md`

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Based On**: Official Claude Code Memory Documentation
