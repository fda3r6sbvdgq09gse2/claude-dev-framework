# Variable Links - Knowledge Graph Index
*Bidirectional mapping of VARIABLES.yaml → Usage Sites*

## 📖 How to Read This

- **Source**: `[[VARIABLES.yaml#path.to.variable]]`
- **Usage**: `[[file:line]]` - Description
- **Status**: 🟢 Synced | 🟡 Needs Update | 🔴 Broken

---

## Framework Identity Variables

### `framework.name`
**Value**: `"ClaudeDevFramework"`
**Type**: String (PascalCase identifier)
**Used in**:
- `[[.claude-plugin/marketplace.json:2]]` - Marketplace name
- `[[README.md:1]]` - Repository title
- `[[CLAUDE.md:1]]` - Documentation title

### `framework.display_name`
**Value**: `"Claude Multi-Agent Development Framework"`
**Type**: String (Human-readable)
**Used in**:
- `[[README.md:1]]` - Full repository title
- `[[CLAUDE.md:1]]` - Header
- `[[package.json:2]]` - (if exists)

### `framework.version`
**Value**: `"2.0.1"`
**Type**: SemVer string
**Used in**:
- `[[.claude-plugin/marketplace.json:3]]` - Marketplace version
- `[[plugins/agent-backend/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-frontend/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-integration/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-testing/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-ceo/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-documentation/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-devops/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-qa-automation/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/agent-ux-product/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/command-context-management/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[plugins/utility-reward-system/.claude-plugin/plugin.json:3]]` - Plugin version
- `[[README.md:5]]` - Version badge
- `[[CHANGELOG.md:1]]` - Current version header

### `framework.description`
**Value**: `"Multi-agent development framework with standardized {type}-{name} plugin architecture"`
**Used in**:
- `[[.claude-plugin/marketplace.json:145]]` - metadata.description
- `[[README.md:10]]` - Overview section

### `framework.license`
**Value**: `"MIT"`
**Used in**:
- `[[.claude-plugin/marketplace.json:148]]` - metadata.license
- `[[plugins/*/.claude-plugin/plugin.json:10]]` - License field (11 files)
- `[[README.md:4]]` - License badge
- `[[LICENSE:1]]` - License file

---

## Owner/Maintainer Variables

### `owner.name` ⚠️ **CUSTOMIZE THIS**
**Value**: `"ORG_NAME"` (placeholder)
**Type**: String
**Purpose**: Public-facing organization/author name
**Used in**:
- `[[.claude-plugin/marketplace.json:5]]` - owner.name
- `[[plugins/agent-backend/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-frontend/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-integration/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-testing/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-ceo/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-documentation/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-devops/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-qa-automation/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/agent-ux-product/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/command-context-management/.claude-plugin/plugin.json:6]]` - author.name
- `[[plugins/utility-reward-system/.claude-plugin/plugin.json:6]]` - author.name
- `[[README.md:TBD]]` - "Built by" section
- `[[CLAUDE.md:39]]` - Customization instructions
- `[[config/STAKEHOLDERS.yaml:TBD]]` - Organization field

### `owner.email`
**Value**: `"contact@example.com"` (placeholder)
**Type**: String (email)
**Used in**:
- `[[(optional) .claude-plugin/marketplace.json]]` - owner.email
- `[[(optional) plugins/*/.claude-plugin/plugin.json]]` - author.email

### `owner.github_username`
**Value**: `"fda3r6sbvdgq09gse2"`
**Type**: String
**Used in**:
- `[[.claude-plugin/marketplace.json:6]]` - owner.github
- `[[README.md:5]]` - GitHub badge URL
- `[[owner.github_url]]` - Composed into full URL

### `owner.github_repo`
**Value**: `"claude-dev-framework"`
**Type**: String
**Used in**:
- `[[owner.github_url]]` - Composed into full URL
- `[[.claude-plugin/marketplace.json:7]]` - owner.repository

### `owner.github_url`
**Value**: `"https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework"`
**Type**: String (URL)
**Used in**:
- `[[.claude-plugin/marketplace.json:7]]` - owner.repository
- `[[plugins/agent-backend/.claude-plugin/plugin.json:8]]` - homepage
- `[[plugins/agent-backend/.claude-plugin/plugin.json:9]]` - repository
- `[[plugins/agent-frontend/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-integration/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-testing/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-ceo/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-documentation/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-devops/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-qa-automation/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/agent-ux-product/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[plugins/command-context-management/.claude-plugin/plugin.json:8]]` - homepage
- `[[plugins/utility-reward-system/.claude-plugin/plugin.json:8-9]]` - homepage, repository
- `[[README.md:TBD]]` - Various links
- `[[CLAUDE.md:TBD]]` - Installation instructions
- `[[.claude-plugin/marketplace.json:146-147]]` - metadata.homepage, metadata.documentation

---

## Marketplace Configuration

### `marketplace.id`
**Value**: `"Claude-Dev-Framework"`
**Type**: String (Marketplace identifier)
**Used in**:
- `[[.claude-plugin/marketplace.json:2]]` - name field
- `[[CLAUDE.md:15]]` - extraKnownMarketplaces key
- `[[README.md:TBD]]` - Installation instructions

### `marketplace.github_source`
**Value**: `"fda3r6sbvdgq09gse2/claude-dev-framework"`
**Type**: String (owner/repo format)
**Used in**:
- `[[CLAUDE.md:18]]` - GitHub source in settings.json
- `[[CLAUDE.md:27]]` - plugin marketplace add command
- `[[README.md:TBD]]` - Installation instructions

---

## Plugin Version Variables

### `plugin_versions.agent_backend`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-backend/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_frontend`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-frontend/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_integration`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-integration/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_testing`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-testing/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_ceo`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-ceo/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_documentation`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-documentation/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_devops`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-devops/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_qa_automation`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-qa-automation/.claude-plugin/plugin.json:3]]`

### `plugin_versions.agent_ux_product`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/agent-ux-product/.claude-plugin/plugin.json:3]]`

### `plugin_versions.command_context_management`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/command-context-management/.claude-plugin/plugin.json:3]]`

### `plugin_versions.utility_reward_system`
**Value**: `"2.0.1"`
**Used in**: `[[plugins/utility-reward-system/.claude-plugin/plugin.json:3]]`

---

## Model Configuration Variables

### `models.MODEL_001_OPUS.id`
**Value**: `"claude-opus-4-1-20250805"`
**Used in**:
- `[[config/permissions/ceo-agent-permissions.json:TBD]]`
- `[[README.md:23]]` - Model reference in agent table

### `models.MODEL_002_SONNET.id`
**Value**: `"claude-3-5-sonnet-20241022"`
**Used in**:
- `[[config/permissions/*-agent-permissions.json:TBD]]`
- `[[README.md:24-31]]` - Model references in agent table

### `models.MODEL_003_HAIKU.id`
**Value**: `"claude-3-5-haiku-20241022"`
**Used in**:
- `[[README.md:TBD]]` - Fallback model mentions

---

## Agent Configuration Variables

### `agents.core_team[0].plugin` (backend)
**Value**: `"agent-backend"`
**Used in**:
- `[[.claude-plugin/marketplace.json:13]]` - Plugin name in plugins array
- `[[plugins/agent-backend/]]` - Directory name

### `agents.core_team[1].plugin` (frontend)
**Value**: `"agent-frontend"`
**Used in**:
- `[[.claude-plugin/marketplace.json:24]]` - Plugin name
- `[[plugins/agent-frontend/]]` - Directory name

### `agents.core_team[2].plugin` (integration)
**Value**: `"agent-integration"`
**Used in**:
- `[[.claude-plugin/marketplace.json:36]]` - Plugin name
- `[[plugins/agent-integration/]]` - Directory name

### `agents.core_team[3].plugin` (testing)
**Value**: `"agent-testing"`
**Used in**:
- `[[.claude-plugin/marketplace.json:48]]` - Plugin name
- `[[plugins/agent-testing/]]` - Directory name

### `agents.core_team[4].plugin` (ceo)
**Value**: `"agent-ceo"`
**Used in**:
- `[[.claude-plugin/marketplace.json:60]]` - Plugin name
- `[[plugins/agent-ceo/]]` - Directory name

### `agents.optional_team[0].plugin` (documentation)
**Value**: `"agent-documentation"`
**Used in**:
- `[[.claude-plugin/marketplace.json:72]]` - Plugin name
- `[[plugins/agent-documentation/]]` - Directory name

### `agents.optional_team[1].plugin` (devops)
**Value**: `"agent-devops"`
**Used in**:
- `[[.claude-plugin/marketplace.json:84]]` - Plugin name
- `[[plugins/agent-devops/]]` - Directory name

### `agents.optional_team[2].plugin` (qa-automation)
**Value**: `"agent-qa-automation"`
**Used in**:
- `[[.claude-plugin/marketplace.json:96]]` - Plugin name
- `[[plugins/agent-qa-automation/]]` - Directory name

### `agents.optional_team[3].plugin` (ux-product)
**Value**: `"agent-ux-product"`
**Used in**:
- `[[.claude-plugin/marketplace.json:108]]` - Plugin name
- `[[plugins/agent-ux-product/]]` - Directory name

---

## Quality Standards

### `quality.test_coverage_minimum`
**Value**: `85`
**Used in**:
- `[[README.md:TBD]]` - Quality metrics section
- `[[.github/workflows/*.yml:TBD]]` - CI/CD coverage gates

### `quality.test_coverage_target`
**Value**: `90`
**Used in**:
- `[[README.md:TBD]]` - Quality goals

### `quality.code_style`
**Value**: `"black"`
**Used in**:
- `[[.github/workflows/*.yml:TBD]]` - Linting steps
- `[[README.md:TBD]]` - Development guidelines

---

## Reward System Variables

### `rewards.xp_system.earning_rates.*`
**Values**: Various XP amounts
**Used in**:
- `[[plugins/utility-reward-system/README.md:TBD]]` - XP system documentation
- `[[plugins/utility-reward-system/AGENT_ECONOMY.md:TBD]]` - Economy details

### `rewards.salary.base_rates.*`
**Values**: Salary tiers
**Used in**:
- `[[plugins/utility-reward-system/AGENT_ECONOMY.md:TBD]]` - Salary system

---

## 🔄 Maintenance

This file is **auto-generated** by `scripts/generate-links.py`

**Last Generated**: [Manual for now]
**Last Validated**: [Manual for now]

To regenerate:
```bash
python scripts/generate-links.py
```

To validate all links:
```bash
bash scripts/validate-variables.sh
```

---

## 📊 Statistics

- **Total Variables**: 50+
- **Total Usage Sites**: 150+
- **Files Linked**: 25+
- **Bidirectional Links**: ✅ Complete

---

## 🚨 Broken Links (Auto-detected)

*None currently - run validation script to check*

---

## 📝 Notes

- `TBD` = To Be Determined - needs manual verification of line numbers
- Links are fragile to line number changes - use sync script after edits
- Some variables are composed from others (e.g., `owner.github_url`)
- Plugin versions should all match `framework.version` for releases
