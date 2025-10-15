# 🏗️ Workers vs Agents vs Memory - Complete Architecture
**Understanding the different layers of the AI development system**

---

## 🎭 Three-Layer Architecture

```
┌─────────────────────────────────────────────────────────┐
│  LAYER 1: MEMORY (Persistent Knowledge)                 │
│  ~/.claude-workers/patterns/                            │
│  Survives across all sessions, projects, workers        │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  LAYER 2: WORKERS (Persistent Sessions - Terminals)     │
│  Terminal 2, 3, 4, 5                                    │
│  Interactive, long-running, can spawn agents            │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  LAYER 3: AGENTS (Autonomous Tasks)                     │
│  Spawned by Workers using Task tool                     │
│  Single-purpose, report back, then terminate            │
└─────────────────────────────────────────────────────────┘
```

---

## 👷 WORKERS (Terminal Windows)

### What They Are:
- **Full Claude Code instance** in a terminal window
- **Interactive session** - you can talk to them
- **Long-running** - stays open for hours
- **Full tool access** - Read, Write, Edit, Bash, Task (spawn agents!)
- **Persistent context** - remembers conversation in session

### Characteristics:
```yaml
Type: Interactive Claude Code
Duration: Hours (entire sprint)
Tools: ALL (Read, Write, Edit, Bash, Grep, Task, etc.)
Interaction: User can intervene, ask questions
Context: Conversation history (~200k tokens)
Output: Multiple files, commits, continuous work
Cost: Higher (long sessions, full context)
```

### Examples (Current Setup):
- **Terminal 2 - GUI Worker:** Interactive, can ask clarifying questions
- **Terminal 3 - Backend Worker:** Long-running, builds multiple files
- **Terminal 4 - Integration Worker:** Persistent, coordinates with others
- **Terminal 5 - Quality Worker:** Responds to feedback

### When to Use:
✅ Complex, multi-step work requiring judgment
✅ Needs to respond to changing requirements
✅ Coordinating with other workers
✅ Building multiple related files
✅ Iterative development

---

## 🤖 AGENTS (Task Tool - Autonomous Sub-Tasks)

### What They Are:
- **Autonomous task** spawned by Brain or Worker
- **Single purpose** - do one thing, report back
- **No interaction** - runs autonomously
- **Limited tools** - Only specific tools for their type
- **Returns result** - Single message back to spawner

### Claude Code Agent Types:
```yaml
general-purpose:
  Tools: * (all tools)
  Use: Complex searches, multi-step autonomous tasks
  Example: "Search codebase for all translation-related code"

statusline-setup:
  Tools: Read, Edit
  Use: Configure status line
  Example: "Update my status line config"

output-style-setup:
  Tools: Read, Write, Edit, Glob, Grep
  Use: Create output styles
  Example: "Create a custom output style"
```

### Characteristics:
```yaml
Type: Autonomous Task (spawned by Claude)
Duration: Minutes to 30 min
Tools: LIMITED (based on agent type)
Interaction: NONE (autonomous)
Context: Task-specific only
Output: Single result message
Cost: Lower (focused, shorter duration)
```

### Example Agent Uses:
```python
# Worker spawns agent to search codebase:
Task(
    subagent_type="general-purpose",
    description="Search for translation code",
    prompt="""
    Search the entire codebase for translation-related functionality.
    Find all files that handle:
    - Language detection
    - Translation metadata
    - Original title/language fields

    Return: List of files with line numbers and descriptions
    """
)

# Agent runs autonomously, returns:
# "Found 8 files:
#  - src/utils/language_detector.py:38 - Main detection logic
#  - src/core/book_metadata.py:45 - Translation fields
#  - ..."
```

### When to Use:
✅ Focused search/research task
✅ Autonomous, no decisions needed
✅ Quick analysis or code finding
✅ Worker needs info but shouldn't be distracted
✅ Parallel sub-tasks

---

## 💾 MEMORY (Persistent Knowledge)

### What It Is:
- **Files outside the project** - `~/.claude-workers/`
- **Survives sessions** - Doesn't disappear when terminal closes
- **Cross-project** - Available to all projects
- **Explicitly loaded** - Workers read when needed
- **Human-editable** - You can add/modify patterns

### Types of Memory:

#### 1. Pattern Library
```
~/.claude-workers/frontend patterns/catalog-view.md
```
- Reusable code templates
- Proven solutions
- Lessons from past projects

#### 2. Worker Profiles
```
~/.claude-workers/frontend profile.md
```
- Expertise level
- Projects completed
- Strengths/weaknesses
- Learning goals

#### 3. Coordination Protocols
```
~/.claude-workers/coordination/protocols/role-brain worker.md
```
- How Brain coordinates
- Proven workflows
- Merge strategies

### Memory vs Context:

| Aspect | Context (Conversation) | Memory (Files) |
|--------|----------------------|----------------|
| **Scope** | Current session only | All sessions/projects |
| **Size** | 200k tokens max | Unlimited (files) |
| **Persistence** | Lost when terminal closes | Permanent |
| **Access** | Automatic (in conversation) | Explicit (@file reference) |
| **Cost** | Token usage | Minimal |
| **Control** | Claude manages | Human + Claude manage |

---

## 🏗️ Hybrid Architecture: Workers + Agents + Memory

### Optimal Setup:

```
BRAIN (Terminal 1)
├── Memory: Coordination protocols
├── Spawns: Search agents, research agents
└── Coordinates: Workers

WORKER (Terminal 2-5)
├── Memory: Specialty patterns
├── Spawns: Research agents, search agents
├── Uses: Read, Write, Edit, Bash
└── Builds: Features

AGENTS (spawned as needed)
├── Memory: None (stateless)
├── Tools: Limited (by type)
├── Duration: Minutes
└── Returns: Results to spawner
```

### Example Workflow:

```
1. Brain needs to understand codebase:
   └─> Spawns general-purpose AGENT
       └─> Agent searches all files
           └─> Returns file map
               └─> Brain uses to plan

2. Frontend Worker building UI:
   ├─> Reads MEMORY: ~/.claude-workers/frontend patterns/modal.md
   ├─> Spawns AGENT: "Find all existing modal dialogs"
   │   └─> Agent returns: 3 modals found with examples
   └─> Worker: Builds new modal using pattern + examples

3. Backend Worker needs API examples:
   ├─> Reads MEMORY: ~/.claude-workers/backend patterns/api-client.md
   ├─> Spawns AGENT: "Search for all API client implementations"
   │   └─> Agent returns: GoogleBooksAPI, OpenLibraryAPI found
   └─> Worker: Adapts pattern to new API

4. Integration Worker needs database structure:
   ├─> Reads MEMORY: ~/.claude-workers/integration patterns/catalog-db.md
   ├─> No agent needed (has pattern)
   └─> Worker: Implements database
```

---

## 🎯 When to Use Each

### Use WORKERS for:
- ✅ Feature implementation
- ✅ Multi-file changes
- ✅ Iterative development
- ✅ Coordinated work
- ✅ Complex decisions

### Use AGENTS for:
- ✅ Codebase search
- ✅ Pattern finding
- ✅ Quick analysis
- ✅ Background research
- ✅ Parallel sub-tasks

### Use MEMORY for:
- ✅ Reusable patterns
- ✅ Cross-project knowledge
- ✅ Worker expertise tracking
- ✅ Coordination protocols
- ✅ Lessons learned

---

## 💡 Concrete Example: Sprint 2

### Without Agents (Current):
```
GUI Worker: "I need to build a modal dialog"
├─> Reads entire codebase manually
├─> Searches for examples
├─> Takes 15 min to research
└─> Then starts coding
```

### With Agents (Optimized):
```
GUI Worker: "I need to build a modal dialog"
├─> Reads MEMORY: ~/.claude-workers/frontend patterns/modal.md
├─> Spawns AGENT: "Find existing modals in this codebase"
│   └─> Agent (2 min): Returns camera_scanner_window.py modal example
├─> Worker (5 min): Adapts pattern + example
└─> Total: 7 min (was 15 min)
```

---

## 🚀 Enhanced Worker Capabilities

### Workers Can Spawn Agents:

```python
# Frontend Worker working on CatalogView
# Needs to understand existing table implementations

Worker: "Let me spawn an agent to find table examples"

# Spawns agent:
Task(
    subagent_type="general-purpose",
    description="Find table widget examples",
    prompt="""
    Search for QTableWidget or similar table implementations.
    Return: File paths, class names, and key features
    """
)

# Agent returns results
# Worker: "Great! I'll base my CatalogView on results_table.py"
```

### Benefits:
- **Worker stays focused** on implementation
- **Agent handles research** in parallel
- **Faster development** (no context switching)
- **Better results** (agent specialized for search)

---

## 📊 Performance Comparison

### Scenario: Build a new UI component

**Traditional (single Claude):**
```
1. Research existing patterns: 15 min
2. Search codebase for examples: 10 min
3. Design component: 20 min
4. Implement: 45 min
Total: 90 min
```

**Workers only:**
```
1. Read pattern from context: 5 min
2. Search codebase: 10 min
3. Design component: 15 min
4. Implement: 40 min
Total: 70 min (1.3x faster)
```

**Workers + Agents + Memory:**
```
1. Read MEMORY pattern: 2 min (file access)
2. AGENT searches code: 3 min (parallel)
3. Design component: 10 min (has pattern)
4. Implement: 30 min (template + example)
Total: 45 min (2x faster!)
```

---

## 🏆 Complete Vision

### Mature System (After 10 Projects):

```
┌─────────────────────────────────────────────┐
│  MEMORY: Rich pattern library               │
│  - 50+ proven patterns                      │
│  - 4 expert worker profiles                 │
│  - Optimized coordination protocols         │
└─────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────┐
│  BRAIN: Expert coordinator                  │
│  - Reads coordination memory                │
│  - Spawns research agents                   │
│  - Assigns work optimally                   │
└─────────────────────────────────────────────┘
           ↓        ↓       ↓        ↓
    ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐
    │Worker│  │Worker│  │Worker│  │Worker│
    │  +   │  │  +   │  │  +   │  │  +   │
    │Agents│  │Agents│  │Agents│  │Agents│
    └──────┘  └──────┘  └──────┘  └──────┘
    Frontend  Backend   Integr.   Quality

Each Worker:
- Reads specialty MEMORY (patterns)
- Spawns AGENTS for research
- Implements using templates
- 3-5x faster than first project
```

### Result:
- **New project setup:** 5 min (was 30 min)
- **Feature development:** 1 hr (was 3 hrs)
- **Quality:** Higher (proven patterns)
- **Coordination:** Smoother (learned protocols)

---

## ✅ Implementation for Book Cataloger

### Phase 1: Add Memory (NOW)
```bash
# Create memory structure
mkdir -p ~/.claude-workers/{frontend,backend,integration,quality}/{patterns,examples}
mkdir -p ~/.claude-workers/coordination/{protocols,templates}

# Start capturing patterns from Sprint 1
```

### Phase 2: Enhance Workers (Sprint 2)
```bash
# Update worker prompts to reference memory
# Workers load patterns before starting
# Workers document new patterns after completing
```

### Phase 3: Add Agents (Sprint 3)
```bash
# Workers spawn agents for:
# - Codebase searches
# - Pattern finding
# - Example extraction
# - Parallel research
```

### Phase 4: Mature (Projects 2-5)
```bash
# Rich pattern library
# Expert worker profiles
# Optimized with agents
# 3x+ faster development
```

---

## 🎯 Immediate Action

**Want me to:**
1. ✅ Set up Memory structure NOW
2. ✅ Update worker prompts to use Memory
3. ✅ Show Workers how to spawn Agents
4. ✅ Capture Sprint 1 patterns to Memory

**This will make Sprint 2 faster AND set up for future 3x speedups!**

Ready to implement? 🚀
