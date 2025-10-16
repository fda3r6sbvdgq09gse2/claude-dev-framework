# Knowledge Graph Design - VARIABLES.yaml Linking System
*Obsidian-Style Bidirectional Variable Linking*

## 🎯 Objective

Create a traceable, bidirectional linking system where:
1. Every variable in VARIABLES.yaml knows where it's used
2. Every file that uses a variable references back to VARIABLES.yaml
3. Scripts can validate all links are correct
4. Changes to variables can be automatically synced

## 📐 Architecture

### Three-Layer System

```
┌─────────────────────────────────────────────────┐
│         VARIABLES.yaml (Master)                 │
│  - Defines all variables                        │
│  - Lists where each is used → [[file:line]]    │
└─────────────────────────────────────────────────┘
                    ↕ (bidirectional)
┌─────────────────────────────────────────────────┐
│         VARIABLE_LINKS.md (Index)               │
│  - Complete map of all variable usage           │
│  - Forward: var → files                         │
│  - Reverse: file → vars                         │
└─────────────────────────────────────────────────┘
                    ↕ (bidirectional)
┌─────────────────────────────────────────────────┐
│         Consumer Files (Usage Sites)            │
│  - plugin.json, marketplace.json, README, etc.  │
│  - Reference: [[VARIABLES.yaml#owner.name]]     │
└─────────────────────────────────────────────────┘
```

## 🔗 Linking Syntax

### In Consumer Files (JSON, Markdown, YAML)

**JSON files** (plugin.json, marketplace.json):
```json
{
  "author": {
    "name": "ORG_NAME",
    "_ref": "[[VARIABLES.yaml#owner.name]]"
  }
}
```

**Markdown files** (README.md, docs):
```markdown
Built by [[VARIABLES.yaml#owner.name]] - ORG_NAME
```

**YAML files** (config files):
```yaml
owner: "ORG_NAME"  # [[VARIABLES.yaml#owner.name]]
```

### In VARIABLES.yaml (Master)

Each variable section includes `_used_in`:
```yaml
owner:
  name: "ORG_NAME"
  _used_in:
    - "[[.claude-plugin/marketplace.json:5]]"
    - "[[plugins/agent-backend/.claude-plugin/plugin.json:6]]"
    - "[[plugins/agent-frontend/.claude-plugin/plugin.json:6]]"
    - "[[README.md:45]]"
    - "[[CLAUDE.md:37]]"
```

### In VARIABLE_LINKS.md (Index)

Complete bidirectional map:
```markdown
## owner.name
**Value**: `"ORG_NAME"`
**Used in**:
- [[.claude-plugin/marketplace.json:5]] - Marketplace owner
- [[plugins/*/plugin.json:6]] - Plugin author (11 files)
- [[README.md:45]] - Built by section
- [[CLAUDE.md:37]] - Customization instructions

## framework.version
**Value**: `"2.0.1"`
**Used in**:
- [[.claude-plugin/marketplace.json:3]]
- [[plugins/*/plugin.json:3]] (11 files)
- [[README.md:5]] - Version badge
- [[CHANGELOG.md:1]] - Current version
```

## 🛠️ Tooling

### 1. Validation Script: `scripts/validate-variables.sh`

Checks:
- All `[[references]]` point to valid files/lines
- All variables in VARIABLES.yaml are used
- All usage sites have proper `[[back-references]]`
- No hardcoded values that should be variables

### 2. Sync Script: `scripts/sync-variables.sh`

When VARIABLES.yaml changes:
1. Reads changed variables
2. Finds all `_used_in` locations
3. Updates values in those locations
4. Updates line numbers in bidirectional links
5. Regenerates VARIABLE_LINKS.md

### 3. Link Generator: `scripts/generate-links.py`

Scans entire codebase:
1. Finds all variable usage
2. Generates `_used_in` for VARIABLES.yaml
3. Creates VARIABLE_LINKS.md index
4. Reports orphaned values (hardcoded, should be variables)

## 📋 Implementation Steps

### Phase 1: Foundation
1. ✅ Create this design document
2. Create VARIABLE_LINKS.md template
3. Add `_used_in` to all variables in VARIABLES.yaml
4. Document the system in CLAUDE.md

### Phase 2: Consumer Files
5. Add `_ref` comments to all plugin.json files (11 files)
6. Add `_ref` to marketplace.json
7. Add `[[references]]` to README.md
8. Add `[[references]]` to CLAUDE.md
9. Add `[[references]]` to CHANGELOG.md

### Phase 3: Automation
10. Create validation script
11. Create sync script
12. Create link generator
13. Add pre-commit hook for validation

### Phase 4: Documentation
14. Update CLAUDE.md with knowledge graph instructions
15. Create CONTRIBUTING.md with variable usage guide
16. Add examples to README.md

## 🎨 Visual Representation

```
VARIABLES.yaml
├── owner.name = "ORG_NAME"
│   ├→ .claude-plugin/marketplace.json:5
│   ├→ plugins/agent-backend/.claude-plugin/plugin.json:6
│   ├→ plugins/agent-frontend/.claude-plugin/plugin.json:6
│   ├→ plugins/agent-integration/.claude-plugin/plugin.json:6
│   ├→ plugins/agent-testing/.claude-plugin/plugin.json:6
│   ├→ plugins/agent-ceo/.claude-plugin/plugin.json:6
│   ├→ (6 more plugins...)
│   ├→ README.md:45
│   └→ CLAUDE.md:37
│
├── framework.version = "2.0.1"
│   ├→ .claude-plugin/marketplace.json:3
│   ├→ plugins/*/.claude-plugin/plugin.json:3 (×11)
│   ├→ README.md:5
│   └→ CHANGELOG.md:1
│
└── owner.github_url = "https://github.com/..."
    ├→ .claude-plugin/marketplace.json:7
    ├→ plugins/*/.claude-plugin/plugin.json:9 (×11)
    └→ README.md:332
```

## 🔍 Benefits

1. **Traceability**: Know exactly where every variable is used
2. **Refactoring**: Change once, sync everywhere
3. **Validation**: Catch broken references automatically
4. **Documentation**: Self-documenting variable usage
5. **Onboarding**: New developers understand relationships
6. **Maintenance**: Prevent drift and inconsistencies

## 🚨 Rules

1. **NEVER hardcode** - Always use variable + reference
2. **ALWAYS add `_ref`** - Even if obvious
3. **ALWAYS update `_used_in`** - When adding usage
4. **RUN validation** - Before every commit
5. **SYNC before push** - Ensure consistency

## 📚 Examples

### Good ✅
```json
{
  "author": {
    "name": "ORG_NAME",
    "_ref": "[[VARIABLES.yaml#owner.name]]"
  },
  "version": "2.0.1",
  "_ref_version": "[[VARIABLES.yaml#framework.version]]"
}
```

### Bad ❌
```json
{
  "author": {
    "name": "Some Hardcoded Name"
  },
  "version": "2.0.1"
}
```

## 🎯 Success Criteria

- [ ] 100% of variables in VARIABLES.yaml have `_used_in`
- [ ] 100% of usage sites have `[[back-reference]]`
- [ ] VARIABLE_LINKS.md is complete and accurate
- [ ] Validation script passes with 0 errors
- [ ] Sync script successfully updates all locations
- [ ] Pre-commit hook prevents invalid changes
- [ ] Documentation clearly explains the system

---

*This design follows Obsidian's philosophy of making knowledge discoverable through bidirectional links, applied to code variables.*
