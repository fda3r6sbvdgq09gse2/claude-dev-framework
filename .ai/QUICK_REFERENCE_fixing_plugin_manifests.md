# Quick Reference: Fixing Claude Code Plugin Manifests

**Date Created:** 2025-10-15
**Context:** Fixed all plugin.json files to comply with Claude Code schema after validation errors

## Problem

When plugins are installed from a marketplace, Claude Code validates the `plugin.json` manifest files. If they don't match the expected schema, you'll see errors like:

```
Plugin Loading Errors:
  ✘ backend-agent@Claude-Dev-Framework
     Plugin backend-agent has an invalid manifest file
     Validation errors:
     - author: Expected object, received string
     - repository: Expected string, received object
     - agents: Invalid input
     - Unrecognized key(s) in object: 'dependencies'
```

## Root Cause

The plugin.json files were using a custom schema that doesn't match Claude Code's official plugin schema. Common issues:

1. **author** field was a string instead of an object
2. **repository** field was an object instead of a string URL
3. **agents** field had configuration objects instead of just paths
4. **Invalid fields** like `dependencies`, `configuration`, `scripts`, etc.

## Solution: Claude Code Plugin.json Schema

### Required Fields

```json
{
  "name": "plugin-name",     // kebab-case identifier
  "version": "2.0.0"         // semantic version
}
```

### Optional Fields (Valid)

```json
{
  "description": "Brief description",
  "author": {
    "name": "Author Name",
    "email": "email@example.com",  // optional
    "url": "https://github.com/author"  // optional
  },
  "homepage": "https://github.com/org/repo",
  "repository": "https://github.com/org/repo",  // string URL, not object!
  "license": "MIT",
  "keywords": ["tag1", "tag2"],

  // Component paths (all must be relative and start with ./)
  "commands": "./commands/",           // or ["./custom/cmd1.md"]
  "agents": "./agents/",               // or ["./agents/agent1.md"]
  "hooks": "./config/hooks.json",
  "mcpServers": "./config/mcp.json"
}
```

### Invalid Fields (Remove These)

These fields are **NOT** part of the Claude Code schema and will cause validation errors:

```json
{
  "dependencies": { ... },           // ❌ Remove
  "optionalDependencies": { ... },   // ❌ Remove
  "configuration": { ... },          // ❌ Remove
  "scripts": { ... },                // ❌ Remove
  "files": [ ... ],                  // ❌ Remove
  "installHook": "...",              // ❌ Remove
  "healthCheck": "...",              // ❌ Remove
  "integrations": { ... },           // ❌ Remove
  "requires": { ... },               // ❌ Remove
  "_note": "..."                     // ❌ Remove
}
```

## How Agents Work in Plugins

**Key Understanding:**
- The `plugin.json` file only **points to** where agent files are located
- The actual agent definitions (with tools, model, etc.) live in **separate `.md` files** with YAML frontmatter
- You do NOT configure agents in plugin.json

### Correct Structure

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json          ← Points to agents directory
└── agents/
    └── agent-name.md        ← Actual agent definition
```

**plugin.json:**
```json
{
  "name": "my-agent-plugin",
  "version": "1.0.0",
  "agents": "./agents/"      // ← Just the path!
}
```

**agents/agent-name.md:**
```markdown
---
name: agent-name
description: What this agent does
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
---

# Agent Name

[Agent prompt and instructions here...]
```

## Step-by-Step Fix Process

### 1. Identify Issues

Check plugin loading status:
```bash
/plugin list
# Look for validation errors
```

### 2. Fix Each Plugin Manifest

For each plugin in `/Users/z/.claude/plugins/marketplaces/[MARKETPLACE]/plugins/*/`:

**Before (Invalid):**
```json
{
  "name": "backend-agent",
  "version": "2.0.0",
  "author": "claude-multi-agent-framework",          // ❌ string
  "repository": {                                     // ❌ object
    "type": "git",
    "url": "https://github.com/org/repo"
  },
  "agents": [                                         // ❌ array of configs
    {
      "name": "backend",
      "source": "./agents/backend.md",
      "model": "sonnet",
      "tools": ["Read", "Write", "Edit"]
    }
  ],
  "dependencies": {                                   // ❌ invalid field
    "python": "^3.11.0"
  }
}
```

**After (Valid):**
```json
{
  "name": "backend-agent",
  "version": "2.0.0",
  "description": "Backend development specialist",
  "author": {                                         // ✅ object
    "name": "claude-multi-agent-framework"
  },
  "homepage": "https://github.com/org/repo",
  "repository": "https://github.com/org/repo",       // ✅ string URL
  "license": "MIT",
  "keywords": ["backend", "api", "development"],
  "agents": "./agents/"                               // ✅ just path
}
```

### 3. Verify Agent MD Files

Check that agent files have correct YAML frontmatter:

```bash
cat ~/.claude/plugins/marketplaces/[MARKETPLACE]/plugins/backend-agent/agents/backend.md
```

Should have:
```yaml
---
name: backend
description: Backend development specialist
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
---
```

### 4. Test Loading

Exit and restart Claude Code, then check:
```bash
/plugin list
/agents
```

You should see all agents available and no validation errors.

## Quick Fix Script Pattern

If you have many plugins to fix, use this pattern:

```bash
# For each plugin directory
for plugin in ~/.claude/plugins/marketplaces/Claude-Dev-Framework/plugins/*/; do
  manifest="$plugin/.claude-plugin/plugin.json"
  if [ -f "$manifest" ]; then
    echo "Fixing $manifest"
    # Use python or jq to transform JSON programmatically
  fi
done
```

Or use Claude Code's Edit tool for surgical fixes as we did.

## Common Mistakes to Avoid

1. **Don't put agent configuration in plugin.json** - Use separate .md files
2. **Don't use repository as object** - Always use string URL
3. **Don't include custom fields** - Stick to official schema
4. **Don't forget author must be object** - Not a string
5. **Don't use absolute paths** - All paths must be relative with `./`

## Reference Links

- [Claude Code Plugin Docs](https://docs.claude.com/en/docs/claude-code/plugins)
- [Plugin Reference](https://docs.claude.com/en/docs/claude-code/plugins-reference)
- [Subagent Docs](https://docs.claude.com/en/docs/claude-code/sub-agents.md)

## Lessons Learned

1. **Plugin.json is just metadata and pointers** - Not configuration
2. **Agents are defined in .md files** - With YAML frontmatter
3. **Claude Code has strict schema validation** - Custom fields break loading
4. **Marketplace structure can be simple** - marketplace.json points to plugins, plugin.json points to components
5. **Individual plugins work better** - Than trying to bundle everything in one manifest

## What We Fixed

**Note:** Plugins have been renamed to follow type-first naming convention (agent-*, command-*, utility-*)

| Plugin (New Name) | Old Name | Issues Fixed | Status |
|-------------------|----------|--------------|--------|
| agent-backend | backend-agent | author, repository, agents, dependencies | ✅ Fixed |
| agent-frontend | frontend-agent | author, repository, agents, dependencies | ✅ Fixed |
| agent-integration | integration-agent | author, repository, agents, dependencies | ✅ Fixed |
| agent-testing | testing-agent | author, repository, agents, dependencies | ✅ Fixed |
| agent-ceo | ceo-agent | author, repository, agents | ✅ Fixed |
| agent-documentation | documentation-agent | author, repository, agents | ✅ Fixed |
| agent-devops | devops-agent | author, repository, agents, dependencies, configuration, files, installHook, healthCheck | ✅ Fixed |
| agent-qa-automation | qa-automation-agent | author, repository, agents, dependencies, mcpServers, configuration, files | ✅ Fixed |
| agent-ux-product | ux-product-agent | author, repository, agents, dependencies, integrations, configuration, files | ✅ Fixed |
| command-context-management | context-management-plugin | author, _note, commands, scripts, configuration, hooks, requires, files | ✅ Fixed |
| utility-reward-system | reward-system | Missing plugin.json entirely | ✅ Created |

---

**Success Criteria:** `/plugin list` shows no validation errors, and `/agents` lists all agents.
