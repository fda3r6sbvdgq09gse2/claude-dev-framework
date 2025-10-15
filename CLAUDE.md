# CLAUDE.md - Claude Multi-Agent Development Framework
*AI-Assisted Development Framework Documentation*

## 🚀 **START HERE** - Framework Setup

**CRITICAL**: This is a locked framework repository. Changes should be carefully validated.

### For Framework Users

If you're using this framework in your project, add it to your `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "Claude-Dev-Framework": {
      "source": {
        "source": "github",
        "repo": "fda3r6sbvdgq09gse2/claude-dev-framework"
      }
    }
  }
}
```

Then install plugins:
```bash
/plugin marketplace add fda3r6sbvdgq09gse2/claude-dev-framework
/plugin install development-agents@Claude-Dev-Framework
/plugin install management-agents@Claude-Dev-Framework
```

### Customize for Your Organization

**IMPORTANT**: Replace "ORG_NAME" with your company/organization name!

All branding is controlled from a single file: **`VARIABLES.yaml`**

```yaml
owner:
  name: "ORG_NAME"  # ⚠️ CHANGE THIS
  email: "contact@example.com"
  github_username: "your-github-username"
```

After changing `VARIABLES.yaml`, update these files to match:
- `.claude-plugin/marketplace.json` (owner.name)
- `README.md` (Built by section)
- `CHANGELOG.md` (header)
- `config/STAKEHOLDERS.yaml` (organization section)
- `plugins/*/plugin.json` (author fields)

See `VARIABLES.yaml` for complete customization options.

---

### For Framework Developers

1. **GitHub MCP Setup** (Required for automation)
   ```bash
   # Set environment variable with your GitHub token
   export GITHUB_TOKEN="ghp_your_token_here"
   ```

2. **Enable Auto-Push** (Optional)
   ```bash
   # Enable automatic commit/push on marketplace changes
   export CLAUDE_CODE_AUTO_PUSH=true
   ```

---

## 🏗️ Framework Architecture

### Plugin Structure

The framework is organized into component-based plugins:

```
claude-dev-framework/
├── .claude/
│   ├── settings.json          # Framework settings
│   └── hooks.json             # Automated workflows
├── .claude-plugin/
│   └── marketplace.json       # Plugin registry (auto-validated)
├── .mcp.json                  # GitHub MCP configuration
├── plugins/
│   ├── backend-agent/
│   │   └── agents/backend.md
│   ├── frontend-agent/
│   │   └── agents/frontend.md
│   ├── integration-agent/
│   │   └── agents/integration.md
│   ├── testing-agent/
│   │   └── agents/testing.md
│   ├── ceo-agent/
│   │   └── agents/ceo.md
│   ├── documentation-agent/
│   │   └── agents/documentation.md
│   ├── devops-agent/
│   │   └── agents/devops.md
│   ├── qa-automation-agent/
│   │   └── agents/qa-automation.md
│   ├── ux-product-agent/
│   │   └── agents/ux-product.md
│   └── context-management-plugin/
│       └── commands/
├── scripts/
│   └── validate-marketplace.sh  # Auto-validates marketplace.json
└── CLAUDE.md                    # This file
```

### Available Plugins

#### Development Agents
- **backend-agent**: API, database, and data processing
- **frontend-agent**: UI/UX implementation
- **integration-agent**: Business logic and workflow coordination
- **testing-agent**: Quality assurance and validation

#### Management Agents
- **ceo-agent**: Sprint planning and tactical coordination
- **documentation-agent**: READMEs, API docs, guides
- **devops-agent**: CI/CD, deployment, infrastructure

#### Quality Agents
- **qa-automation-agent**: Test automation
- **ux-product-agent**: User experience and product decisions

---

## 🤖 Automated Workflows

### Marketplace Validation

**IMPORTANT**: The marketplace.json file is automatically validated on every change!

#### How It Works

1. **Hook Trigger**: Any Edit/Write to `.claude-plugin/marketplace.json`
2. **Validation**: `scripts/validate-marketplace.sh` runs automatically
3. **Checks**:
   - JSON syntax
   - Required fields (name, version, owner, plugins)
   - No `requires` fields (not supported by Claude Code schema)
   - Command paths must start with `./` and end with `.md`
   - Agent paths must start with `./` and end with `.md`
4. **Auto-Push** (if enabled): Valid changes are committed and pushed

#### Configuration

**Hooks** (`.claude/hooks.json`):
```json
{
  "PostToolUse": [
    {
      "matcher": "Edit(.claude-plugin/marketplace.json:*)",
      "hooks": [
        {
          "type": "command",
          "command": "./scripts/validate-marketplace.sh"
        }
      ]
    }
  ]
}
```

**Auto-Push**: Set `CLAUDE_CODE_AUTO_PUSH=true` to enable automatic commits

### GitHub MCP Integration

The framework uses GitHub's official MCP server for automation.

**Configuration** (`.mcp.json`):
```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Setup**:
1. Create GitHub Personal Access Token with `repo` scope
2. Set environment variable: `export GITHUB_TOKEN="ghp_..."`
3. MCP will be available to Claude Code automatically

**Capabilities**:
- Create/update files
- Manage branches
- Create pull requests
- Search code
- Manage issues

---

## 📚 Marketplace Schema Reference

### Valid Plugin Structure

```json
{
  "name": "plugin-name",
  "source": "./plugins/plugin-directory",
  "description": "Plugin description",
  "version": "2.0.0",
  "category": "development|management|quality|automation|utilities",
  "agents": [
    "./plugins/agent-name/agents/agent.md"
  ],
  "commands": [
    "./commands/command-name.md"
  ],
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "pattern",
        "hooks": [{"type": "command", "command": "script.sh"}]
      }
    ]
  },
  "keywords": ["tag1", "tag2"],
  "strict": false
}
```

### Invalid Patterns (Will Fail Validation)

❌ **`requires` field** (not supported):
```json
{
  "name": "bad-plugin",
  "requires": ["Read", "Write"]  // ❌ Not valid!
}
```

❌ **Invalid command paths**:
```json
{
  "commands": [
    "/absolute-path.md",        // ❌ Must start with ./
    "./relative-path",          // ❌ Must end with .md
    "no-leading-dot.md"         // ❌ Must start with ./
  ]
}
```

---

## 🔧 Development Workflow

### Making Changes to the Framework

1. **Edit marketplace.json**:
   ```bash
   # Edit is automatically validated by hooks
   claude
   > Edit .claude-plugin/marketplace.json
   ```

2. **Validation runs automatically**:
   - ✅ If valid: Continues
   - ❌ If invalid: Shows errors, blocks commit

3. **Commit** (manual or automatic):
   ```bash
   # Manual:
   git add .claude-plugin/marketplace.json
   git commit -m "feat: Add new plugin"
   git push

   # Automatic (if CLAUDE_CODE_AUTO_PUSH=true):
   # Handled by validate-marketplace.sh
   ```

### Adding New Plugins

1. **Create plugin directory**:
   ```bash
   mkdir -p plugins/new-agent/agents
   ```

2. **Add agent file**:
   ```bash
   # Create plugins/new-agent/agents/new-agent.md
   ```

3. **Update marketplace.json**:
   - Add plugin entry or update existing plugin group
   - Validation runs automatically

4. **Test installation**:
   ```bash
   /plugin marketplace refresh
   /plugin install plugin-name@Claude-Dev-Framework
   ```

### Validation Script

Run manually anytime:
```bash
./scripts/validate-marketplace.sh

# With auto-push:
CLAUDE_CODE_AUTO_PUSH=true ./scripts/validate-marketplace.sh
```

---

## 🎯 Best Practices

### For Framework Maintainers

1. **Always validate** before pushing:
   - Hooks do this automatically
   - But test manually if making bulk changes

2. **Use semantic versioning**:
   - Bump version in marketplace.json
   - Document changes in commit message

3. **Test plugin installation**:
   - Install from GitHub in test project
   - Verify all agents load correctly

4. **Keep plugins focused**:
   - Single responsibility per agent
   - Group related agents into logical plugins

5. **Document changes**:
   - Update this file for major changes
   - Add comments in marketplace.json for complex configurations

### For Framework Users

1. **Lock framework version**:
   - Pin to specific git commit or tag
   - Test upgrades in dev environment first

2. **Check for updates**:
   ```bash
   /plugin marketplace refresh
   ```

3. **Report issues**:
   - Open GitHub issues for bugs
   - Include marketplace version

---

## 🔍 Troubleshooting

### Validation Errors

**"Unrecognized key 'requires'"**:
- Remove `requires` field from plugin entries
- Claude Code doesn't support this field

**"Invalid command paths"**:
- Ensure all commands start with `./`
- Ensure all commands end with `.md`
- Use relative paths from plugin root

**"Missing required field"**:
- Check name, version, owner, plugins are present
- Validate JSON syntax with `jq empty marketplace.json`

### Hook Not Running

1. Check hooks enabled:
   ```json
   {
     "hooks": {
       "enabled": true,
       "configFile": ".claude/hooks.json"
     }
   }
   ```

2. Verify script is executable:
   ```bash
   chmod +x scripts/validate-marketplace.sh
   ```

3. Check hook matcher pattern:
   - Must match file path exactly
   - Use wildcards: `Edit(.claude-plugin/marketplace.json:*)`

### MCP Connection Issues

1. **Check token**:
   ```bash
   echo $GITHUB_TOKEN
   ```

2. **Test MCP**:
   ```bash
   claude mcp list
   ```

3. **Verify .mcp.json**:
   - Must be in project root
   - Token must have correct scopes (repo)

---

## 📖 Additional Resources

- **Claude Code MCP Docs**: https://docs.claude.com/en/docs/claude-code/mcp
- **Plugin Marketplace Docs**: https://docs.claude.com/en/docs/claude-code/plugin-marketplaces
- **GitHub MCP Server**: https://github.com/github/github-mcp-server
- **Model Context Protocol**: https://modelcontextprotocol.io

---

## 🔄 Version History

- **v2.0.0** (2025-10-15): Component-based reorganization
  - Grouped agents into logical plugins
  - Added automated validation
  - Integrated GitHub MCP
  - Removed unsupported schema fields

---

*This document evolves with the framework. Last updated: 2025-10-15*
