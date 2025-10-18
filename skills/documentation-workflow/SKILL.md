---
name: documentation-workflow
description: Three-tier documentation taxonomy and contribution guidelines
version: 1.0.0
author: Globex Systems / Blackford Inc.
tags: [documentation, taxonomy, skills, internal, external, contribution]
last_updated: 2025-10-18
---

# Documentation Workflow Skill

## Overview

This skill documents our three-tier documentation system: Internal (our knowledge), Skills (our tool usage), and External (tool docs). Agents use this to know where to document learnings.

---

## Three-Tier Taxonomy

### 1. Internal Documentation (Our Knowledge)

**What:** Strategic thinking, specs, decisions, current work

**Where:**
- `vision/` - Long-term strategy (5-10 years)
- `implementation/` - Technical specifications
- `sessions/` - Decision history
- `execution/` - Current sprint work

**When to create:**
- Strategic planning
- Feature specifications
- Sprint planning
- Session notes

**Example:**
```markdown
# File: vision/NEW_FEATURE_VISION.md
Big-picture thinking about future feature,
5-10 year horizon, architectural insights
```

---

### 2. Skills (Our Tool Usage) ⭐

**What:** How WE use external tools - codified expertise

**Where:** `skills/`

**When to create:**
- After using tool 3+ times successfully
- Established team convention
- Proven pattern worth reusing

**Structure:**
```markdown
---
name: skill-name
description: Brief description
version: 1.0.0
tags: [tag1, tag2]
---

# Skill Name

## Overview
[What this skill does]

## Instructions
[Step-by-step for agents]

## Examples
[Concrete usage]
```

**Example:** `skills/git-workflow/SKILL.md`

---

### 3. External Documentation (Tool Knowledge)

**What:** Links to official tool documentation

**Where:** `external-refs.md` or `external-refs/`

**What to add:**
```markdown
### Tool Name
- **Official Docs:** https://tool.com/docs
- **What it is:** Brief description
- **Our skills:** Link to our usage patterns
```

**Example:**
```markdown
### pytest
- **Official Docs:** https://docs.pytest.org/
- **What it is:** Python testing framework
- **Our skills:** skills/python-testing/SKILL.md
```

---

## Decision Tree

**When documenting something, ask:**

```
Is it strategic/future thinking?
  YES → vision/
  NO  ↓

Is it a technical specification?
  YES → implementation/
  NO  ↓

Is it how WE use a tool?
  YES → skills/
  NO  ↓

Is it a historical record/session?
  YES → sessions/
  NO  ↓

Is it current sprint work?
  YES → execution/
  NO  ↓

Is it an external tool reference?
  YES → external-refs.md
  NO  → Ask user where it goes
```

---

## Common Scenarios

### Scenario: Discovered New Pattern

**Question:** "I found a better way to write pytest tests"

**Action:**
1. Check if `skills/python-testing/SKILL.md` exists
2. If YES: Update existing skill
3. If NO: Create new skill
4. Include YAML frontmatter
5. Document pattern with examples

---

### Scenario: Strategic Planning Session

**Question:** "We decided on new architecture"

**Action:**
1. Create `sessions/SESSION_YYYY_MM_DD.md`
2. Document discussion, decisions, insights
3. Extract vision to `vision/NEW_ARCHITECTURE.md`
4. Link from session to vision doc

---

### Scenario: Sprint Planning

**Question:** "Planning Sprint 8A"

**Action:**
1. Create `execution/sprints/sprint-8A-{name}.md`
2. Include tasks, estimates, success criteria
3. Reference relevant skills (git-workflow, python-testing)
4. Update `execution/README.md` current sprint

---

### Scenario: Need Tool Documentation

**Question:** "How does pytest work?"

**Action:**
1. Check `external-refs.md` for link
2. If not there, add reference
3. Do NOT duplicate official docs
4. Do document OUR usage in skills/

---

## Quality Standards

### All Documents Must Have

**1. Clear header:**
```markdown
# Document Title
**Purpose:** One sentence
**Status:** 🟢 Complete | 🟡 In Progress | 🔴 Planned
```

**2. Last updated date:**
```markdown
**Last Updated:** October 18, 2025
```

**3. Links to related docs:**
```markdown
## Related
- [Doc 1](../vision/doc1.md)
- [Doc 2](../implementation/doc2.md)
```

---

### Skills Must Have

**YAML frontmatter:**
```yaml
---
name: skill-name
description: Brief description
version: 1.0.0
author: Globex Systems
tags: [tag1, tag2]
---
```

**Clear sections:**
- Overview
- Instructions
- Examples
- Related

---

## Update Patterns

### Update Existing Doc

**When:**
- New information about same topic
- Better example found
- Pattern improved

**How:**
```bash
# 1. Read current version
cat docs/skills/python-testing/SKILL.md

# 2. Edit with improvements
vim docs/skills/python-testing/SKILL.md

# 3. Update version if major change
version: 1.0.0 → 1.1.0

# 4. Update last_updated date

# 5. Commit
git commit -m "docs: Update python-testing skill with new pattern"
```

---

### Create New Doc

**When:**
- New topic not covered
- New skill discovered
- New vision/session

**How:**
1. Choose correct directory (use decision tree)
2. Follow template for that type
3. Include all required sections
4. Link from INDEX.md if major
5. Commit with descriptive message

---

## Agent Responsibilities

### All Agents

**After completing work:**
- Document new skills in `skills/`
- Update sprint status in `execution/`
- Add session notes if strategic

---

### CEO Agent

**Responsibilities:**
- Create sprint plans in `execution/sprints/`
- Document strategic sessions in `sessions/`
- Update `INDEX.md` when structure changes
- Maintain documentation quality

---

### Specialized Agents

**Backend/Frontend/Integration:**
- Document technical patterns as skills
- Update implementation specs
- Add examples to existing skills

**Testing:**
- Document testing patterns
- Update quality standards
- Add test examples

---

## Quick Reference

**Need to document...**

**Strategic insight?**
→ `vision/{topic}.md`

**How to build something?**
→ `implementation/{feature}-spec.md`

**How WE use a tool?**
→ `skills/{tool-name}/SKILL.md`

**Session decisions?**
→ `sessions/SESSION_YYYY_MM_DD.md`

**Current work?**
→ `execution/sprints/sprint-{N}-{name}.md`

**External tool reference?**
→ `external-refs.md` (link only)

---

## Related

**Internal:**
- `INDEX.md` - Master navigation
- `README.md` - Agent entry point
- `CONTRIBUTING.md` - Full contribution guide

**Skills:**
- `skills/git-workflow/SKILL.md` - How we commit docs
- `skills/sprint-planning/SKILL.md` - How CEO plans sprints

**Philosophy:**
- `vision/CLAUDE_AS_TRANSPORT_LAYER.md` - Documentation philosophy
- `vision/AGENT_SKILLS_MEMO.md` - Skills framework

---

**Status:** 🟢 Active
**Last Updated:** October 18, 2025
