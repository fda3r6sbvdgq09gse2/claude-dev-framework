# Knowledge Graph System - Quick Reference

## What Is This?

An **Obsidian-style bidirectional linking system** for VARIABLES.yaml that creates a traceable knowledge graph of all configuration values across the entire codebase.

## Three Files to Know

1. **`VARIABLES.yaml`** - Master configuration with `_used_in` links
   - Every variable lists where it's used: `_used_in: ["[[file:line]]", ...]`

2. **`VARIABLE_LINKS.md`** - Complete index of all mappings
   - Forward: variable → all usage locations
   - Reverse: file → all variables it uses
   - Human-readable knowledge graph

3. **`.ai/KNOWLEDGE_GRAPH_DESIGN.md`** - Full system architecture
   - Design philosophy
   - Implementation details
   - Workflow and tooling

## Key Concept: Bidirectional Links

```
VARIABLES.yaml                  Consumer File
┌─────────────┐                ┌──────────────┐
│ owner:      │    ←──→       │ "author": {   │
│   name:     │  bidirectional │   "name":    │
│   _used_in: │    linking    │   "_ref":    │
│     [[...]] │                │   [[...]]    │
└─────────────┘                └──────────────┘
```

## Why This Matters

- **Zero Hardcoding**: All values come from VARIABLES.yaml
- **Traceability**: Know where every variable is used
- **Refactoring**: Change once, sync everywhere
- **Validation**: Catch broken references automatically
- **Self-Documentation**: The graph documents itself

## Most Important Variable

### `owner.name` = "ORG_NAME" ⚠️

**THIS MUST BE CUSTOMIZED!**

Used in 15+ locations:
- All 11 plugin.json files (`author.name`)
- marketplace.json (`owner.name`)
- README.md (Built by section)
- CLAUDE.md (Instructions)

To change:
1. Edit `VARIABLES.yaml` → `owner.name`
2. Run `./scripts/sync-variables.sh` (TODO: create)
3. All 15+ locations update automatically

## Status

- ✅ Architecture designed
- ✅ VARIABLE_LINKS.md created
- ✅ VARIABLES.yaml partially linked (framework section)
- ⏳ Consumer files need `_ref` comments
- ⏳ Validation script needed
- ⏳ Sync script needed

## Next Steps

1. Add `_used_in` to all variables in VARIABLES.yaml
2. Add `_ref` comments to all consumer files
3. Create validation script
4. Create sync script
5. Document in CLAUDE.md

---

**Read the full design**: `.ai/KNOWLEDGE_GRAPH_DESIGN.md`
**See the complete index**: `VARIABLE_LINKS.md`
