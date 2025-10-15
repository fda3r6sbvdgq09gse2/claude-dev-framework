# Context Window Optimization
*Strategic Context Management for Multi-Agent Framework*
*Version: 1.0.0*

## 🎯 Overview

Claude Code has a **200,000 token context window** that must be managed strategically. This document provides battle-tested strategies to:

1. **Monitor** context usage with `/context` command
2. **Optimize** Opus usage with Plan Mode
3. **Clear** context strategically when no longer needed
4. **Load** only essential information
5. **Shutdown** gracefully to preserve state

**Based on**: [Official Claude Code Documentation](https://docs.claude.com/en/docs/claude-code/)

---

## 📊 Context Monitoring

### The `/context` Command

**Purpose**: Monitor token usage in real-time
**Syntax**: `/context`
**Frequency**: Check regularly, especially during complex tasks

```bash
# During Claude Code session
> /context

# Output shows:
# - Current tokens used
# - Remaining tokens
# - Percentage of context window used
```

### When to Check Context

| Situation | Action |
|-----------|--------|
| Starting complex task | Check baseline |
| After loading large files | Verify remaining capacity |
| Before strategic planning | Ensure enough space for Opus |
| Context feels slow | May be nearing limit |
| Before loading patterns | Check if you have room |

### Context Budget Guidelines

```yaml
Context Window: 200,000 tokens

Safe Zones:
  Green (0-60%):   0 - 120,000 tokens
    - Normal operations
    - Can load patterns freely
    - Can read multiple files

  Yellow (60-80%): 120,000 - 160,000 tokens
    - Start being selective
    - Load patterns by reference only
    - Consider clearing non-essential context

  Red (80%+):      160,000+ tokens
    - CRITICAL: Clear context immediately
    - Load only absolute essentials
    - Consider starting new session
```

---

## 🧠 Strategic Context Clearing

### What to Clear

**Clear Aggressively:**
- ✅ Old file contents no longer relevant
- ✅ Completed task context
- ✅ Debug output from successful fixes
- ✅ Exploratory code reading
- ✅ Documentation you've finished reading

**Keep:**
- ⚠️ Current task context
- ⚠️ Active file you're editing
- ⚠️ Error messages you're debugging
- ⚠️ Patterns you're currently using

### How to Clear Context

#### Method 1: Start Fresh Session
```bash
# Exit current session
> exit

# Start new session
claude

# Load only what you need
> "Continue with task: [specific task].
   Read only: [specific files needed]"
```

#### Method 2: Explicit Instruction
```bash
> "Let's clear context. Forget everything except:
   1. Current task: [task description]
   2. Key decision: [important decision made]
   3. Next steps: [what to do next]

   Now read [specific file] and continue."
```

#### Method 3: Use CLAUDE.md Imports
Instead of reading full files, use imports in CLAUDE.md:

```markdown
# CLAUDE.md
@.ai/context/current_task.md
@README.md
# Claude loads these on demand, not all at once
```

---

## 🎯 Optimizing Opus Usage

### The Problem

Opus 4 is **EXPENSIVE** and has **strict rate limits**:
- Cost: ~15x more than Sonnet
- Limit: Can burn through daily quota quickly
- Use case: Strategic planning, not implementation

### The Solution: Plan Mode

**Plan Mode** = Read-only Opus for strategic planning
**Based on**: [Plan Mode Workflow](https://docs.claude.com/en/docs/claude-code/common-workflows.md)

---

### When to Use Plan Mode (Opus)

| Use Plan Mode | Don't Use Plan Mode |
|---------------|---------------------|
| ✅ Architecture decisions | ❌ Simple bug fixes |
| ✅ Complex refactoring plans | ❌ Adding new function |
| ✅ Multi-file changes strategy | ❌ Updating tests |
| ✅ API integration approach | ❌ Code formatting |
| ✅ Performance optimization plan | ❌ Documentation updates |

---

### How to Use Plan Mode

#### Option 1: Start Session in Plan Mode
```bash
# Use Opus for planning only
claude --permission-mode plan --model opus-4

# Ask strategic question
> "Analyze our API integration architecture and propose
   a refactoring strategy to reduce coupling."

# Opus reads code, creates plan, NO changes made

# Exit and implement with Sonnet
> exit

# Start implementation session with Sonnet
claude --model sonnet-4

> "Implement the plan from previous session:
   [paste key points from Opus plan]"
```

#### Option 2: Switch Mid-Session
```bash
# During active Sonnet session
> "I need strategic planning for this. Let's use plan mode."

# Press Shift+Tab TWICE
# First press: Auto-accept mode
# Second press: Plan mode (⏸ plan mode on)

# Now using Opus for planning
> "Create comprehensive migration plan for OAuth2"

# Opus analyzes, plans, no changes

# Switch back to implementation
# Press Shift+Tab until auto-accept mode

# Continue with Sonnet
> "Implement step 1 of the plan"
```

#### Option 3: Headless Planning
```bash
# Run Opus planning query and save output
claude --permission-mode plan --model opus-4 \
  -p "Analyze authentication system and propose OAuth2 migration" \
  > .ai/plans/oauth2_migration.md

# Review plan
cat .ai/plans/oauth2_migration.md

# Implement with Sonnet
claude --model sonnet-4
> "Implement OAuth2 migration per plan in
   .ai/plans/oauth2_migration.md"
```

---

### Plan Mode Best Practices

```yaml
Before Planning Session:
  - Clear context: Start fresh
  - Load only: Architecture docs, key files
  - Set model: Opus 4 explicitly
  - Set mode: plan

During Planning:
  - Ask: High-level strategic questions
  - Request: Detailed step-by-step plans
  - Get: Reasoning and trade-offs
  - Don't: Ask for implementation

After Planning:
  - Save: Plan to .ai/plans/
  - Exit: Plan mode session
  - Switch: To Sonnet for implementation
  - Reference: Plan file during implementation
```

---

### Opus Budget Management

```yaml
Daily Budget Strategy:

  Opus Allocation (10% of daily budget):
    - Morning: Strategic planning session (30 min)
    - Mid-day: Complex decision (if needed)
    - End-of-day: Architecture review (if needed)

  Sonnet Allocation (90% of daily budget):
    - Implementation
    - Bug fixes
    - Testing
    - Documentation
    - Code review

Monthly Budget Example ($200/month):
  Opus:   $20 (10%)  → Strategic planning only
  Sonnet: $180 (90%) → All implementation

Actual book-cataloger Costs (8 sprints):
  Opus:   $5  (4%)   → Minimal strategic use
  Sonnet: $117 (96%) → Heavy implementation
  Total:  $122
```

---

## 🧠 Memory Management

### The Three-Tier Memory System

**Based on**: [Memory Documentation](https://docs.claude.com/en/docs/claude-code/memory.md)

```
Priority (loaded first to last):
1. Enterprise Memory  (N/A for solo devs)
2. User Memory        (~/.claude/CLAUDE.md)
3. Project Memory     (./CLAUDE.md)
```

---

### User Memory: Keep It Lean

**Location**: `~/.claude/CLAUDE.md`
**Purpose**: Personal preferences for ALL projects
**Token Budget**: < 5,000 tokens

```markdown
# Personal Claude Instructions

## Code Style Preferences
- TypeScript for new JS files
- Functional React components
- pytest for Python

## Workflow
- Check /context every 30 minutes
- Use plan mode for architecture
- Update .ai/context/current_task.md

## Framework
Using claude-multi-agent-framework.
Agents: Backend, Frontend, CEO, Integration, Testing.

## Import Essentials Only
@claude-dev-framework/docs/QUICK_START.md
```

**Bad** (too verbose):
```markdown
# DON'T DO THIS - Too much context!

[Paste entire framework documentation]
[Paste all patterns]
[Paste all agent profiles]
# This consumes 50,000+ tokens!
```

---

### Project Memory: Use Imports

**Location**: `./CLAUDE.md` or `./.claude/CLAUDE.md`
**Purpose**: Project instructions
**Token Budget**: < 10,000 tokens

```markdown
# Project: Book Cataloger

## Quick Context
- Purpose: Library management with ISBN scanning
- Stack: Python 3.11, Tkinter, OpenCV
- Current Sprint: 6B

## Architecture (by reference, not full paste)
@README.md
@.ai/context/current_task.md

## Standards (import, don't copy)
@.ai/rules/code_standards.md
@.ai/rules/module_size.md

## Agents
@~/.claude/agents/backend.md
@~/.claude/agents/frontend.md
```

**Import Depth Limit**: Max 5 hops
**Load Strategy**: On-demand, not all at once

---

### Pattern Library: Load Selectively

**Location**: `.ai/patterns/`
**Strategy**: Reference, don't load all

```bash
# BAD: Load everything
> "Read all files in .ai/patterns/ and apply them"
# This loads 20,000+ tokens

# GOOD: Load specific pattern
> "Apply the API retry pattern from
   .ai/patterns/api_integration.md section 'Retry Logic'"
# This loads < 1,000 tokens
```

**Pattern Organization**:
```
.ai/patterns/
├── api_integration.md        (Load when doing API work)
├── ui_patterns.md           (Load when doing UI)
├── testing_patterns.md      (Load when writing tests)
└── error_handling.md        (Load when handling errors)

Load ONE at a time, not all at once.
```

---

## 🚪 Graceful Shutdown Procedures

### When to Shutdown

| Situation | Action |
|-----------|--------|
| Context > 80% | Shutdown now, start fresh |
| Task completed | Shutdown, preserve state |
| Switching agents | Shutdown, load agent context |
| End of work session | Shutdown, save progress |
| Context feels slow | Shutdown, clear memory |

---

### Shutdown Checklist

```yaml
Before Shutdown:

1. Save Current State:
   > "Update .ai/context/current_task.md with:
      - What was accomplished
      - What's in progress
      - Next steps
      - Any critical decisions made"

2. Commit Working Code:
   > exit
   # Then in shell:
   git add [files]
   git commit -m "Save progress: [description]"

3. Document Key Information:
   # In .ai/context/session_notes.md
   - Blockers encountered
   - Patterns used
   - Files modified
   - Next session should focus on: [X]

4. Check Context Budget:
   > /context
   # If > 80%, definitely start fresh next time

5. Exit Cleanly:
   > exit
```

---

### Restart Strategy

```bash
# Starting new session after shutdown

# 1. Check what was saved
cat .ai/context/current_task.md
git log -1

# 2. Start Claude with minimal context
claude

# 3. Load ONLY essentials
> "Continue task: [brief description]
   Load only: [specific files needed]
   Context from: .ai/context/current_task.md"

# 4. Verify context
> /context
# Should be < 20% at start
```

---

## 🎛️ Settings for Context Optimization

### User Settings
**Location**: `~/.claude/settings.json`

```json
{
  "permissions": {
    "defaultMode": "auto-accept"
  },
  "memoryLoadStrategy": "lazy",
  "contextWarningThreshold": 0.8,
  "autoCompactContext": true
}
```

### Project Settings
**Location**: `.claude/settings.json`

```json
{
  "env": {
    "CONTEXT_OPTIMIZATION": "aggressive",
    "LOAD_PATTERNS_ON_DEMAND": "true"
  }
}
```

---

## 📈 Context Optimization Workflow

### Ideal Session Pattern

```yaml
Session Start (0-20% context):
  - Load: Current task only
  - Read: 1-2 key files
  - Check: /context

Active Work (20-60% context):
  - Implement: Current feature
  - Load: Patterns as needed (one at a time)
  - Check: /context every 30 min

Getting Full (60-80% context):
  - Stop: Loading new patterns
  - Focus: Complete current subtask
  - Prepare: For shutdown
  - Check: /context frequently

Critical (80%+ context):
  - Shutdown: Immediately
  - Save: All progress
  - Document: Current state
  - Restart: Fresh session
```

---

## 🚀 Quick Reference

### Commands
```bash
/context              # Check token usage
/memory               # Edit CLAUDE.md
/plan                 # Enter plan mode (if available)
Shift+Tab (x2)       # Enter plan mode
exit                  # Shutdown cleanly
```

### Opus Efficiency
```bash
# Strategic planning with Opus
claude --permission-mode plan --model opus-4

# Implementation with Sonnet
claude --model sonnet-4

# Budget: 90% Sonnet, 10% Opus
```

### Context Rules
```
✅ Check /context regularly
✅ Load patterns selectively
✅ Use imports, not full pastes
✅ Clear context at 60%+
✅ Shutdown at 80%+
✅ Start fresh sessions often

❌ Don't load all patterns
❌ Don't paste full docs
❌ Don't ignore context warnings
❌ Don't work past 80%
❌ Don't forget to save state
```

---

## 📚 References

**Official Claude Code Documentation:**
- [Memory Management](https://docs.claude.com/en/docs/claude-code/memory)
- [Plan Mode Workflow](https://docs.claude.com/en/docs/claude-code/common-workflows.md)
- [Settings Configuration](https://docs.claude.com/en/docs/claude-code/settings)
- [Slash Commands](https://docs.claude.com/en/docs/claude-code/slash-commands)

**Framework Documentation:**
- [Configuration Architecture](./CONFIGURATION_ARCHITECTURE.md)
- [Agent Employment Model](./AGENT_EMPLOYMENT_MODEL.md)
- [Single Source of Truth](./SINGLE_SOURCE_OF_TRUTH.md)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Based On:** Official Claude Code Documentation
**Token Budget for This Doc:** ~8,000 tokens (keep it reasonable!)
