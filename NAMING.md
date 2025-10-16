# Naming Conventions - Single Source of Truth

**Last Updated:** 2025-10-16
**Master Config:** `VARIABLES.yaml`

## 🎯 The Core Distinction

This framework has TWO different names that serve different purposes:

### 1. Framework Name (Product Name)
**Value:** `"Claude Multi-Agent Development Framework"`
**Variable:** `framework.display_name` in VARIABLES.yaml
**Purpose:** This is WHAT the software is called
**Usage:** Product documentation, README titles, marketing materials
**Should you change this?** **NO** - this identifies the product itself

### 2. Owner Name (Author Name)
**Value:** `"ORG_NAME"` ← **CHANGE THIS!**
**Variable:** `owner.name` in VARIABLES.yaml
**Purpose:** This is WHO created/maintains this instance
**Usage:**
- ALL 11 plugin.json files (`author.name` field)
- marketplace.json (`owner.name` field)
- README "Built by" section
**Should you change this?** **YES** - to your company/personal name!

---

## 📖 Real-World Analogy

Think of it like Microsoft Visual Studio:

| Concept | This Framework | Microsoft Example |
|---------|---------------|-------------------|
| **Product Name** | Claude Multi-Agent Development Framework | Visual Studio |
| **Creator Name** | ORG_NAME (your name!) | Microsoft |

- The product is called "Visual Studio"
- The author/creator is "Microsoft"
- When someone forks Visual Studio, the product name stays the same
- But the new fork's author changes to whoever forked it

---

## 🔧 How to Customize

### Step 1: Edit VARIABLES.yaml

```yaml
owner:
  name: "ORG_NAME"  # ← Change this to "Your Company Name"
```

### Step 2: Run Sync Script (Future)

```bash
./scripts/sync-variables.sh
```

This will update:
- All 11 plugin.json files (author.name)
- marketplace.json (owner.name)
- README.md (Built by section)

### Step 3: Commit Your Changes

```bash
git add VARIABLES.yaml plugins/ .claude-plugin/marketplace.json
git commit -m "chore: Customize owner name to [Your Company]"
```

---

## 📝 Where Each Name Appears

### Framework Display Name
- README.md (title, description)
- CLAUDE.md (context)
- Documentation headers
- Agent instructions (describing what framework they're part of)

### Owner Name (ORG_NAME)
- **plugins/agent-backend/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-frontend/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-integration/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-testing/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-ceo/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-documentation/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-devops/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-qa-automation/.claude-plugin/plugin.json** → `author.name`
- **plugins/agent-ux-product/.claude-plugin/plugin.json** → `author.name`
- **plugins/command-context-management/.claude-plugin/plugin.json** → `author.name`
- **plugins/utility-reward-system/.claude-plugin/plugin.json** → `author.name`
- **.claude-plugin/marketplace.json** → `owner.name`

---

## ⚠️ Common Mistakes to Avoid

### ❌ Don't Do This
```json
// plugin.json
{
  "author": {
    "name": "Claude-Dev-Framework"  // WRONG - This was the old pattern
  }
}
```

### ✅ Do This
```json
// plugin.json
{
  "author": {
    "name": "ORG_NAME"  // CORRECT - References VARIABLES.yaml
  }
}
```

### ❌ Don't Hardcode
```yaml
# Bad - hardcoded value
plugins:
  backend:
    author: "My Company"  # Wrong - duplicates configuration
```

### ✅ Reference the Variable
```yaml
# Good - references single source of truth
owner:
  name: "My Company"  # ← Change once, updates everywhere
```

---

## 🏗️ Why This Matters

**Single Source of Truth:** All configuration values live in ONE place (VARIABLES.yaml)

**Easy Customization:** Fork the framework → change `owner.name` → you're the author

**No Duplication:** One variable, referenced everywhere, impossible to get out of sync

**World-Class Pattern:** This follows enterprise software best practices:
- Django uses this pattern
- React uses this pattern
- Professional frameworks all do this

---

## 🔍 Verifying Your Setup

### Check Your Owner Name
```bash
grep "name:" VARIABLES.yaml | head -5
```

Should show `owner.name: "ORG_NAME"` (or your custom name)

### Check Plugin Manifests
```bash
grep -A1 '"author"' plugins/agent-backend/.claude-plugin/plugin.json
```

Should show:
```json
"author": {
  "name": "ORG_NAME"
}
```

### Validate Everything
```bash
claude plugin validate plugins/agent-backend/.claude-plugin/plugin.json
```

Should return: `✔ Validation passed`

---

## 📚 Related Documentation

- **VARIABLES.yaml** - Master configuration file (lines 59-90)
- **CLAUDE.md** - AI agent instructions (emphasizes VARIABLES.yaml)
- **README.md** - User-facing documentation
- **plugins-reference** - Claude Code official docs

---

## 🎓 For Framework Maintainers

When adding new plugins:

1. Create plugin directory: `plugins/{type}-{name}/`
2. Add `.claude-plugin/plugin.json`
3. **Always use:** `"author": { "name": "ORG_NAME" }`
4. **Never hardcode** author names
5. Add plugin to VARIABLES.yaml
6. Update marketplace.json

---

**Remember:** `owner.name` = WHO built it, `framework.display_name` = WHAT it's called

**When in doubt:** Check `VARIABLES.yaml` - it's the single source of truth!
