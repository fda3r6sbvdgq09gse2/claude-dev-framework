# Configuration Templates
*Ready-to-use settings.json templates for claude-multi-agent-framework*

## 📂 Templates

### 1. `user-settings.json`
**Location**: `~/.claude/settings.json`
**Scope**: All projects for this user
**Version Control**: Not in git (personal)

**What it configures:**
- Enabled agents (full-time team)
- Monitoring & telemetry
- Framework marketplace
- User-level permissions
- Default behavior

**Installation:**
```bash
# Copy template to user settings
cp config/templates/user-settings.json ~/.claude/settings.json

# Edit to customize
code ~/.claude/settings.json
```

---

### 2. `project-settings.json`
**Location**: `.claude/settings.json` *(in your project)*
**Scope**: This project only (shared with team)
**Version Control**: ✅ Checked into git

**What it configures:**
- Project-specific agents
- Project environment variables
- Project-level permissions
- Test commands

**Installation:**
```bash
# In your project directory
mkdir -p .claude
cp ~/dev/claude-dev-framework/config/templates/project-settings.json .claude/settings.json

# Customize for your project
code .claude/settings.json

# Update PROJECT_NAME and other variables
sed -i '' 's/your-project-name/my-actual-project/g' .claude/settings.json

# Commit to git
git add .claude/settings.json
git commit -m "Add Claude framework configuration"
```

---

### 3. `project-local-settings.json`
**Location**: `.claude/settings.local.json` *(in your project)*
**Scope**: Personal overrides (not shared)
**Version Control**: ❌ Add to .gitignore

**What it configures:**
- Personal API keys
- Local development settings
- Experimental plugins
- Personal preferences

**Installation:**
```bash
# In your project directory
cp ~/dev/claude-dev-framework/config/templates/project-local-settings.json .claude/settings.local.json

# Add to .gitignore
echo ".claude/settings.local.json" >> .gitignore

# Edit with your personal settings
code .claude/settings.local.json
```

---

## 🔀 Configuration Hierarchy

Claude Code loads settings in this order (later overrides earlier):

```
1. User Settings              (~/.claude/settings.json)
2. Project Shared Settings    (.claude/settings.json)
3. Project Local Settings     (.claude/settings.local.json)
4. Command Line Arguments     (--env KEY=value)
```

**Example:**
- User settings enable all 7 agents globally
- Project settings enable only 4 agents needed for this project
- Project local adds your personal API key
- Result: Project uses 4 agents with your API key

---

## 🚀 Quick Start

### New Framework User

```bash
# 1. Install user settings (do once)
cp config/templates/user-settings.json ~/.claude/settings.json

# 2. Create user memory
cat > ~/.claude/CLAUDE.md << 'EOF'
# Personal Claude Instructions

Using claude-multi-agent-framework.
Agents: Backend, Frontend, CEO, Integration, Testing, DevOps, Documentation.
EOF

# 3. Install agent profiles
mkdir -p ~/.claude/agents
cp plugins/*/agent.md ~/.claude/agents/

# Done! Framework available in all projects.
```

---

### New Project Setup

```bash
cd your-project

# 1. Initialize Claude
claude init

# 2. Install project settings
cp ~/dev/claude-dev-framework/config/templates/project-settings.json .claude/settings.json

# 3. Customize project settings
code .claude/settings.json
# Update: PROJECT_NAME, enabled agents

# 4. Create personal local settings
cp ~/dev/claude-dev-framework/config/templates/project-local-settings.json .claude/settings.local.json

# 5. Add to .gitignore
echo ".claude/settings.local.json" >> .gitignore

# 6. Create project memory
cat > CLAUDE.md << 'EOF'
# Project: Your Project Name

@~/.claude/CLAUDE.md
EOF

# 7. Commit shared settings
git add .claude/settings.json CLAUDE.md .gitignore
git commit -m "Initialize Claude framework"
```

---

## 📝 Customization Guide

### Enable/Disable Agents

```json
{
  "enabledPlugins": {
    "backend-agent@claude-multi-agent-framework": true,
    "frontend-agent@claude-multi-agent-framework": false,
    "testing-agent@claude-multi-agent-framework": true
  }
}
```

### Add Custom Permissions

```json
{
  "permissions": {
    "allow": [
      "Bash(make test)",
      "Bash(cargo build)"
    ],
    "deny": [
      "Bash(sudo *)",
      "Write(production.env)"
    ]
  }
}
```

### Configure Monitoring

```json
{
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://localhost:4317",
    "OTEL_RESOURCE_ATTRIBUTES": "project.name=my-app,team=backend"
  }
}
```

### Add Environment Variables

```json
{
  "env": {
    "PROJECT_NAME": "my-awesome-app",
    "ENVIRONMENT": "development",
    "LOG_LEVEL": "debug"
  }
}
```

---

## 🔐 Security Best Practices

### ✅ DO:
- Keep API keys in `.local.json` (gitignored)
- Check shared settings into git
- Use environment variables for secrets
- Deny access to sensitive files (.env, .key, .pem)
- Restrict dangerous bash commands

### ❌ DON'T:
- Commit `.local.json` to git
- Put API keys in shared settings
- Allow unrestricted bash access
- Skip the deny rules
- Share personal settings

---

## 🐛 Troubleshooting

### Settings Not Loading

```bash
# Check if settings file is valid JSON
cat ~/.claude/settings.json | python -m json.tool

# Check file permissions
ls -la ~/.claude/settings.json
```

### Agent Not Available

```bash
# Check if plugin is enabled
cat ~/.claude/settings.json | grep "backend-agent"

# Should see: "backend-agent@claude-multi-agent-framework": true
```

### Permissions Denied

```bash
# Check permission settings
cat .claude/settings.json | grep -A 10 "permissions"

# Add to allow list if needed
```

---

## 📚 References

- [Official Settings Docs](https://docs.claude.com/en/docs/claude-code/settings)
- [Configuration Architecture](../../docs/CONFIGURATION_ARCHITECTURE.md)
- [Context Optimization](../../docs/CONTEXT_OPTIMIZATION.md)

---

## 🤝 Contributing

Found a better configuration? Improved template?
Open a PR to share with the community!

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
