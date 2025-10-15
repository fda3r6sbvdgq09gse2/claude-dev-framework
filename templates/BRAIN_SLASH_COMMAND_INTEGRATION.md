# Brain's Guide: Integrating Slash Commands into Sprint Planning

## 🎯 Purpose

Slash commands (`/role-backend`, `/role-frontend`, `/role-integration`, `/role-testing`, `/role-brain`) give workers a **one-command context refresh**. Brain should integrate these into every sprint launch guide.

---

## ✅ Benefits of Slash Command Integration

### For Workers
- ✅ **One command loads identity** - Role, boundaries, workflow
- ✅ **Points to detailed resources** - Profile for history, patterns for solutions
- ✅ **Consistent across sprints** - Same ritual every time
- ✅ **Dry run capable** - Can refresh without starting work
- ✅ **Navigation-focused** - GPS not encyclopedia

### For Brain
- ✅ **Simpler launch prompts** - No need to list all context files
- ✅ **Guaranteed consistency** - Every worker uses same pattern
- ✅ **No duplication** - Slash command points to profile, doesn't repeat it
- ✅ **Cross-project reusability** - Slash commands work on any project

### Design Philosophy
- **Slash Command** = GPS (where am I? where's my stuff?)
- **Profile** = Resume (what have I done? what can I do?)
- **Patterns** = Library (reusable solutions)

---

## 📋 Standard Worker Launch Pattern

### Old Way (Don't use):
```
I'm the [Worker Name] - Sprint X.

Loading my profile:
@/Users/z/.claude-workers/[worker]/profile.md

Reading sprint tasks:
@/Users/z/dev/[project]/.ai/SPRINT_X_LAUNCH_GUIDE.md

[Long task description...]

Let me start...
```

**Problems:**
- ❌ Long and verbose
- ❌ Absolute paths required (easy to forget)
- ❌ Doesn't load patterns
- ❌ Doesn't remind worker of boundaries

### New Way (Always use):
```
/[worker]

Now reading sprint-specific tasks:
@/Users/z/dev/[project]/.ai/SPRINT_X_LAUNCH_GUIDE.md

My task: [Brief, specific task]

[Any critical constraints or context]

Let me start...
```

**Benefits:**
- ✅ Concise (3 lines vs 8+)
- ✅ Loads full worker context automatically
- ✅ Absolute paths only for sprint guide
- ✅ Worker remembers role and boundaries

---

## 🛠️ How to Use in Sprint Launch Guides

### Step 1: Worker Assignment Section

Include a slash command reference after launch instructions:

```markdown
### Step 1: Backend Worker - [Task Name]

**Terminal 2:**
```bash
cd /Users/z/dev/[project]
claude
```

**Prompt:**
```
/backend

Now reading sprint-specific tasks:
@/Users/z/dev/[project]/.ai/SPRINT_X_LAUNCH_GUIDE.md

My task: [Specific task description]

[Any constraints or dependencies]

Let me start...
```

**Slash Command Loaded:**
- Worker identity & boundaries
- Pattern library
- Typical workflow
- Collaboration style
```

### Step 2: Add Dry Run Section (Optional but Recommended)

Before the launch sequence, add:

```markdown
## 🧪 Dry Run (Optional - Practice/Refresh)

**Before starting work, workers can refresh their identity:**

### [Worker Name] Dry Run
```bash
cd /Users/z/dev/[project]
claude
```
Type: `/[worker]`

**Then exit without working.** This is just a mental refresh.

**Purpose:**
- ✅ Remember role and boundaries
- ✅ Recall patterns from past work
- ✅ Get mentally prepared
- ✅ Check current XP/level
```

---

## 📚 Available Slash Commands

When Brain writes sprint launch guides, reference these:

### Worker Commands
- `/role-backend` - Backend Specialist (APIs, data, services)
- `/role-frontend` - Frontend Specialist (UI, interactions, visual)
- `/role-integration` - Integration Specialist (orchestration, workflows)
- `/role-testing` - Testing Specialist (quality, validation, bugs)

### Coordinator Command
- `/role-brain` - Brain Worker (strategy, coordination, architecture)

### Aliases
- `/ultrathink` - (future) Alias for `/role-brain` in deep analysis mode

---

## 🎯 Template Integration Checklist

When Brain creates a new sprint launch guide:

- [ ] Use `/[worker]` in all worker prompts
- [ ] Follow with absolute path to sprint guide
- [ ] Include "My task:" for clarity
- [ ] Add slash command reference section
- [ ] Consider adding dry run section
- [ ] Test that paths are absolute (start with `/Users/`)

---

## 📊 Example: Complete Worker Section

```markdown
### Backend Worker (Terminal 2) - Fix Authentication Bug

**Time:** 1-2 hours
**XP:** +60
**Dependencies:** None (can start immediately)

**Task:**
Fix OAuth token refresh logic in `src/auth/oauth_client.py`

**Terminal 2:**
```bash
cd /Users/z/dev/my-project
claude
```

**Prompt:**
```
/backend

Now reading sprint-specific tasks:
@/Users/z/dev/my-project/.ai/SPRINT_5_LAUNCH_GUIDE.md

My task: Fix OAuth token refresh in src/auth/oauth_client.py

Current bug: Token expires but doesn't refresh automatically
Expected: Token auto-refreshes 5 minutes before expiration

Let me start by reviewing the current implementation...
```

**What `/role-backend` Loads:**
- Backend Worker identity & role
- API integration patterns
- Error handling strategies
- Collaboration style with other workers

**Success Criteria:**
- ✅ Token refresh logic works
- ✅ Tests verify auto-refresh
- ✅ No user interruption during refresh
```

---

## 🔄 When to Use Dry Runs

### Recommended for Dry Runs:
- **Complex sprints** - Worker needs mental preparation
- **New patterns** - Worker hasn't used this pattern recently
- **Multiple workers** - Coordination is critical
- **After breaks** - Worker hasn't worked in days/weeks

### Skip Dry Runs for:
- **Simple tasks** - Quick bug fixes, obvious changes
- **Urgent sprints** - Time is critical
- **Experienced workers** - Already know role well

---

## 💡 Brain's Workflow

When planning a new sprint:

1. **Identify workers needed** - Which specializations?
2. **Assign tasks** - What does each worker build?
3. **Write launch guide** - Use template with slash commands
4. **For each worker section:**
   ```markdown
   **Prompt:**
   ```
   /[worker]

   Now reading sprint-specific tasks:
   @/Users/z/dev/[project]/.ai/SPRINT_X_LAUNCH_GUIDE.md

   My task: [Specific task]
   ```
   ```
5. **Add dry run section** (if complex sprint)
6. **Test paths** - Ensure all paths are absolute

---

## 🚀 Migration Guide: Old Sprints → New Pattern

If updating existing sprint guides:

### Find and Replace:
```
# Find:
I'm the [Worker] - Sprint X.

Loading my profile:
@...

Reading sprint tasks:
@...

# Replace with:
/[worker]

Now reading sprint-specific tasks:
@/Users/z/dev/[project]/.ai/SPRINT_X_LAUNCH_GUIDE.md
```

### Then verify:
- ✅ Paths are absolute
- ✅ Task is clearly stated
- ✅ Slash command matches worker type

---

## 📝 Cross-Project Compatibility

These slash commands are **project-agnostic**:

```
/role-backend works for:
- Book cataloger
- E-commerce site
- API service
- Data pipeline
- Any Python project
```

**What changes per project:**
- Sprint guide path (`@/Users/z/dev/[PROJECT]/.ai/SPRINT_X_LAUNCH_GUIDE.md`)
- Task descriptions
- Success criteria

**What stays the same:**
- Worker identity
- Patterns library
- Role boundaries
- Collaboration style

---

## 🎮 Advanced: Slash Command Chains

For complex setups, workers can chain commands:

```
/backend

Check my patterns:
ls /Users/z/.claude-workers/backend patterns/

Now reading sprint tasks:
@/Users/z/dev/project/.ai/SPRINT_X_LAUNCH_GUIDE.md

Reference specific pattern:
@/Users/z/.claude-workers/backend patterns/three-source-fallback.md

Let me apply this pattern to the task...
```

---

## ✅ Success Metrics

**Brain knows slash command integration is working when:**
- ✅ Workers start with `/[worker]` every time
- ✅ No confusion about role or boundaries
- ✅ Workers reference their patterns naturally
- ✅ Launch prompts are concise (< 10 lines)
- ✅ Cross-project reusability proven

---

**Summary:** Slash commands make worker context loading **automatic, consistent, and reusable**. Always integrate them into sprint launch guides.
