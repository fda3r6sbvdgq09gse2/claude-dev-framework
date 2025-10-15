# Single Source of Truth (SSOT) System
*Never Hardcode, Always Reference*
*Version: 1.0.0*

## 🎯 The Problem

**Before:**
```markdown
Install claude-dev-framework from:
https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework

Backend agent earns +30 XP for complex tasks.

Base salary at Level 2 is $500.
```

**Issues:**
- Values repeated across 50+ files
- Changes require updating everywhere
- Easy to have inconsistencies
- Hard to maintain

---

## ✅ The Solution

**After:**
```markdown
Install {{var:project.name}} from {{var:github.url}}

Backend agent earns {{var:rewards.xp_system.earning_rates.task_complex}} XP for complex tasks.

Base salary at Level 2 is {{var:rewards.salary.base_rates.level_2}} {{var:rewards.salary.currency}}.
```

**Benefits:**
- ✅ Single source of truth
- ✅ Change once, update everywhere
- ✅ No inconsistencies possible
- ✅ Easy to maintain

---

## 📋 Variable Registry Location

**The ONLY place variables are defined:**
```
config/VARIABLES.yaml
```

**Everything else references this file.**

---

## 🔧 How to Reference Variables

### In Markdown Documentation

```markdown
# Install {{var:project.display_name}}

Clone from {{var:github.url}}

```bash
git clone {{var:github.url}}
cd {{var:project.name}}
```

Agent earns {{var:rewards.xp_system.earning_rates.task_complex}} XP for complex tasks.
```

### In Python Code

```python
from config import get_var, get_vars

# Get single variable
project_name = get_var("project.name")
# Returns: "claude-dev-framework"

# Get nested variable
xp_for_complex = get_var("rewards.xp_system.earning_rates.task_complex")
# Returns: 30

# Get entire section
all_models = get_vars("models")
# Returns: dict with all model definitions

# With default value
custom = get_var("custom.setting", default="fallback")
```

### In Shell Scripts

```bash
#!/bin/bash

# Source the variables
source config/variables.sh

echo "Installing $PROJECT_NAME"
git clone $GITHUB_URL
cd $PROJECT_NAME
```

### In Jinja2 Templates

```jinja
{# Install {{ config.project.display_name }} #}

Base salary at Level {{ level }} is:
${{ config.rewards.salary.base_rates['level_' ~ level] }}

{% for agent in config.agents.core_team %}
- {{ agent.name }}: {{ agent.default_model }}
{% endfor %}
```

### In JSON/YAML Config

```yaml
# Use $ref syntax for JSON Schema
project_info:
  $ref: "config/VARIABLES.yaml#/project"

# Or use template substitution
github_url: "${github.url}"
```

---

## 🔍 Variable Categories

### Project Metadata
```yaml
{{var:project.name}}                    # claude-dev-framework
{{var:project.display_name}}            # Claude Multi-Agent Framework
{{var:project.version}}                 # 1.0.0
{{var:github.owner}}                    # fda3r6sbvdgq09gse2
{{var:github.repository}}               # claude-dev-framework
{{var:github.url}}                      # Full GitHub URL
```

### Model Configuration
```yaml
{{var:models.MODEL_002_SONNET.id}}      # claude-3-5-sonnet-20241022
{{var:models.MODEL_001_OPUS.name}}      # Opus 4.1
{{var:models.MODEL_003_HAIKU.tier}}     # efficiency
```

### Reward System
```yaml
{{var:rewards.xp_system.earning_rates.task_complex}}     # 30
{{var:rewards.salary.base_rates.level_2}}                # 500
{{var:rewards.attributes.scale[1]}}                      # 20 (max)
```

### Quality Standards
```yaml
{{var:quality.test_coverage_target}}    # 90
{{var:quality.api_timeout_seconds}}     # 5
{{var:quality.code_style}}              # black
```

### Metrics
```yaml
{{var:metrics.sprints_completed}}       # 6A
{{var:metrics.patterns_extracted}}      # 23
{{var:metrics.token_efficiency_savings}}# 80
```

---

## 🚫 Hardcoded Values to NEVER Use

### ❌ DON'T DO THIS

```markdown
# Bad - Hardcoded GitHub username
git clone https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework

# Bad - Hardcoded XP values
Backend earns 30 XP for complex tasks.

# Bad - Hardcoded salary
Level 2 agents earn $500 base salary.

# Bad - Hardcoded file paths
Install agents to ~/.claude/agents

# Bad - Hardcoded model names
Use claude-3-5-sonnet-20241022 for workers.
```

### ✅ DO THIS INSTEAD

```markdown
# Good - References variables
git clone {{var:github.url}}

# Good
Backend earns {{var:rewards.xp_system.earning_rates.task_complex}} XP for complex tasks.

# Good
Level 2 agents earn {{var:rewards.salary.base_rates.level_2}} {{var:rewards.salary.currency}} base salary.

# Good
Install agents to {{var:paths.global_agents}}

# Good
Use {{var:models.MODEL_002_SONNET.name}} for workers.
```

---

## 🔧 Adding New Variables

### Step 1: Add to VARIABLES.yaml

```yaml
# config/VARIABLES.yaml

new_feature:
  setting_name: "value"
  numeric_setting: 42
  list_setting:
    - "item1"
    - "item2"
```

### Step 2: Update References

```markdown
# In docs
The setting is {{var:new_feature.setting_name}}.

# In code
value = get_var("new_feature.setting_name")
```

### Step 3: Validate

```bash
# Check all references are valid
./scripts/validate_variables.sh
```

---

## 🔍 Validation System

### Automatic Checks

The framework includes validation to catch hardcoded values:

```bash
# Pre-commit hook
./scripts/check_hardcoded_values.sh

# Manual check
./scripts/validate_ssot.py
```

### What Gets Flagged

```yaml
patterns_to_flag:
  - "fda3r6sbvdgq09gse2"          # GitHub username
  - "claude-dev-framework"         # Repo name
  - "claude-3-5-sonnet-20241022"  # Model ID
  - specific_numbers: [5, 15, 30] # Common XP values
  - specific_money: ["$500", "$300"] # Salary amounts
  - file_paths: ["~/.claude", "/Users/"]
```

### Exceptions

Some hardcoded values are OK:
```yaml
allowed_hardcoded:
  - In VARIABLES.yaml itself
  - In example code blocks (markdown code fences)
  - In test fixtures
  - In historical logs/changelogs
```

---

## 📝 Migration Strategy

### For Existing Documents

1. **Identify Hardcoded Values**
   ```bash
   grep -r "fda3r6sbvdgq09gse2" docs/
   grep -r "claude-dev-framework" docs/
   ```

2. **Replace with Variable References**
   ```bash
   # Manual: Edit files
   # or
   # Automatic: Run migration script
   ./scripts/migrate_to_ssot.py docs/
   ```

3. **Validate**
   ```bash
   ./scripts/validate_ssot.py
   ```

### Example Migration

**Before:**
```markdown
# Book Cataloger Framework

Install from https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework

Backend agents earn 30 XP for complex tasks and have a base salary of $500 at Level 2.
```

**After:**
```markdown
# {{var:project.display_name}}

Install from {{var:github.url}}

Backend agents earn {{var:rewards.xp_system.earning_rates.task_complex}} XP for complex tasks and have a base salary of {{var:rewards.salary.base_rates.level_2}} {{var:rewards.salary.currency}} at Level 2.
```

---

## 🎯 Variable Processing

### Build-Time Processing

When building docs:
```bash
# Process all variables
./scripts/build_docs.py

# This replaces all {{var:...}} with actual values
# Output: docs/build/
```

### Runtime Processing

In application code:
```python
# Variables loaded at startup
from config import config

# Access anywhere
project_name = config.project.name
```

---

## 🔄 Update Workflow

### Changing a Variable

1. **Update VARIABLES.yaml**
   ```yaml
   rewards:
     xp_system:
       earning_rates:
         task_complex: 35  # Changed from 30
   ```

2. **All References Auto-Update**
   - Documentation regenerated
   - Code uses new value
   - No manual updates needed

3. **Commit**
   ```bash
   git add config/VARIABLES.yaml
   git commit -m "Increase complex task XP from 30 to 35"
   ```

### Version Control

```yaml
# Track changes in VARIABLES.yaml
project:
  version: "1.1.0"  # Bump version

# Changelog auto-generated
# "v1.1.0: Increased complex task XP: 30 → 35"
```

---

## 🏗️ Architecture Benefits

### Maintainability
- Change once, update everywhere
- No inconsistencies
- Easy refactoring

### Consistency
- Same values across all docs
- Synchronized code and documentation
- Single source of truth

### Flexibility
- Easy to customize per deployment
- Environment-specific configs
- A/B testing configurations

### Collaboration
- Clear where to look for values
- No confusion about "which value is right"
- Easy code reviews (check VARIABLES.yaml)

---

## 💡 Advanced Use Cases

### Multi-Environment

```yaml
# config/VARIABLES.prod.yaml
rewards:
  salary:
    base_rates:
      level_2: 500

# config/VARIABLES.dev.yaml
rewards:
  salary:
    base_rates:
      level_2: 50  # 10x cheaper for testing
```

### Team Customization

```yaml
# config/VARIABLES.team-a.yaml
github:
  owner: "team-a-org"

# config/VARIABLES.team-b.yaml
github:
  owner: "team-b-org"
```

### Automated Testing

```python
def test_variable_references():
    """Ensure all {{var:...}} references are valid"""
    docs = load_all_documentation()
    for doc in docs:
        refs = extract_variable_references(doc)
        for ref in refs:
            assert variable_exists(ref), f"Invalid reference: {ref}"
```

---

## 📊 Success Metrics

After implementing SSOT:

```yaml
before:
  - hardcoded_values: 1247
  - update_time_minutes: 120
  - inconsistencies: 37

after:
  - hardcoded_values: 0
  - update_time_minutes: 2
  - inconsistencies: 0

improvement:
  - maintenance_time: -98%
  - consistency: 100%
  - confidence: High
```

---

## 🎯 The Golden Rules

1. **Never Hardcode** - Always use {{var:...}}
2. **One Source** - config/VARIABLES.yaml only
3. **Reference Everywhere** - Docs, code, configs
4. **Validate Always** - Pre-commit checks
5. **Document Changes** - Update changelog

---

## 📚 Related Documentation

- [Variable Registry](../config/VARIABLES.yaml) - The source of truth
- [Validation Scripts](../scripts/validate_ssot.py) - Check compliance
- [Migration Guide](MIGRATION_TO_SSOT.md) - Convert existing docs

---

**Remember:** If you type a value twice, you're doing it wrong. Define once, reference everywhere.

*"The best documentation is documentation that can't be wrong."*
