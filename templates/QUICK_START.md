# Parallel Development Framework - Quick Start
**Get started with parallel AI-assisted development in 5 minutes**

---

## 🚀 Immediate Use Case: Book Cataloger

You have 4-5 independent features ready to parallelize:

1. **GUI Workstream:** Language selector widget + edit dialogs
2. **Backend Workstream:** Export to ODS/CSV with translation fields
3. **Integration Workstream:** Connect translation detection to enrichment
4. **Testing Workstream:** Comprehensive tests for all new features

Let's set them up NOW:

---

## ⚡ Quick Start (5 Minutes)

### Step 1: Create Worktrees (1 minute)

```bash
cd /Users/z/dev/book-cataloger

# Make script executable
chmod +x .ai/scripts/setup_worktrees_enhanced.sh

# Create 4 parallel worktrees
.ai/scripts/setup_worktrees_enhanced.sh gui backend integration testing
```

**What this does:**
- Creates 4 git worktrees in `../book-cataloger-worktrees/`
- Sets up AI context for each worktree
- Creates coordination tracking files
- Initializes Python environments

### Step 2: Define Tasks (2 minutes)

Edit the task files for each worktree:

**GUI Worktree:**
```bash
# Edit: ../book-cataloger-worktrees/book-cataloger-gui/.ai/worktrees/gui/current_task.md

Task: Implement language selector widget

Subtasks:
- [ ] Create LanguageSelector widget (src/ui/language_selector.py)
- [ ] Add autocomplete functionality
- [ ] Add "Other..." for custom languages
- [ ] Integrate with edit dialog
- [ ] Add visual translation indicators

Files to modify:
- src/ui/language_selector.py (new)
- src/ui/main_window.py (integrate)

Files to import (read-only):
- src/core/language_registry.py
```

**Backend Worktree:**
```bash
# Edit: ../book-cataloger-worktrees/book-cataloger-backend/.ai/worktrees/backend current_task.md

Task: Export catalog with translation fields

Subtasks:
- [ ] Create ODS exporter (src/export/ods_exporter.py)
- [ ] Create CSV exporter (src/export/csv_exporter.py)
- [ ] Add import from existing ODS
- [ ] Handle new translation columns

Files to create:
- src/export/ods_exporter.py
- src/export/csv_exporter.py
```

**Integration Worktree:**
```bash
# Edit: ../book-cataloger-worktrees/book-cataloger-integration/.ai/worktrees/integration current_task.md

Task: Connect translation detection to enrichment

Subtasks:
- [ ] Integrate LanguageDetector into EnrichmentOrchestrator
- [ ] Pass API responses to language detector
- [ ] Add translation fields to BookMetadata output
- [ ] Update data merger to use new fields

Files to modify:
- src/core/enrichment_orchestrator.py
- src/core/data_merger.py
```

**Testing Worktree:**
```bash
# Edit: ../book-cataloger-worktrees/book-cataloger-testing/.ai/worktrees/testing current_task.md

Task: Comprehensive testing for translation features

Subtasks:
- [ ] Unit tests for LanguageRegistry
- [ ] Unit tests for LanguageDetector
- [ ] Unit tests for language selector widget
- [ ] Integration tests for enrichment + translation
- [ ] Test ODS/CSV export with translation fields

Files to create:
- tests/unit/test_language_registry.py
- tests/unit/test_translation_detection.py
- tests/unit/test_language_selector.py
- tests/role-integration test_enrichment_with_translation.py
```

### Step 3: Launch Parallel Sessions (2 minutes)

Open 4 terminal windows:

**Terminal 1 - GUI Worktree:**
```bash
cd ../book-cataloger-worktrees/book-cataloger-gui
source venv/bin/activate
claude
```

**Prompt to Claude:**
```
I'm the GUI specialist for this worktree. I focus exclusively on UI implementation.

Context: Check .ai/worktrees/gui/current_task.md for my tasks.

I can modify: src/ui/
I cannot touch: src/api/, src/database/, src/export/

Let me start by implementing the language selector widget.
```

**Terminal 2 - Backend Worktree:**
```bash
cd ../book-cataloger-worktrees/book-cataloger-backend
source venv/bin/activate
claude
```

**Prompt to Claude:**
```
I'm the backend specialist for this worktree. I focus on export/import functionality.

Context: Check .ai/worktrees/backend current_task.md for my tasks.

I can modify: src/export/
I cannot touch: src/ui/

Let me start by creating the ODS exporter.
```

**Terminal 3 - Integration Worktree:**
```bash
cd ../book-cataloger-worktrees/book-cataloger-integration
source venv/bin/activate
claude
```

**Prompt to Claude:**
```
I'm the integration specialist. I connect translation detection to the enrichment pipeline.

Context: Check .ai/worktrees/integration current_task.md

Let me start by integrating LanguageDetector into EnrichmentOrchestrator.
```

**Terminal 4 - Testing Worktree:**
```bash
cd ../book-cataloger-worktrees/book-cataloger-testing
source venv/bin/activate
claude
```

**Prompt to Claude:**
```
I'm the testing specialist. I write comprehensive tests for all new features.

Context: Check .ai/worktrees/testing current_task.md

Let me start with unit tests for LanguageRegistry.
```

---

## 📊 Monitor Progress

**Check status anytime:**
```bash
cd /Users/z/dev/book-cataloger
.ai/scripts/worktree_status.sh
```

**Check for conflicts:**
```bash
.ai/scripts/check_conflicts.sh
```

**View coordination dashboard:**
```bash
cat .ai/coordination/worktree_status.md
```

---

## 🔄 Integration (When Ready)

### Step 1: Verify All Worktrees Complete

```bash
# Check status
.ai/scripts/worktree_status.sh

# Verify tests pass in each worktree
cd ../book-cataloger-worktrees/book-cataloger-gui && pytest
cd ../book-cataloger-worktrees/book-cataloger-backend && pytest
cd ../book-cataloger-worktrees/book-cataloger-integration && pytest
cd ../book-cataloger-worktrees/book-cataloger-testing && pytest
```

### Step 2: Check for Conflicts

```bash
cd /Users/z/dev/book-cataloger
.ai/scripts/check_conflicts.sh
```

If conflicts found, resolve them before merging.

### Step 3: Merge in Order

```bash
cd /Users/z/dev/book-cataloger
git checkout main

# Merge independent features first
git merge --no-ff feature/backend -m "Add ODS/CSV export with translation fields"
git merge --no-ff feature/testing -m "Add comprehensive translation detection tests"

# Then dependent features
git merge --no-ff feature/integration -m "Integrate translation detection into enrichment"
git merge --no-ff feature/gui -m "Add language selector widget and UI enhancements"

# Run full test suite
pytest

# If all passes
git push origin main
```

### Step 4: Cleanup

```bash
# Remove worktrees
.ai/scripts/cleanup_worktrees.sh

# Delete merged branches
git branch -d feature/gui feature/backend feature/integration feature/testing
```

---

## 💡 Pro Tips

### Use Different Claude Accounts

If you have multiple Claude accounts (e.g., enterprise plan):

```bash
# Terminal 1 - Account 1 (GUI)
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_1
cd ../book-cataloger-gui && claude

# Terminal 2 - Account 2 (Backend)
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_2
cd ../book-cataloger-backend && claude

# Terminal 3 - Account 3 (Integration)
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_3
cd ../book-cataloger-integration && claude

# Terminal 4 - Account 4 (Testing)
export ANTHROPIC_API_KEY=$CLAUDE_ACCOUNT_4
cd ../book-cataloger-testing && claude
```

**Benefits:**
- True parallel execution (4 Claude instances simultaneously)
- No token limit conflicts
- 4x speed improvement
- Each account maintains separate context

### Model Selection

Optimize cost vs quality:

```bash
# Architecture/Planning (main repo)
claude --model opus-4
"Design the integration strategy for these 4 worktrees"

# Implementation (gui, backend, integration)
claude --model sonnet-4.5
"Implement the language selector widget"

# Testing (testing worktree)
claude --model haiku-3.5
"Generate unit tests for LanguageRegistry"
```

### Daily Sync

Run this every morning/evening:

```bash
# Check all worktree status
.ai/scripts/worktree_status.sh --verbose

# Check for conflicts
.ai/scripts/check_conflicts.sh

# Update coordination dashboard
cat .ai/coordination/worktree_status.md
```

---

## 🎯 Expected Results

### Timeline

**Sequential (old way):**
- GUI: 4 hours
- Backend: 3 hours
- Integration: 2 hours
- Testing: 3 hours
- **Total: 12 hours** (spread over days)

**Parallel (new way):**
- All 4 worktrees in parallel: **4 hours** (maximum of the four)
- **3x speed improvement!**

### Cost Comparison

**Sequential:**
```
12 hours × 200k tokens/hour × Sonnet pricing = ~$14.40
```

**Parallel (optimized):**
```
GUI: 1 hour × 80k tokens × Sonnet = $1.20
Backend: 1 hour × 60k tokens × Sonnet = $0.90
Integration: 1 hour × 50k tokens × Sonnet = $0.75
Testing: 2 hours × 100k tokens × Haiku = $0.56
Total: $3.41 (76% cost savings!)
```

---

## 🔧 Troubleshooting

### "Worktree already exists"

```bash
# Remove existing worktree
git worktree remove ../book-cataloger-worktrees/book-cataloger-gui --force

# Re-run setup
.ai/scripts/setup_worktrees_enhanced.sh gui
```

### "Conflicts detected"

```bash
# Check conflict report
cat .ai/coordination/conflict_report.md

# Options:
# 1. Coordinate: One worktree waits for the other
# 2. Manual merge: Merge one, then resolve conflicts in the other
# 3. Redesign: Re-split work to avoid conflicts
```

### "Tests failing after merge"

```bash
# Rollback merge
git reset --hard HEAD~1

# Fix issues in worktree
cd ../book-cataloger-worktrees/book-cataloger-gui
# Fix the issue
pytest  # Verify fix

# Try merge again
cd /Users/z/dev/book-cataloger
git merge --no-ff feature/gui
```

---

## 📚 Next Steps

### Advanced Usage

Once comfortable with basics, explore:

1. **API-Based Orchestration:** `.ai/templates/PARALLEL_DEV_FRAMEWORK.md` (section on API usage)
2. **Custom Agents:** `.ai/templates/AGENT_TEMPLATES.md`
3. **Token Optimization:** `.ai/templates/TOKEN_OPTIMIZATION.md`
4. **Multi-Project:** Adapt framework for other projects

### Create Your Own Template

```bash
# Copy this framework to new project
cp -r /Users/z/dev/book-cataloger/.ai/templates /new-project/.ai/
cp -r /Users/z/dev/book-cataloger/.ai/scripts /new-project/.ai/

# Adapt for new project
# Update project-specific details in templates
```

---

## 🎓 Learning Resources

### Documentation
- [Full Framework Guide](PARALLEL_DEV_FRAMEWORK.md) - Complete reference
- [Agent Templates](AGENT_TEMPLATES.md) - Specialized agent configs
- [Token Optimization](TOKEN_OPTIMIZATION.md) - Cost & speed optimization
- [Worktree Guide](WORKTREE_GUIDE.md) - Git worktree deep dive

### Scripts
- `setup_worktrees_enhanced.sh` - Initialize parallel development
- `worktree_status.sh` - Monitor progress
- `check_conflicts.sh` - Detect merge conflicts early
- `cleanup_worktrees.sh` - Remove worktrees after merge

---

## ✅ Success Checklist

- [ ] Worktrees created and configured
- [ ] Tasks defined for each worktree
- [ ] Claude sessions launched in each worktree
- [ ] Daily status checks running
- [ ] Conflict detection in place
- [ ] Integration plan documented
- [ ] All tests passing
- [ ] Features merged successfully
- [ ] Worktrees cleaned up

---

**Ready to Start?**

```bash
cd /Users/z/dev/book-cataloger
.ai/scripts/setup_worktrees_enhanced.sh gui backend integration testing
```

**Questions?** See [PARALLEL_DEV_FRAMEWORK.md](PARALLEL_DEV_FRAMEWORK.md) for detailed guidance.

**Good luck!** 🚀

---

## 🎩 Advanced: Role Transformation System

### Using Specialized Worker Roles

For complex projects with strict domain separation, use **slash commands** to transform terminals into specialized workers:

```bash
# Terminal 1: Backend Worker
cd /Users/z/dev/book-cataloger
claude
/backend

# Terminal 2: Frontend Worker
cd /Users/z/dev/book-cataloger
claude
/frontend

# Terminal 3: Brain (Coordinator)
cd /Users/z/dev/book-cataloger
claude
/role-brain
```

**Available Commands:**
- `/role-backend` - Backend Worker (APIs, services, data)
- `/role-frontend` - Frontend Worker (UI, components)
- `/role-integration` - Integration Worker (workflows, orchestration)
- `/role-testing` - Testing Worker (test suites)
- `/role-brain` - Brain Worker (architecture, coordination)

**The Transformation:**
- Running `/role-backend` makes the terminal **BECOME** Backend Worker
- Role persists entire session until `exit`
- Automatic boundary enforcement
- Natural specialization

**When to use:**
- Sprint-based development with worker assignments
- Multi-terminal parallel development
- Strict domain separation needed

**Documentation:**
- Complete guide: `.ai/ROLE_TRANSFORMATION_SYSTEM.md`
- Workflow integration: `.ai/WORKFLOW_GUIDE.md` (Role Transformation section)
