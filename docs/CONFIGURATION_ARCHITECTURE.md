# Configuration Architecture
*Official Claude Code Settings Structure for Multi-Agent Framework*
*Version: 1.0.0*

## 🎯 Overview

This document defines **EXACTLY where** to place configuration files according to [official Claude Code docs](https://docs.claude.com/en/docs/claude-code/settings), ensuring consistency across all future projects.

---

## 📍 The Four Configuration Layers

Based on [Claude Code Configuration Hierarchy](https://docs.claude.com/en/docs/claude-code/settings#configuration-hierarchy):

```
Priority (highest to lowest):
1. Enterprise Managed Policies    (Organization-wide)
2. Command Line Arguments          (Session-specific)
3. Project Local Settings          (Personal, gitignored)
4. Project Shared Settings         (Team, in git)
5. User Settings                   (Personal, all projects)
```

---

## 🗂️ Exact File Locations

### Layer 1: Enterprise (Organization-Wide)
**Not applicable** for solo developers or small teams.

```bash
# Enterprise managed - system administrators only
/etc/claude/policies.json
# We do NOT use this layer
```

---

### Layer 2: Command Line Arguments
**Use for**: Temporary overrides, testing, one-off sessions

```bash
# Start in plan mode (read-only)
claude --permission-mode plan

# Enable telemetry for this session
claude --env CLAUDE_CODE_ENABLE_TELEMETRY=1

# Use specific model
claude --model opus-4
```

**Framework Usage:**
- CEO agent should use: `claude --permission-mode plan` (strategic planning only)
- Testing sessions: `claude --env TEST_MODE=1`

---

### Layer 3: Project Local Settings
**Location**: `.claude/settings.local.json` *(gitignored)*
**Use for**: Personal preferences that should NOT be shared with team

```bash
your-project/
└── .claude/
    └── settings.local.json  # Personal only, add to .gitignore
```

**What goes here:**
```json
{
  "env": {
    "ANTHROPIC_API_KEY": "your-personal-key",
    "MY_TEST_ACCOUNT": "personal@example.com"
  },
  "enabledPlugins": {
    "my-experimental-plugin@local": true
  }
}
```

**Framework Usage:**
- Personal API keys
- Local plugin testing
- Personal debugging flags

---

### Layer 4: Project Shared Settings
**Location**: `.claude/settings.json` *(checked into git)*
**Use for**: Team-wide project settings that everyone should use

```bash
your-project/
└── .claude/
    ├── settings.json         # Team settings (in git)
    └── settings.local.json   # Personal (gitignored)
```

**What goes here:**
```json
{
  "permissions": {
    "defaultMode": "auto-accept",
    "allow": [
      "Bash(npm run test)",
      "Bash(pytest)"
    ],
    "deny": [
      "Bash(rm -rf)",
      "Read(.env)"
    ]
  },
  "enabledPlugins": {
    "backend-agent@claude-multi-agent-framework": true,
    "frontend-agent@claude-multi-agent-framework": true,
    "testing-agent@claude-multi-agent-framework": true
  },
  "extraKnownMarketplaces": {
    "claude-multi-agent-framework": {
      "source": "github",
      "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
    }
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://localhost:4317",
    "PROJECT_NAME": "your-project"
  }
}
```

**Framework Usage:**
- Enable framework plugins for all team members
- Define allowed/denied operations
- Configure monitoring endpoints

---

### Layer 5: User Settings
**Location**: `~/.claude/settings.json` *(home directory)*
**Use for**: Personal defaults that apply to ALL your projects

```bash
~/.claude/
├── settings.json      # Your defaults for all projects
├── CLAUDE.md          # Your personal instructions
└── agents/            # Your full-time agent team
    ├── backend.md
    ├── frontend.md
    ├── ceo.md
    └── integration.md
```

**What goes here:**
```json
{
  "permissions": {
    "defaultMode": "auto-accept"
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://localhost:4317",
    "PREFERRED_EDITOR": "vscode"
  },
  "enabledPlugins": {
    "backend-agent@claude-multi-agent-framework": true,
    "frontend-agent@claude-multi-agent-framework": true,
    "integration-agent@claude-multi-agent-framework": true,
    "testing-agent@claude-multi-agent-framework": true,
    "ceo-agent@claude-multi-agent-framework": true
  },
  "extraKnownMarketplaces": {
    "claude-multi-agent-framework": {
      "source": "github",
      "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
    }
  }
}
```

**Framework Usage:**
- Install full-time agents here (persist across all projects)
- Set personal defaults
- Configure monitoring for all projects

---

## 🧠 Memory Files (CLAUDE.md)

According to [Memory Docs](https://docs.claude.com/en/docs/claude-code/memory):

### User Memory
**Location**: `~/.claude/CLAUDE.md`
**Use for**: Personal instructions for ALL projects

```bash
~/.claude/
└── CLAUDE.md
```

**Example Content:**
```markdown
# Personal Claude Instructions

## Code Style
- Always use TypeScript for new JavaScript files
- Prefer functional components in React
- Use pytest for Python testing

## Tools
- Editor: VS Code
- Terminal: iTerm2

## Preferences
- Explain complex code changes
- Ask before deleting files
- Use verbose git commit messages
```

---

### Project Memory
**Location**: `./CLAUDE.md` or `./.claude/CLAUDE.md`
**Use for**: Project-specific instructions for the team

```bash
your-project/
├── CLAUDE.md          # Option 1: Root level
└── .claude/
    └── CLAUDE.md      # Option 2: In .claude/ folder
```

**Example Content:**
```markdown
# Project: Your Project Name

## Architecture
- Backend: Python FastAPI
- Frontend: React + TypeScript
- Database: PostgreSQL

## Workflow
- Always run tests before committing
- Follow .ai/context/current_task.md
- Update .ai/context/completed_tasks.md after features

## Standards
@.ai/rules/code_standards.md
@.ai/rules/module_size.md
```

---

## 🤖 Agent Profiles

### Full-Time Agents (Persist Across Projects)
**Location**: `~/.claude/agents/`

```bash
~/.claude/
└── agents/
    ├── backend.md        # Your permanent backend specialist
    ├── frontend.md       # Your permanent frontend specialist
    ├── ceo.md           # Your strategic advisor
    ├── integration.md   # Your integration specialist
    └── testing.md       # Your QA specialist
```

**Why here:**
- These agents level up across ALL your projects
- XP and attributes persist
- Pattern library accumulates
- Cost-effective for recurring work

---

### Project Contractors (Temporary)
**Location**: `.claude/agents/` *(project-specific)*

```bash
your-project/
└── .claude/
    └── agents/
        ├── ml-specialist.md      # Temporary ML expert
        └── blockchain-expert.md  # Temporary crypto specialist
```

**Why here:**
- Domain specialists for this project only
- No persistence after project ends
- Perfect for one-off needs

---

## 📊 Monitoring Configuration

### User-Level (All Projects)
**Location**: `~/.claude/settings.json`

```json
{
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://localhost:4317",
    "OTEL_EXPORTER_OTLP_PROTOCOL": "grpc",
    "OTEL_SERVICE_NAME": "claude-multi-agent-framework"
  }
}
```

---

### Project-Level (This Project Only)
**Location**: `.claude/settings.json`

```json
{
  "env": {
    "PROJECT_NAME": "book-cataloger",
    "SPRINT": "6B",
    "OTEL_RESOURCE_ATTRIBUTES": "project.name=book-cataloger,team=backend"
  }
}
```

---

## 🔐 Permissions Configuration

### User-Level Defaults
**Location**: `~/.claude/settings.json`

```json
{
  "permissions": {
    "defaultMode": "auto-accept",
    "allow": [
      "Bash(git status)",
      "Bash(git diff)",
      "Bash(pytest)",
      "Read(~/.claude/**)"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(dd if=*)",
      "Write(~/.ssh/**)",
      "Read(.env)"
    ]
  }
}
```

---

### Agent-Specific Permissions
**Location**: `~/.claude/agents/backend.md`

```markdown
---
name: backend
permissions:
  allow:
    - Write(src/api/**)
    - Write(src/core/**)
    - Write(tests/**)
  deny:
    - Write(src/ui/**)
    - Write(.ai/**)
---
```

See `config/permissions/` for detailed agent permission files.

---

## 🎮 Plugin Configuration

### Install Marketplace
**Location**: `~/.claude/settings.json`

```json
{
  "extraKnownMarketplaces": {
    "claude-multi-agent-framework": {
      "source": "github",
      "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
    }
  }
}
```

### Enable Plugins Globally
**Location**: `~/.claude/settings.json`

```json
{
  "enabledPlugins": {
    "backend-agent@claude-multi-agent-framework": true,
    "frontend-agent@claude-multi-agent-framework": true,
    "ceo-agent@claude-multi-agent-framework": true
  }
}
```

### Enable Plugins Per-Project
**Location**: `.claude/settings.json` *(in project)*

```json
{
  "enabledPlugins": {
    "ml-specialist@ai-marketplace": true,
    "data-pipeline@company-tools": true
  }
}
```

### Project-Specific Marketplaces
**Location**: `.claude-plugin/project-marketplace.json` *(in project)*
**Referenced in**: `.claude/settings.json`

**Purpose**: Create project-specific plugins and patterns that extend the framework for domain-specific needs.

**Setup:**

1. Create the marketplace file:
```bash
mkdir -p .claude-plugin
cp ~/dev/claude-dev-framework/config/templates/project-marketplace.json .claude-plugin/project-marketplace.json
```

2. Reference it in `.claude/settings.json`:
```json
{
  "extraKnownMarketplaces": {
    "ClaudeDevFramework-Marketplace": {
      "source": {
        "source": "github",
        "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
      }
    },
    "YourProject-Marketplace": {
      "source": {
        "source": "file",
        "path": "./.claude-plugin/project-marketplace.json"
      }
    }
  }
}
```

**Example project marketplace:**
```json
{
  "name": "BookCataloger-Marketplace",
  "version": "1.0.0",
  "description": "Project-specific agents for book cataloging",
  "plugins": [
    {
      "name": "isbn-validator-agent",
      "source": "./.claude/agents/isbn-validator.md",
      "description": "Domain expert for ISBN validation",
      "category": "project-specific",
      "version": "1.0.0",
      "extraction_candidate": true,
      "rationale": "Generic enough for reuse in library projects"
    }
  ]
}
```

**When to create project plugins:**
- Domain-specific agents (e.g., ISBN validator, medical terminology expert)
- Project-specific workflows (e.g., custom deployment scripts)
- Temporary experimental patterns (before promoting to framework)

**Extraction workflow:**
1. Mark `extraction_candidate: true` for reusable patterns
2. Document `rationale` for every plugin
3. Review at end of sprint
4. Promote mature patterns to framework marketplace

---

## 📁 Complete Directory Structure

```bash
# User-Level (Home Directory)
~/.claude/
├── settings.json              # Personal defaults for ALL projects
├── CLAUDE.md                  # Personal instructions
└── agents/                    # Full-time agent team
    ├── backend.md
    ├── frontend.md
    ├── ceo.md
    ├── integration.md
    └── testing.md

# Project-Level (Each Project)
your-project/
├── CLAUDE.md                  # Project instructions (team-shared)
├── .claude/
│   ├── settings.json          # Project settings (in git)
│   ├── settings.local.json    # Personal overrides (gitignored)
│   ├── CLAUDE.md              # Alternative location
│   └── agents/                # Project contractors (optional)
│       └── ml-specialist.md
└── .claude-plugin/            # Project-specific marketplace
    ├── project-marketplace.json  # Project marketplace definition
    └── plugin.json            # Plugin metadata (if project is a plugin)
```

---

## 🚀 Setup Checklist

### One-Time User Setup (Do Once)

```bash
# 1. Create user settings directory
mkdir -p ~/.claude/agents

# 2. Configure user settings
cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "auto-accept"
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://localhost:4317"
  },
  "extraKnownMarketplaces": {
    "ClaudeDevFramework-Marketplace": {
      "source": {
        "source": "github",
        "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
      }
    }
  },
  "enabledPlugins": {
    "backend-agent@ClaudeDevFramework-Marketplace": true,
    "frontend-agent@ClaudeDevFramework-Marketplace": true,
    "ceo-agent@ClaudeDevFramework-Marketplace": true,
    "integration-agent@ClaudeDevFramework-Marketplace": true,
    "testing-agent@ClaudeDevFramework-Marketplace": true
  }
}
EOF

# 3. Create user memory
cat > ~/.claude/CLAUDE.md << 'EOF'
# Personal Claude Instructions

## Framework
Using claude-multi-agent-framework with persistent agents.

## Code Style
@claude-dev-framework/docs/CODE_STANDARDS.md
EOF

# 4. Install agent profiles
cp claude-dev-framework/plugins/*/agent.md ~/.claude/agents/
```

---

### Per-Project Setup (Each New Project)

```bash
# 1. Initialize Claude in project
cd your-project
claude init

# 2. Create project settings (copy from template)
mkdir -p .claude
cp ~/dev/claude-dev-framework/config/templates/project-settings.json .claude/settings.json

# 3. Create project-specific marketplace
mkdir -p .claude-plugin
cp ~/dev/claude-dev-framework/config/templates/project-marketplace.json .claude-plugin/project-marketplace.json

# 4. Customize project settings
# Update PROJECT_NAME, marketplace name, etc.
sed -i '' 's/your-project-name/my-actual-project/g' .claude/settings.json
sed -i '' 's/YourProject-Marketplace/MyProject-Marketplace/g' .claude/settings.json
sed -i '' 's/YourProject-Marketplace/MyProject-Marketplace/g' .claude-plugin/project-marketplace.json

# 5. Create project memory
cat > CLAUDE.md << 'EOF'
# Project: Your Project

## Architecture
[Your architecture here]

## Framework
@~/.claude/CLAUDE.md
EOF

# 6. Add to .gitignore
echo ".claude/settings.local.json" >> .gitignore

# 7. Commit project configuration
git add .claude/ .claude-plugin/ CLAUDE.md .gitignore
git commit -m "Initialize Claude framework configuration"
```

---

## 🔄 Migration from Old Structure

If you have old worker profiles in `~/.claude-workers/`:

```bash
# Migrate to new structure
for worker in ~/.claude-workers/*/profile.md; do
  agent_name=$(basename $(dirname $worker))
  cp $worker ~/.claude/agents/${agent_name}.md
done

# Update references in all docs
find . -type f -name "*.md" -exec sed -i '' 's/worker/agent/g' {} +
find . -type f -name "*.md" -exec sed -i '' 's/\.claude-workers/.claude\/agents/g' {} +
```

---

## 📚 References

Official Claude Code Documentation:
- [Settings](https://docs.claude.com/en/docs/claude-code/settings)
- [Memory](https://docs.claude.com/en/docs/claude-code/memory)
- [Plugins](https://docs.claude.com/en/docs/claude-code/settings#plugin-configuration)
- [Configuration Hierarchy](https://docs.claude.com/en/docs/claude-code/settings#configuration-hierarchy)

Framework Documentation:
- [Agent Employment Model](./AGENT_EMPLOYMENT_MODEL.md)
- [Single Source of Truth](./SINGLE_SOURCE_OF_TRUTH.md)
- [Monitoring System](../monitoring/MONITORING_SYSTEM.md)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Maintainer:** Framework Team
**Source:** Based on official Claude Code docs
