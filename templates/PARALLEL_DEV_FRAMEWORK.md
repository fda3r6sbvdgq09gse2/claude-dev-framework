# Parallel Development Framework for AI-Assisted Projects
**Version:** 1.0
**Last Updated:** 2025-10-10
**Purpose:** Maximize development velocity through parallel workstreams using git worktrees, specialized agents, and multi-model orchestration

---

## 🎯 Framework Overview

### Core Principles
1. **Isolation:** Each workstream operates in isolated git worktree
2. **Specialization:** Custom agents with focused context and expertise
3. **Token Efficiency:** Minimal context overlap, maximum reuse
4. **Speed:** Parallel execution across multiple Claude sessions/accounts
5. **Quality:** Coordinated integration with automated testing

### When to Parallelize
✅ **YES - Parallelize when:**
- Multiple independent features (no shared files)
- Large feature can be decomposed (UI + backend + tests)
- Repetitive tasks across modules (API integrations, CRUD operations)
- Different expertise domains (GUI, database, algorithms)
- Time-sensitive deliverables

❌ **NO - Sequential when:**
- Features have tight dependencies
- Architectural decisions needed first
- Small changes (< 3 files)
- Learning/exploring codebase

---

## 🏗️ Architecture

### Three-Layer Parallel Model

```
┌─────────────────────────────────────────────────────────────┐
│                    COORDINATION LAYER                        │
│  (Main repo - Architecture, integration, final review)       │
│                                                              │
│  Model: Claude Opus 4 (best reasoning)                      │
│  Context: Full project architecture, integration plans      │
└─────────────────────────────────────────────────────────────┘
                             │
          ┌──────────────────┼──────────────────┐
          ▼                  ▼                  ▼
┌──────────────────┬──────────────────┬──────────────────┐
│  WORKTREE 1      │  WORKTREE 2      │  WORKTREE 3      │
│  GUI Features    │  Backend Logic   │  Testing         │
│                  │                  │                  │
│  Sonnet 4.5      │  Sonnet 4.5      │  Haiku 3.5       │
│  (fast impl)     │  (fast impl)     │  (fast/cheap)    │
│                  │                  │                  │
│  Specialized     │  Specialized     │  Specialized     │
│  GUI context     │  API context     │  Test context    │
└──────────────────┴──────────────────┴──────────────────┘
          │                  │                  │
          └──────────────────┴──────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                    INTEGRATION LAYER                         │
│  (Merge coordination, conflict resolution, CI/CD)            │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Directory Structure

```
project/
├── .ai/
│   ├── templates/                      # This framework
│   │   ├── PARALLEL_DEV_FRAMEWORK.md   # Main guide
│   │   ├── WORKTREE_GUIDE.md          # Setup instructions
│   │   ├── AGENT_TEMPLATES.md          # Agent definitions
│   │   └── TOKEN_OPTIMIZATION.md       # Efficiency strategies
│   ├── worktrees/                      # Worktree-specific context
│   │   ├── gui/
│   │   │   ├── context.md             # GUI-specific context
│   │   │   ├── current_task.md        # What to work on
│   │   │   └── agent_config.json      # Agent configuration
│   │   ├── backend/
│   │   │   ├── context.md
│   │   │   ├── current_task.md
│   │   │   └── agent_config.json
│   │   └── testing/
│   │       ├── context.md
│   │       ├── current_task.md
│   │       └── agent_config.json
│   ├── scripts/
│   │   ├── setup_worktrees.sh         # Initialize worktrees
│   │   ├── sync_worktrees.sh          # Sync changes
│   │   ├── merge_worktrees.sh         # Coordinate merges
│   │   ├── distribute_context.sh      # Distribute context files
│   │   └── cleanup_worktrees.sh       # Remove worktrees
│   └── coordination/
│       ├── integration_plan.md         # How to merge work
│       ├── worktree_status.md          # Track progress
│       └── conflict_resolution.md      # Handle merge conflicts
├── main/                                # Main worktree
└── ../project-worktrees/                # Sibling worktrees
    ├── project-gui/                     # GUI worktree
    ├── project-backend/                 # Backend worktree
    └── project-testing/                 # Testing worktree
```

---

## 🔧 Setup Process

### Step 1: Identify Workstreams

**Example for Book Cataloger:**
```yaml
workstreams:
  gui:
    description: "Language selector widget, edit dialogs"
    files: src/ui/*.py
    dependencies: []
    model: sonnet-4.5
    priority: high

  backend:
    description: "Export to ODS/CSV, language formatting"
    files: src/export/*.py, src/utils/language_formatter.py
    dependencies: []
    model: sonnet-4.5
    priority: high

  testing:
    description: "Unit tests for all new features"
    files: tests/**/*.py
    dependencies: [gui, backend]
    model: haiku-3.5
    priority: medium

  integration:
    description: "Connect translation detection to enrichment"
    files: src/core/enrichment_orchestrator.py
    dependencies: [backend]
    model: sonnet-4.5
    priority: low
```

### Step 2: Create Worktrees

```bash
# Run automated setup
.ai/scripts/setup_worktrees.sh gui backend testing integration

# Manual alternative
git worktree add ../book-cataloger-gui -b feature/gui-language-selector
git worktree add ../book-cataloger-backend -b feature/export-translation-fields
git worktree add ../book-cataloger-testing -b feature/translation-tests
```

### Step 3: Distribute Context

```bash
# Distribute specialized context to each worktree
.ai/scripts/distribute_context.sh

# This creates:
# - ../book-cataloger-gui/.ai/context/gui_context.md
# - ../book-cataloger-backend/.ai/context/role-backend context.md
# - ../book-cataloger-testing/.ai/context/role-testing context.md
```

### Step 4: Launch Parallel Sessions

#### Option A: Multiple Claude Code Sessions (Simple)
```bash
# Terminal 1 - GUI workstream
cd ../book-cataloger-gui
claude
# "I'm working on the GUI worktree. Check .ai/worktrees/gui/current_task.md"

# Terminal 2 - Backend workstream
cd ../book-cataloger-backend
claude
# "I'm working on the backend worktree. Check .ai/worktrees/backend current_task.md"

# Terminal 3 - Testing workstream
cd ../book-cataloger-testing
claude
# "I'm working on the testing worktree. Check .ai/worktrees/testing current_task.md"
```

#### Option B: Multiple Claude Accounts (Enterprise)
```bash
# Account 1 (Developer A) - GUI + Integration
cd ../book-cataloger-gui
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_1
claude

# Account 2 (Developer B) - Backend + Export
cd ../book-cataloger-backend
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_2
claude

# Account 3 (QA Engineer) - Testing
cd ../book-cataloger-testing
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_3
claude
```

#### Option C: API-Based Orchestration (Advanced)
```python
# .ai/scripts/parallel_orchestrator.py
import anthropic
import asyncio

async def run_gui_agent():
    client = anthropic.Anthropic(api_key=API_KEY_1)
    # Run GUI tasks...

async def run_backend_agent():
    client = anthropic.Anthropic(api_key=API_KEY_2)
    # Run backend tasks...

async def coordinate():
    await asyncio.gather(
        run_gui_agent(),
        run_backend_agent(),
        run_testing_agent()
    )
```

---

## 🤖 Specialized Agent Design

### Agent Template Structure

```json
{
  "agent_id": "gui-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "GUI Development Specialist",
  "expertise": ["tkinter", "UI/UX", "event handling", "widget design"],
  "context_files": [
    ".ai/worktrees/gui/context.md",
    "src/ui/README.md",
    ".ai/patterns/ui_patterns.md"
  ],
  "allowed_files": [
    "src/ui/**/*.py"
  ],
  "forbidden_files": [
    "src/api/**",
    "src/database/**"
  ],
  "instructions": "Focus on GUI implementation. Do not modify backend logic. Follow UI patterns from .ai/patterns/ui_patterns.md",
  "max_tokens": 200000,
  "temperature": 0.7
}
```

### Creating Specialized Agents

**GUI Agent Context:**
```markdown
# GUI Agent Context

## Your Role
You are a GUI specialist working on the language selector widget and edit dialogs.

## What You Know
- Tkinter framework and best practices
- UI patterns from `.ai/patterns/ui_patterns.md`
- Current GUI structure in `src/ui/`

## What You DON'T Know (and shouldn't care about)
- Backend API implementations
- Database schemas
- Testing infrastructure

## Your Tasks
1. Implement language selector widget (`src/ui/language_selector.py`)
2. Enhance edit dialog with translation fields
3. Add visual indicators for translations in table view

## Key Constraints
- Only modify files in `src/ui/`
- Use language registry via import (don't modify it)
- Follow existing style guide
- Write docstrings for all public methods

## Integration Points
- Import from `src.core.language_registry` (read-only)
- Emit events for data changes (don't handle persistence)
```

**Backend Agent Context:**
```markdown
# Backend Agent Context

## Your Role
You are a backend specialist working on export/import and language formatting.

## Your Tasks
1. Implement ODS export with translation fields
2. Implement CSV export variant
3. Create language-specific formatter

## Key Files
- `src/export/ods_exporter.py` (create new)
- `src/export/csv_exporter.py` (create new)
- `src/utils/language_formatter.py` (create new)

## Integration Points
- Use `BookMetadata` structure (read-only)
- Use language registry for language info
- Output to user-specified paths

## Constraints
- No GUI code
- No database modifications
- Pure data transformation logic
```

---

## 💡 Token Optimization Strategies

### 1. Context Minimization
```markdown
❌ BAD - Large Context:
"Here's the entire codebase structure with 50 files..."

✅ GOOD - Focused Context:
"For this GUI task, you need:
- src/ui/language_selector.py (new file)
- src/core/language_registry.py (read-only import)
- .ai/patterns/ui_patterns.md (reference)"
```

### 2. Lazy Loading Pattern
```markdown
# Instead of loading all files upfront:
"Check .ai/worktrees/gui/current_task.md for your task.
Only read source files when you need to modify them."
```

### 3. Reference by Path
```markdown
# Instead of pasting code:
"Use the Language class from src/core/language_registry.py:42"
```

### 4. Incremental Context Building
```markdown
Session 1: "Create language selector widget stub"
  Context: 2K tokens

Session 2: "Add autocomplete functionality"
  Context: + previous file (5K tokens)

Session 3: "Connect to edit dialog"
  Context: + edit dialog file (8K tokens)
```

### 5. Agent-Based Search
```markdown
# Instead of reading 20 files to find something:
"Use Task tool with search agent to find all usages of 'language_code'"
```

### 6. Smart Caching
```markdown
# For API usage:
- Use Claude's prompt caching (cache common context)
- Cache: project architecture, coding standards, common imports
- Don't cache: specific task details, changing code
```

---

## 📊 Model Selection Strategy

### Decision Matrix

| Task Type | Best Model | Reasoning | Cost |
|-----------|------------|-----------|------|
| Architecture planning | Opus 4 | Best reasoning, complex decisions | $$$ |
| Feature implementation | Sonnet 4.5 | Fast, high quality, good balance | $$ |
| Simple CRUD | Haiku 3.5 | Fast, cheap, sufficient quality | $ |
| Code review | Sonnet 4.5 | Good analysis, catches issues | $$ |
| Bug fixing | Sonnet 4.5 | Good debugging, fast iteration | $$ |
| Test generation | Haiku 3.5 | Repetitive, pattern-based | $ |
| Documentation | Haiku 3.5 | Straightforward, template-based | $ |
| Refactoring | Opus 4 | Complex reasoning about dependencies | $$$ |

### Multi-Model Workflow Example

```bash
# Day 1: Architecture (Opus 4)
claude --model opus-4
"Design the parallel development strategy for features X, Y, Z"

# Day 2-4: Implementation (Sonnet 4.5 x3 in parallel)
# Worktree 1:
claude --model sonnet-4.5
"Implement GUI components per architecture"

# Worktree 2:
claude --model sonnet-4.5
"Implement backend export per architecture"

# Worktree 3:
claude --model haiku-3.5
"Generate tests for both GUI and backend"

# Day 5: Integration (Opus 4)
claude --model opus-4
"Review all worktrees, plan integration, identify conflicts"
```

---

## 🔄 Coordination & Integration

### Worktree Status Tracking

```markdown
# .ai/coordination/worktree_status.md

## GUI Worktree
**Status:** In Progress (60% complete)
**Branch:** feature/gui-language-selector
**Last Updated:** 2025-10-10 14:30
**Files Changed:** 3 new, 2 modified
**Tests:** 8/10 passing
**Ready to Merge:** No (waiting on translations tests)

## Backend Worktree
**Status:** Complete (100%)
**Branch:** feature/export-translation-fields
**Last Updated:** 2025-10-10 15:00
**Files Changed:** 5 new, 1 modified
**Tests:** 15/15 passing
**Ready to Merge:** Yes

## Testing Worktree
**Status:** In Progress (80% complete)
**Branch:** feature/translation-tests
**Last Updated:** 2025-10-10 14:45
**Files Changed:** 8 new
**Tests:** Self-test (running)
**Ready to Merge:** Soon (need GUI completion)
```

### Integration Order

```bash
# .ai/scripts/merge_worktrees.sh

# 1. Merge independent features first
git checkout main
git merge feature/export-translation-fields
git merge feature/translation-tests

# 2. Merge dependent features
git merge feature/gui-language-selector

# 3. Final integration test
pytest
npm run test  # or equivalent

# 4. Push to main
git push origin main
```

### Conflict Resolution Protocol

```markdown
## When Conflicts Occur

1. **Detect Early**
   - Run `.ai/scripts/check_conflicts.sh` daily
   - Shows potential file overlaps between worktrees

2. **Categorize Conflict**
   - File-level: Both worktrees modified same file
   - Function-level: Different functions in same file
   - Logic-level: Incompatible approaches

3. **Resolution Strategy**
   - File-level: Coordinate in main repo, one worktree waits
   - Function-level: Merge manually, test both
   - Logic-level: Escalate to Opus 4 for architectural decision

4. **Document Decision**
   - Add to `.ai/coordination/conflict_resolution.md`
   - Prevents future conflicts of same type
```

---

## 🚀 Enterprise-Scale Considerations

### Multiple Claude Accounts

**Scenario:** Team of 5, each with Claude account

```bash
# .ai/config/team_allocation.yml
team:
  lead:
    name: "Architecture Lead"
    account: CLAUDE_ACCOUNT_LEAD
    model: opus-4
    worktrees: [main]

  dev1:
    name: "GUI Developer"
    account: CLAUDE_ACCOUNT_DEV1
    model: sonnet-4.5
    worktrees: [gui, ui-tests]

  dev2:
    name: "Backend Developer"
    account: CLAUDE_ACCOUNT_DEV2
    model: sonnet-4.5
    worktrees: [backend, api-integration]

  dev3:
    name: "Database Developer"
    account: CLAUDE_ACCOUNT_DEV3
    model: sonnet-4.5
    worktrees: [database, migrations]

  qa:
    name: "QA Engineer"
    account: CLAUDE_ACCOUNT_QA
    model: haiku-3.5
    worktrees: [testing, integration-tests]
```

### API-Based Orchestration

```python
# .ai/scripts/enterprise_orchestrator.py

import anthropic
import asyncio
from typing import List, Dict

class WorktreeOrchestrator:
    """Coordinate multiple Claude instances across worktrees."""

    def __init__(self, config_path: str):
        self.config = self._load_config(config_path)
        self.clients = self._initialize_clients()

    async def run_parallel_development(
        self,
        workstreams: List[Dict]
    ) -> Dict[str, any]:
        """Run multiple development workstreams in parallel."""

        tasks = []
        for stream in workstreams:
            task = self._run_workstream(
                worktree=stream['worktree'],
                tasks=stream['tasks'],
                client=self.clients[stream['account']]
            )
            tasks.append(task)

        results = await asyncio.gather(*tasks)
        return self._consolidate_results(results)

    async def _run_workstream(
        self,
        worktree: str,
        tasks: List[str],
        client: anthropic.Anthropic
    ):
        """Execute tasks in a specific worktree."""

        # Load worktree-specific context
        context = self._load_worktree_context(worktree)

        # Execute tasks sequentially within worktree
        for task in tasks:
            result = await self._execute_task(
                client=client,
                context=context,
                task=task
            )

            # Update context with results
            context = self._update_context(context, result)

        return {
            'worktree': worktree,
            'status': 'complete',
            'files_changed': self._get_changed_files(worktree)
        }
```

### Cost Optimization

```markdown
## Token Budget Allocation

**Total Budget:** 10M tokens/month
**Team Size:** 5 developers

### Allocation Strategy:
- Architecture (Opus 4): 1M tokens (10%)
  - Weekly planning sessions
  - Complex problem solving
  - Integration decisions

- Implementation (Sonnet 4.5): 7M tokens (70%)
  - 4 developers × 1.75M tokens each
  - Daily feature development

- Testing/Docs (Haiku 3.5): 2M tokens (20%)
  - Test generation
  - Documentation
  - Code review

### Monitoring:
```bash
.ai/scripts/token_usage_monitor.sh
# Tracks daily usage per account
# Alerts when approaching limits
# Suggests model downgrades for simple tasks
```

---

## 📋 Checklist: Setting Up Parallel Development

### Planning Phase
- [ ] Identify independent workstreams
- [ ] Map file dependencies (ensure no conflicts)
- [ ] Define integration points
- [ ] Choose models for each workstream
- [ ] Allocate Claude accounts (if multiple)
- [ ] Estimate token budgets

### Setup Phase
- [ ] Create git worktrees with branches
- [ ] Generate specialized context for each worktree
- [ ] Create agent configurations
- [ ] Set up coordination mechanisms
- [ ] Configure sync scripts
- [ ] Establish testing strategy

### Execution Phase
- [ ] Launch parallel Claude sessions
- [ ] Monitor progress in each worktree
- [ ] Daily sync checks (conflicts?)
- [ ] Update coordination status
- [ ] Run incremental tests

### Integration Phase
- [ ] Check all worktrees ready to merge
- [ ] Run conflict detection
- [ ] Merge in dependency order
- [ ] Run full test suite
- [ ] Final code review (Opus 4?)
- [ ] Merge to main
- [ ] Clean up worktrees

---

## 📚 Example: Book Cataloger Parallel Setup

### Actual Commands for THIS Project

```bash
# 1. Setup worktrees
cd /Users/z/dev/book-cataloger
.ai/scripts/setup_worktrees.sh gui backend testing integration

# 2. Distribute context
.ai/scripts/distribute_context.sh

# 3. Launch sessions (3 terminals)

# Terminal 1 - GUI
cd ../book-cataloger-gui
claude
# Prompt: "I'm the GUI specialist. Check .ai/worktrees/gui/current_task.md"

# Terminal 2 - Backend
cd ../book-cataloger-backend
claude
# Prompt: "I'm the backend specialist. Check .ai/worktrees/backend current_task.md"

# Terminal 3 - Testing
cd ../book-cataloger-testing
claude
# Prompt: "I'm the testing specialist. Check .ai/worktrees/testing current_task.md"

# 4. Coordinate (main repo)
cd /Users/z/dev/book-cataloger
.ai/scripts/worktree_status.sh  # Check progress
.ai/scripts/check_conflicts.sh  # Detect issues early

# 5. Merge when ready
.ai/scripts/merge_worktrees.sh
```

---

## 🎓 Lessons Learned

### What Works Well
✅ Clear separation of concerns (GUI vs backend)
✅ Independent test worktree
✅ Daily coordination syncs
✅ Specialized context per worktree
✅ Using Haiku for repetitive tasks (tests, docs)

### What Doesn't Work
❌ Shared files between worktrees (instant conflicts)
❌ Vague task definitions ("improve the system")
❌ No integration plan upfront
❌ Merging all at once at the end
❌ Using Opus for simple CRUD (waste of money)

### Best Practices
1. **Start with architecture** (Opus 4, main repo)
2. **Create clear boundaries** (no shared files)
3. **Sync daily** (catch conflicts early)
4. **Test continuously** (don't wait for integration)
5. **Document decisions** (future reference)
6. **Use right model for job** (cost vs quality)

---

## 🔮 Future Enhancements

### Advanced Patterns
- **Auto-conflict detection:** Pre-commit hooks that check for worktree conflicts
- **Context caching:** Shared context across sessions
- **Agent handoffs:** One agent finishes, next picks up seamlessly
- **Multi-repo coordination:** Parallelize across microservices
- **Real-time collaboration:** Multiple humans + multiple Claudes

### Tooling Improvements
- VS Code extension for worktree management
- Dashboard showing all worktree progress
- Automated token budget tracking
- Smart context distributor (learns what each agent needs)
- Conflict predictor (ML-based)

---

## 📖 Related Documents

- [Worktree Setup Guide](WORKTREE_GUIDE.md) - Step-by-step setup
- [Agent Templates](AGENT_TEMPLATES.md) - Specialized agent definitions
- [Token Optimization](TOKEN_OPTIMIZATION.md) - Efficiency strategies
- [Multi-Model Orchestration](MULTI_MODEL_GUIDE.md) - Model selection guide

---

**Version History:**
- v1.0 (2025-10-10): Initial framework based on book-cataloger experience
- v1.1 (TBD): Add real-world examples from 3+ projects
- v2.0 (TBD): Add automated orchestration tooling

**License:** MIT - Use freely, credit appreciated
**Maintainer:** AI-Assisted Development Community
