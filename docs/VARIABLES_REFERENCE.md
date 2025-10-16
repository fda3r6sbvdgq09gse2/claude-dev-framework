# VARIABLES.yaml Complete Reference Guide
*The Definitive Guide to Framework Configuration*
*Version: 2.0.1 | Last Updated: 2025-10-16*

## 🎯 Purpose

This document provides a comprehensive reference for **every variable** in `VARIABLES.yaml`, the single source of truth for all framework configuration.

**For AI Agents:** Use this as your authoritative reference when working with the framework.
**For Humans:** Use this to understand what each variable does and where it should be used.

---

## 📖 Table of Contents

1. [Quick Reference](#quick-reference)
2. [Critical Distinctions](#critical-distinctions)
3. [Framework Identity](#framework-identity)
4. [Owner/Maintainer](#ownermaintainer)
5. [Marketplace Configuration](#marketplace-configuration)
6. [Model Configuration](#model-configuration)
7. [Agent Definitions](#agent-definitions)
8. [Plugin Versions](#plugin-versions)
9. [Reward System](#reward-system)
10. [File Paths](#file-paths)
11. [Quality Standards](#quality-standards)
12. [Metrics & Tracking](#metrics--tracking)
13. [Usage Decision Trees](#usage-decision-trees)
14. [Validation Rules](#validation-rules)

---

## 🚀 Quick Reference

### Most Commonly Used Variables

```yaml
# Framework identity
framework.name              # "ClaudeDevFramework"
framework.display_name      # "Claude Multi-Agent Development Framework"
framework.version           # "2.0.1"
framework.author            # "Claude-Dev-Framework" (plugin author)

# Owner (YOU - the user)
owner.name                  # "ORG_NAME" (change this!)
owner.email                 # "contact@example.com"
owner.github_username       # "fda3r6sbvdgq09gse2"
owner.github_url            # Full GitHub URL

# Marketplace
marketplace.id              # "Claude-Dev-Framework"
marketplace.github_source   # "fda3r6sbvdgq09gse2/claude-dev-framework"

# Models
models.MODEL_001_OPUS.id    # "claude-opus-4-1-20250805"
models.MODEL_002_SONNET.id  # "claude-3-5-sonnet-20241022"
models.MODEL_003_HAIKU.id   # "claude-3-5-haiku-20241022"
```

---

## ⚠️ Critical Distinctions

### The #1 Source of Confusion: framework.author vs owner.name

**These are DIFFERENT and serve DIFFERENT purposes:**

```yaml
framework:
  author: "Claude-Dev-Framework"    # WHO CREATED THE PLUGINS
  # ↑ This is the framework itself
  # Used in: plugin.json "author.name" field
  # DO NOT CHANGE - identifies plugins as framework-created
  # Think: "Django plugins are authored by Django"

owner:
  name: "ORG_NAME"                   # WHO IS USING THE FRAMEWORK
  # ↑ This is YOU (the customizer/user)
  # Used in: marketplace.json "owner.name" field
  # CHANGE THIS - identifies your organization
  # Think: "My project built with Django"
```

### Decision Tree: Which One Should I Use?

```
Question: Who/what am I identifying?

├─ The plugins themselves?
│  └─ Use: framework.author = "Claude-Dev-Framework"
│     Examples:
│     - plugin.json "author.name" field
│     - Documentation about plugin origins
│     - Plugin metadata and attribution
│
└─ The person/organization using the framework?
   └─ Use: owner.name = "ORG_NAME"
      Examples:
      - marketplace.json "owner.name" field
      - README "Built by" section
      - Custom project branding
```

### Real-World Analogy

```
Framework: React
├─ framework.author = "React"
│  (React components are authored by "React")
│
└─ owner.name = "Facebook" or "YourCompany"
   (Your project that uses React)

Framework: Claude-Dev-Framework
├─ framework.author = "Claude-Dev-Framework"
│  (Framework plugins are authored by "Claude-Dev-Framework")
│
└─ owner.name = "ORG_NAME" → change to "Acme Corp"
   (Your project that uses the framework)
```

---

## 🏗️ Framework Identity

### framework.name
- **Value:** `"ClaudeDevFramework"`
- **Type:** String (no spaces, PascalCase)
- **Purpose:** Internal framework identifier
- **Used in:** Code, scripts, internal references
- **Change?:** ❌ NO - this is the framework's core identity
- **Example Usage:**
  ```python
  from ClaudeDevFramework import Agent
  ```

### framework.display_name
- **Value:** `"Claude Multi-Agent Development Framework"`
- **Type:** String (human-readable, with spaces)
- **Purpose:** User-facing framework name
- **Used in:** Documentation, UI, marketing materials
- **Change?:** ❌ NO - this is the product name
- **Example Usage:**
  ```markdown
  # Claude Multi-Agent Development Framework
  Welcome to the framework!
  ```

### framework.version
- **Value:** `"2.0.1"`
- **Type:** Semantic version string (MAJOR.MINOR.PATCH)
- **Purpose:** Framework release version
- **Used in:** plugin.json versions, compatibility checks, changelog
- **Change?:** ✅ YES - bump when releasing new versions
- **Versioning Rules:**
  - MAJOR: Breaking changes (1.x.x → 2.0.0)
  - MINOR: New features (2.0.x → 2.1.0)
  - PATCH: Bug fixes (2.0.0 → 2.0.1)

### framework.status
- **Value:** `"locked"`
- **Type:** Enum: "development" | "locked" | "deprecated"
- **Purpose:** Framework maturity status
- **Meaning:**
  - `"development"` = Active development, breaking changes possible
  - `"locked"` = Stable, no breaking changes, only patches
  - `"deprecated"` = Use newer version
- **Change?:** ✅ YES - update based on development phase

### framework.description
- **Value:** `"Multi-agent development framework..."`
- **Type:** String (one-line summary)
- **Purpose:** Framework elevator pitch
- **Used in:** README, marketplace description, SEO
- **Change?:** ❌ NO - core product description

### framework.license
- **Value:** `"MIT"`
- **Type:** SPDX license identifier
- **Purpose:** Legal license type
- **Used in:** plugin.json, LICENSE file, legal notices
- **Change?:** ⚠️ RARELY - only if relicensing entire framework

### framework.author
- **Value:** `"Claude-Dev-Framework"`
- **Type:** String (framework name)
- **Purpose:** Identifies WHO CREATED the plugins
- **Used in:** plugin.json "author.name" field for ALL framework plugins
- **Change?:** ❌ NO - this is the plugin author identity
- **Why it matters:**
  ```json
  {
    "name": "agent-backend",
    "author": {
      "name": "Claude-Dev-Framework"  ← from framework.author
    }
  }
  ```
- **Common mistake:**
  ```
  ❌ Setting author to "ORG_NAME"
  ✅ Setting author to "Claude-Dev-Framework"

  Reason: The plugin was CREATED BY the framework,
          not by the end user (ORG_NAME)
  ```

---

## 👤 Owner/Maintainer

**These identify YOU - the person/organization USING this framework**

### owner.name
- **Value:** `"ORG_NAME"` (placeholder)
- **Type:** String
- **Purpose:** YOUR company/organization name
- **Used in:**
  - marketplace.json "owner.name" field
  - README "Built by" section
  - Documentation footers
  - Branding/attribution
- **Change?:** ✅ YES - **CHANGE THIS FIRST!**
- **Examples:**
  - `"Acme Corporation"`
  - `"John Smith"`
  - `"DevTools Team"`
  - `"MyCompany"`
- **AI Agent Note:** If you see "ORG_NAME" anywhere, remind user to change it
- **Validation:** Should NOT be "ORG_NAME" in production

### owner.email
- **Value:** `"contact@example.com"` (placeholder)
- **Type:** Email address string
- **Purpose:** Contact email for the framework USER (not framework developers)
- **Used in:** marketplace.json, contact forms, support
- **Change?:** ✅ YES - update to your email or remove if not wanted
- **Optional:** Can be removed if you don't want to provide contact info

### owner.github_username
- **Value:** `"fda3r6sbvdgq09gse2"`
- **Type:** GitHub username string
- **Purpose:** GitHub account that owns the forked/customized repository
- **Used in:** Repository URLs, clone commands, CI/CD
- **Change?:** ✅ YES - if you fork the framework
- **Example:** If you fork to your account, change to your username

### owner.github_repo
- **Value:** `"claude-dev-framework"`
- **Type:** Repository name string
- **Purpose:** Repository name (without owner)
- **Used in:** Git operations, documentation links
- **Change?:** ⚠️ MAYBE - only if you rename the repository
- **Note:** Usually keep as "claude-dev-framework" unless you rename

### owner.github_url
- **Value:** `"https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework"`
- **Type:** Full URL string
- **Purpose:** Complete repository URL
- **Used in:** Clone instructions, links, references
- **Change?:** ✅ YES - should match your actual repository URL
- **Computed from:** `https://github.com/{github_username}/{github_repo}`

### owner.organization
- **Value:** `"Independent Developer"`
- **Type:** String (organization type)
- **Purpose:** Organization classification for display
- **Used in:** About pages, organizational context
- **Change?:** ✅ YES - describe your organization type
- **Examples:**
  - `"Startup"`
  - `"Enterprise"`
  - `"Open Source Project"`
  - `"Independent Developer"`

---

## 🏪 Marketplace Configuration

### marketplace.id
- **Value:** `"Claude-Dev-Framework"`
- **Type:** String (must match marketplace.json name field)
- **Purpose:** Unique marketplace identifier
- **Used in:** Plugin installations, marketplace references
- **Change?:** ❌ NO - must match official marketplace name
- **Critical:** Must exactly match `.claude-plugin/marketplace.json` "name" field

### marketplace.github_source
- **Value:** `"fda3r6sbvdgq09gse2/claude-dev-framework"`
- **Type:** String (format: "{owner}/{repo}")
- **Purpose:** GitHub source for marketplace installation
- **Used in:** Claude Code plugin system, installation commands
- **Change?:** ✅ YES - if you fork and want users to install from your fork
- **Example:** If your fork is at `yourname/claude-dev-framework`, change to that

### marketplace.file
- **Value:** `".claude-plugin/marketplace.json"`
- **Type:** Relative file path
- **Purpose:** Location of marketplace manifest file
- **Used in:** Build scripts, validation
- **Change?:** ❌ NO - this is the standard location per Claude Code spec

---

## 🤖 Model Configuration

### Model Structure

Each model has the same structure:

```yaml
models.MODEL_XXX_NAME:
  id: "claude-model-id-string"         # Anthropic model ID
  name: "Display Name"                  # Human-readable name
  tier: "flagship|performance|efficiency" # Model tier
  context_window: 500000                # Token context window
  usage_limit_hours_per_week: [24, 40] # [free, pro] hours
  cost_multiplier: 5.0                  # Relative cost (Sonnet = 1.0)
```

### models.MODEL_001_OPUS
- **Purpose:** Highest capability model for strategic work
- **When to use:** CEO agent, complex architecture, critical decisions
- **Cost:** 5x Sonnet
- **Context:** 500K tokens
- **Best for:** Planning, architecture, complex problem-solving

### models.MODEL_002_SONNET
- **Purpose:** Balanced model for most development work
- **When to use:** All worker agents (backend, frontend, integration, testing)
- **Cost:** 1x (baseline)
- **Context:** 200K tokens
- **Best for:** Implementation, refactoring, testing, documentation

### models.MODEL_003_HAIKU
- **Purpose:** Fast, efficient model for simple tasks
- **When to use:** Simple queries, repetitive tasks, high-volume operations
- **Cost:** 0.2x Sonnet
- **Context:** 200K tokens
- **Best for:** Code formatting, simple fixes, batch operations

### AI Agent Usage

```
Question: Which model should an agent use?

├─ Agent is CEO?
│  └─ Use: MODEL_001_OPUS
│
├─ Task is strategic/complex?
│  └─ Use: MODEL_001_OPUS
│
├─ Task is implementation/standard?
│  └─ Use: MODEL_002_SONNET (default for workers)
│
└─ Task is simple/repetitive?
   └─ Use: MODEL_003_HAIKU
```

---

## 👥 Agent Definitions

### Structure

```yaml
agents:
  core_team:           # Essential agents for any project
    - id: "backend"
      name: "Backend Agent"
      plugin: "agent-backend"  # Maps to plugins/agent-backend/
      default_model: "MODEL_002_SONNET"
      category: "development"

  optional_team:       # Optional specialized agents
    - id: "devops"
      name: "DevOps Agent"
      plugin: "agent-devops"
      default_model: "MODEL_002_SONNET"
      category: "management"
```

### Agent Fields Explained

#### agent.id
- **Purpose:** Unique agent identifier (used in commands, scripts)
- **Format:** Lowercase, no spaces
- **Example:** `"backend"`, `"frontend"`, `"ceo"`

#### agent.name
- **Purpose:** Human-readable agent name
- **Format:** Proper capitalization, with spaces
- **Example:** `"Backend Agent"`, `"Frontend Agent"`

#### agent.plugin
- **Purpose:** Plugin directory name that provides this agent
- **Format:** Must match actual directory in `plugins/`
- **Example:** `"agent-backend"` → `plugins/agent-backend/`
- **Critical:** Must follow `{type}-{name}` naming convention

#### agent.default_model
- **Purpose:** Which model this agent uses by default
- **Values:** `"MODEL_001_OPUS"` | `"MODEL_002_SONNET"` | `"MODEL_003_HAIKU"`
- **References:** models section defined above

#### agent.fallback_model
- **Purpose:** Alternative model if default is unavailable
- **Optional:** Only CEO agent has this (Opus → Sonnet fallback)
- **Example:** `"MODEL_002_SONNET"` (if Opus unavailable)

#### agent.category
- **Purpose:** Agent classification for organization
- **Values:**
  - `"development"` - Core dev agents (backend, frontend, integration, testing)
  - `"management"` - Planning/coordination (CEO, documentation, devops)
  - `"quality"` - Quality assurance (QA, UX/Product)
  - `"testing"` - Test-focused agents

---

## 📦 Plugin Versions

### Structure

```yaml
plugin_versions:
  # Format: {type}_{name}: "version"
  agent_backend: "2.0.1"
  agent_frontend: "2.0.1"
  command_context_management: "2.0.1"
  utility_reward_system: "2.0.1"
```

### Naming Convention

**Critical:** Plugin version keys use **underscore** format, not hyphen:

```
Directory:    plugins/agent-backend/        (hyphen)
Version key:  agent_backend: "2.0.1"       (underscore)
```

### When to Update

```
Scenario: You release a new plugin version

1. Update version in VARIABLES.yaml:
   agent_backend: "2.0.1" → "2.0.2"

2. Update plugin.json:
   plugins/agent-backend/.claude-plugin/plugin.json
   "version": "2.0.2"

3. Update marketplace.json:
   Plugin entry version: "2.0.2"

4. Document in CHANGELOG.md
```

---

## 🎁 Reward System

*Detailed section showing all reward system variables with examples and usage*

### XP System Configuration

```yaml
rewards.xp_system:
  enabled_by_default: true

  earning_rates:
    task_simple: 5        # Small fixes, simple changes
    task_medium: 15       # Feature additions, refactoring
    task_complex: 30      # Architecture, complex features

    bonus_tests_pass: 10
    bonus_coverage_90: 15
    bonus_zero_bugs: 20
    bonus_pattern_extracted: 20
```

**Usage Example:**
```python
# Award XP for completing a complex task
xp_earned = get_var("rewards.xp_system.earning_rates.task_complex")
agent.add_xp(xp_earned)  # Adds 30 XP
```

---

## 📂 File Paths

### Global vs Project Paths

```yaml
paths:
  # Global (user-level, cross-project)
  global_agents: "~/.claude/agents"
  global_workers_legacy: "~/.claude-workers"
  rewards_global: "~/.claude/rewards"

  # Project (project-specific)
  project_agents: ".claude/agents"
  rewards_project: ".claude/rewards"
```

### Path Usage Decision Tree

```
Question: Where should this agent/file go?

├─ Should it persist across ALL projects?
│  └─ Use: paths.global_agents (~/.claude/agents)
│     Example: Full-time agents that work on any project
│
└─ Is it project-specific?
   └─ Use: paths.project_agents (.claude/agents)
      Example: Temporary contractor agents for this project only
```

---

## ✅ Quality Standards

```yaml
quality:
  test_coverage_minimum: 85   # Fail below this
  test_coverage_target: 90    # Aim for this
  test_coverage_excellent: 95 # Excellence threshold

  api_timeout_seconds: 5      # API call timeout
  cache_hit_rate_target: 70   # Cache efficiency target (%)

  code_style: "black"         # Python formatter
  type_checking: "mypy"       # Python type checker
```

**AI Agent Usage:**
```python
# Check if test coverage meets minimum
coverage = calculate_coverage()
minimum = get_var("quality.test_coverage_minimum")

if coverage < minimum:
    raise QualityError(f"Coverage {coverage}% below minimum {minimum}%")
```

---

## 📊 Metrics & Tracking

```yaml
metrics:
  proven_from_project: "book-cataloger"  # Source project
  sprints_completed: "6A"
  patterns_extracted: 23
  token_efficiency_savings: 80
  development_speed_multiplier: 4
```

**Purpose:** These document the framework's proven effectiveness.

**Usage:** Reference in documentation, presentations, ROI calculations.

---

## 🌳 Usage Decision Trees

### Decision Tree: "What variable do I need?"

```
SCENARIO: Writing plugin.json manifest

Question: What goes in "author.name"?
├─ Is this a framework plugin?
│  └─ Use: framework.author = "Claude-Dev-Framework"
│
└─ Is this YOUR custom plugin?
   └─ Use: owner.name = "ORG_NAME" (your company)

────────────────────────────────────────────────

SCENARIO: Writing marketplace.json

Question: What goes in "owner.name"?
└─ Always use: owner.name = "ORG_NAME"
   (This is who maintains the marketplace)

────────────────────────────────────────────────

SCENARIO: Agent needs to know model to use

Question: Which model should agent use?
├─ Is agent CEO?
│  └─ Use: models.MODEL_001_OPUS
│
├─ Check agent definition:
│  └─ agents.core_team[i].default_model
│
└─ Fallback:
   └─ Use: models.MODEL_002_SONNET (safe default)

────────────────────────────────────────────────

SCENARIO: Calculating XP reward

Question: How much XP for this task?
├─ Simple task (fix typo, small change)?
│  └─ rewards.xp_system.earning_rates.task_simple = 5
│
├─ Medium task (add feature, refactor)?
│  └─ rewards.xp_system.earning_rates.task_medium = 15
│
└─ Complex task (architecture, integration)?
   └─ rewards.xp_system.earning_rates.task_complex = 30
```

---

## ✅ Validation Rules

### Rules Enforced

```yaml
validation:
  on_commit:
    - check_no_hardcoded_values
    - validate_yaml_syntax
    - verify_all_refs_valid

  hardcoded_detection:
    patterns_to_flag:
      - "fda3r6sbvdgq09gse2"         # GitHub username (use owner.github_username)
      - "claude-dev-framework"        # Repo name (use owner.github_repo)
      - specific_xp_values: [5, 15, 30]
      - specific_salary_values: [300, 500, 800]
```

### Pre-Commit Checklist

**Before committing:**

1. ✅ All plugin.json "author.name" = `"Claude-Dev-Framework"`
2. ✅ marketplace.json "owner.name" = your actual org name (not "ORG_NAME")
3. ✅ No hardcoded GitHub usernames in docs (use variables)
4. ✅ No hardcoded XP/salary values in docs (use variables)
5. ✅ All plugin versions match between:
   - VARIABLES.yaml (plugin_versions)
   - plugin.json (version field)
   - marketplace.json (plugin entry version)

### Common Mistakes to Avoid

```
❌ WRONG: plugin.json author = "ORG_NAME"
✅ RIGHT: plugin.json author = "Claude-Dev-Framework"

❌ WRONG: marketplace.json owner = "claude-multi-agent-framework"
✅ RIGHT: marketplace.json owner = "YourCompany"

❌ WRONG: Hardcoded in docs: "Earn 30 XP for complex tasks"
✅ RIGHT: Reference variable: "Earn {{var:rewards.xp_system.earning_rates.task_complex}} XP"

❌ WRONG: Hardcoded URL: "git clone https://github.com/fda3r6sbvdgq09gse2/..."
✅ RIGHT: Reference variable: "git clone {{var:owner.github_url}}"
```

---

## 🤖 For AI Agents: Quick Lookup

**When you need to:**

| Task | Variable to Use |
|------|----------------|
| Set plugin author | `framework.author` = "Claude-Dev-Framework" |
| Set marketplace owner | `owner.name` = user's org name |
| Get model ID for CEO | `models.MODEL_001_OPUS.id` |
| Get model ID for worker | `models.MODEL_002_SONNET.id` |
| Award XP for complex task | `rewards.xp_system.earning_rates.task_complex` |
| Check minimum test coverage | `quality.test_coverage_minimum` |
| Get framework version | `framework.version` |
| Get repository URL | `owner.github_url` |
| Get global agents path | `paths.global_agents` |

---

## 👨‍💻 For Humans: Customization Checklist

**After forking this framework:**

1. ✅ Change `owner.name` from "ORG_NAME" to your company name
2. ✅ Change `owner.email` to your contact email
3. ✅ Change `owner.github_username` to your GitHub username
4. ✅ Change `owner.github_url` to your repository URL
5. ✅ Update `owner.organization` to describe your org type
6. ✅ Keep `framework.author` as "Claude-Dev-Framework" (do not change!)
7. ✅ Update marketplace.json owner.name to match step 1
8. ✅ Run validation: `./scripts/validate_variables.sh` (if exists)

**Do NOT change:**
- ❌ `framework.author` - must stay "Claude-Dev-Framework"
- ❌ `framework.name` - this is the product name
- ❌ `framework.display_name` - this is the product name
- ❌ `marketplace.id` - must match official marketplace

---

## 🔗 Variable Knowledge Graph (Obsidian-Style Linking)

### Concept: Variables as Knowledge Nodes

**Vision:** Each variable is a node in a knowledge graph that accumulates references, usage patterns, and context over time.

```
Variable: framework.author = "Claude-Dev-Framework"
├─ Defined in: VARIABLES.yaml:28
├─ Documented in: docs/VARIABLES_REFERENCE.md
├─ Used in: (10 locations)
│  ├─ plugins/agent-backend/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-frontend/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-integration/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-testing/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-ceo/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-documentation/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-devops/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-qa-automation/.claude-plugin/plugin.json:6
│  ├─ plugins/agent-ux-product/.claude-plugin/plugin.json:6
│  └─ plugins/utility-reward-system/.claude-plugin/plugin.json:6
├─ Related variables:
│  ├─ owner.name (commonly confused with)
│  └─ marketplace.id (used together in configs)
├─ First used: 2025-10-16
├─ Last modified: 2025-10-16
├─ Usage count: 11 references
└─ Status: ✅ No orphaned usages
```

### Benefits

1. **Discoverability**: Find all uses of a variable instantly
2. **Impact Analysis**: Know what breaks if you change a variable
3. **No Orphans**: Detect unused variables
4. **Knowledge Accumulation**: Variables gain context over time
5. **Bidirectional Links**: Navigate from variable → usage and usage → variable

### Implementation

#### 1. Variable Index (Automated)

```bash
# Generate variable usage index
./scripts/generate_variable_index.sh

# Output: .ai/variable-index.json
{
  "framework.author": {
    "value": "Claude-Dev-Framework",
    "defined_in": "VARIABLES.yaml:28",
    "documented_in": ["docs/VARIABLES_REFERENCE.md:123"],
    "used_in": [
      {"file": "plugins/agent-backend/.claude-plugin/plugin.json", "line": 6},
      {"file": "plugins/agent-frontend/.claude-plugin/plugin.json", "line": 6}
      // ... more usages
    ],
    "usage_count": 11,
    "first_used": "2025-10-16",
    "last_modified": "2025-10-16",
    "related_variables": ["owner.name", "marketplace.id"],
    "status": "active",
    "orphaned": false
  }
}
```

#### 2. Query Commands

```bash
# Find all uses of a variable
./scripts/find_variable_usage.sh framework.author

# Output:
framework.author = "Claude-Dev-Framework"
Used in 11 locations:
  1. plugins/agent-backend/.claude-plugin/plugin.json:6
  2. plugins/agent-frontend/.claude-plugin/plugin.json:6
  [...]

# Find orphaned variables (defined but never used)
./scripts/find_orphaned_variables.sh

# Find hardcoded values that should be variables
./scripts/find_hardcoded_values.sh
```

#### 3. Variable Profile Pages

Each variable gets a markdown profile:

```markdown
# Variable Profile: framework.author

## Current Value
`"Claude-Dev-Framework"`

## Purpose
Identifies the framework as the creator of plugins

## Type
String

## Status
✅ Active | 11 references | No orphans

## Defined In
- [`VARIABLES.yaml:28`](../VARIABLES.yaml#L28)

## Documented In
- [`docs/VARIABLES_REFERENCE.md:123`](./VARIABLES_REFERENCE.md#frameworkauthor)

## Used In (11 locations)
1. [`plugins/agent-backend/.claude-plugin/plugin.json:6`](../plugins/agent-backend/.claude-plugin/plugin.json#L6)
2. [`plugins/agent-frontend/.claude-plugin/plugin.json:6`](../plugins/agent-frontend/.claude-plugin/plugin.json#L6)
[...]

## Related Variables
- `owner.name` - Commonly confused with this variable
- `marketplace.id` - Often used together in configurations

## Usage Patterns
- **Plugin manifests**: All plugin.json files use this in "author.name" field
- **Never used in**: marketplace.json (uses owner.name instead)

## History
- **Created**: 2025-10-16
- **Last Modified**: 2025-10-16
- **Changes**: 1 modification

## Validation Rules
- Must be: `"Claude-Dev-Framework"`
- Do not change to: `"ORG_NAME"` or any custom value
- Type: String (exact match required)

## Common Mistakes
❌ Setting to `"ORG_NAME"` (use owner.name for that)
✅ Keeping as `"Claude-Dev-Framework"`

## Examples
```json
{
  "author": {
    "name": "Claude-Dev-Framework"  ← references framework.author
  }
}
```

## Impact Analysis
**If you change this variable:**
- ⚠️ 11 plugin manifest files will be affected
- ⚠️ All plugins will show different author
- ⚠️ May break plugin marketplace compatibility

## Backlinks
← Linked from: [Owner vs Framework Author](./VARIABLES_REFERENCE.md#critical-distinctions)
← Referenced in: [Plugin Manifest Guide](./PLUGIN_MANIFEST_GUIDE.md)
```

### 4. Visual Knowledge Graph

```
# ASCII Graph (simplified)

VARIABLES.yaml
     │
     ├─── framework.author ────┬─── agent-backend/plugin.json
     │                         ├─── agent-frontend/plugin.json
     │                         ├─── agent-integration/plugin.json
     │                         └─── [8 more plugins]
     │
     ├─── owner.name ──────────┬─── marketplace.json
     │                         ├─── README.md
     │                         └─── CLAUDE.md
     │
     └─── models.MODEL_002_SONNET ─┬─── agents.backend.default_model
                                    ├─── agents.frontend.default_model
                                    └─── [6 more agent configs]
```

### 5. Pre-Commit Hooks

```bash
# Automatically update variable index before commit
#!/bin/bash
# .git/hooks/pre-commit

echo "Updating variable index..."
./scripts/generate_variable_index.sh

echo "Checking for orphaned variables..."
ORPHANED=$(./scripts/find_orphaned_variables.sh --count)
if [ "$ORPHANED" -gt 0 ]; then
    echo "⚠️  Warning: $ORPHANED orphaned variables found"
    echo "Run: ./scripts/find_orphaned_variables.sh"
fi

echo "Checking for hardcoded values..."
HARDCODED=$(./scripts/find_hardcoded_values.sh --count)
if [ "$HARDCODED" -gt 0 ]; then
    echo "❌ Error: $HARDCODED hardcoded values found"
    echo "Run: ./scripts/find_hardcoded_values.sh"
    exit 1
fi

echo "✅ Variable integrity validated"
```

### 6. IDE Integration

**VS Code Extension Concept:**

```typescript
// Hover over a variable reference
"author.name": "{{framework.author}}"
                    ↑
// Shows tooltip:
// framework.author = "Claude-Dev-Framework"
// Defined in: VARIABLES.yaml:28
// Used in: 11 locations
// Click to see all references
```

### Principles

1. **Single Definition**: Each variable defined exactly once in VARIABLES.yaml
2. **Many References**: Used many times across codebase
3. **Bidirectional Links**: From variable → usages AND usages → variable
4. **Knowledge Accumulation**: Variables gain metadata over time
5. **No Orphans**: Detect and eliminate unused variables
6. **Impact Visibility**: See what breaks before changing

### Maintenance Commands

```bash
# Daily/Weekly maintenance
./scripts/variable_health_check.sh

# Output:
✅ All variables referenced
✅ No hardcoded values detected
⚠️  1 variable rarely used: custom.experimental_feature
📊 Total variables: 87
📊 Total references: 342
📊 Average references per variable: 3.9
```

---

## 📚 Related Documentation

- [VARIABLES.yaml](../VARIABLES.yaml) - The source of truth (master config file)
- [SINGLE_SOURCE_OF_TRUTH.md](./SINGLE_SOURCE_OF_TRUTH.md) - SSOT principles
- [CLAUDE.md](../CLAUDE.md) - Framework usage guide
- [Claude Code Plugin Reference](https://docs.claude.com/en/docs/claude-code/plugins-reference) - Official plugin docs

---

## 🎯 The Golden Rule

> **If you find yourself typing a value twice, you're doing it wrong.**
>
> Define once in VARIABLES.yaml, reference everywhere.

### The Knowledge Graph Corollary

> **Variables are not just values - they are knowledge nodes.**
>
> Each variable should accumulate references, context, and usage patterns over time.
> No variable should be orphaned or duplicated.

---

*This guide is maintained as part of the Claude Multi-Agent Development Framework.*
*Last Updated: 2025-10-16 | Version: 2.0.1*
*Variable Knowledge Graph System: Concept Stage | Implementation: TBD*
