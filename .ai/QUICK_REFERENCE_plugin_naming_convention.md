# Quick Reference: Plugin Naming Convention

**Date Created:** 2025-10-15
**Context:** Established type-first naming convention for plugins

## Naming Convention

### Standard Format

```
{type}-{name}
```

Where:
- `{type}` = `agent`, `command`, or `utility`
- `{name}` = descriptive kebab-case name
- Use all lowercase
- Separate words with hyphens

### Examples

**Agents:**
- `agent-backend` (not `backend-agent`)
- `agent-frontend` (not `frontend-agent`)
- `agent-ceo` (not `ceo-agent`)
- `agent-qa-automation` (not `qa-automation-agent`)

**Commands:**
- `command-context-management` (not `context-management-plugin`)
- `command-git-workflow` (not `git-workflow-commands`)

**Utilities:**
- `utility-reward-system` (not `reward-system`)
- `utility-telemetry` (not `telemetry-plugin`)

## Why Type-First?

### Benefits

1. **Alphabetical Grouping**: Plugins naturally group by type when sorted
   ```
   agent-backend
   agent-ceo
   agent-frontend
   command-context-management
   command-git-workflow
   utility-reward-system
   ```

2. **Quick Identification**: See the plugin type at a glance
   - `agent-*` = Provides AI agents
   - `command-*` = Provides slash commands
   - `utility-*` = Provides utilities/tools

3. **Tab Completion**: Type the category first to see all plugins of that type
   ```bash
   /plugin list agent-<TAB>     # Shows all agents
   /plugin list command-<TAB>   # Shows all commands
   ```

4. **Consistency**: Follows standard naming patterns (noun-modifier)

## Single Source of Truth: VARIABLES.yaml

**All plugin names are defined in VARIABLES.yaml:**

```yaml
# .ai/VARIABLES.yaml
marketplaces:
  framework:
    plugins:
      - name: "agent-backend"           # ← Change here
        type: "agent"
        category: "development"
        description: "Backend specialist"
```

### Propagating Changes

After changing plugin names in VARIABLES.yaml:

```bash
# 1. Sync marketplace.json from VARIABLES.yaml
python3 .ai/scripts/sync_marketplace_from_variables.py

# 2. Copy to installed location (if using local marketplace)
cp .claude-plugin/marketplace.json \
   ~/.claude/plugins/marketplaces/Claude-Dev-Framework/.claude-plugin/

# 3. Restart Claude Code
exit
claude
```

## Plugin Structure

Each plugin follows this structure:

```
agent-backend/                    # ← Type-first directory name
├── .claude-plugin/
│   └── plugin.json              # name: "agent-backend"
└── agents/
    └── backend.md               # name: backend (without prefix)
```

### Key Points

1. **Directory name**: `agent-backend` (with type prefix)
2. **plugin.json name**: `agent-backend` (matches directory)
3. **Agent file name**: `backend.md` (WITHOUT prefix - this is the agent's short name)
4. **Agent frontmatter name**: `backend` (the agent's identifier used with Task tool)

## Using Agents in Code

When invoking agents with the Task tool, use the **agent name** (without type prefix):

```python
# ✅ Correct
task = Task(subagent_type="backend", prompt="Build API endpoint")

# ❌ Wrong
task = Task(subagent_type="agent-backend", prompt="Build API endpoint")
```

The type prefix is only for **plugin organization**, not agent invocation.

## Renaming Existing Plugins

If you need to rename plugins to follow this convention:

### Option 1: Use Rename Script

```bash
# Edits VARIABLES.yaml first, then run:
.ai/scripts/rename_plugins_by_type.sh /path/to/marketplace
.ai/scripts/sync_marketplace_from_variables.py
```

### Option 2: Manual Rename

1. **Update VARIABLES.yaml:**
   ```yaml
   plugins:
     - name: "agent-backend"  # Changed from "backend-agent"
   ```

2. **Rename directory:**
   ```bash
   mv plugins/backend-agent plugins/agent-backend
   ```

3. **Update plugin.json:**
   ```json
   {
     "name": "agent-backend"  // Changed
   }
   ```

4. **Sync marketplace.json:**
   ```bash
   python3 .ai/scripts/sync_marketplace_from_variables.py
   ```

## Migration History

### 2025-10-15: Initial Rename

Renamed all framework plugins to type-first convention:

| Old Name | New Name | Type |
|----------|----------|------|
| backend-agent | agent-backend | agent |
| ceo-agent | agent-ceo | agent |
| devops-agent | agent-devops | agent |
| documentation-agent | agent-documentation | agent |
| frontend-agent | agent-frontend | agent |
| integration-agent | agent-integration | agent |
| qa-automation-agent | agent-qa-automation | agent |
| testing-agent | agent-testing | agent |
| ux-product-agent | agent-ux-product | agent |
| context-management-plugin | command-context-management | command |
| reward-system | utility-reward-system | utility |

**Scripts used:**
- `.ai/scripts/rename_plugins_by_type.sh` - Renamed directories and plugin.json files
- `.ai/scripts/sync_marketplace_from_variables.py` - Generated marketplace.json from VARIABLES.yaml

## Best Practices

### DO

✅ Use type prefix for all plugins
✅ Keep names short and descriptive
✅ Use kebab-case (all lowercase, hyphen-separated)
✅ Update VARIABLES.yaml as the single source of truth
✅ Run sync script after VARIABLES.yaml changes

### DON'T

❌ Don't use type suffix (backend-agent)
❌ Don't mix naming styles
❌ Don't hardcode plugin names in docs - reference VARIABLES.yaml
❌ Don't manually edit marketplace.json - it's generated
❌ Don't include redundant words (agent-backend-agent)

## Validation

Check your plugin names are correct:

```bash
# Validate plugin manifests
.ai/scripts/validate_plugin_manifests.sh

# Check marketplace.json is synced
cat .claude-plugin/marketplace.json | jq '.plugins[].name'

# List installed plugins
/plugin list
```

All plugin names should follow `{type}-{name}` format.

---

**Reference:**
- VARIABLES.yaml - Single source of truth for plugin names
- marketplace.json - Generated from VARIABLES.yaml (DO NOT EDIT DIRECTLY)
- plugin.json - Matches marketplace.json entries
