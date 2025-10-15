# Status Line Configuration
*Real-Time Visibility for Claude Multi-Agent Framework*

**Based on**: [Official Status Line Documentation](https://docs.claude.com/en/docs/claude-code/statusline)

## 🎯 What is the Status Line?

The status line displays contextual information at the bottom of your Claude Code terminal, updating in real-time as you work. It shows:

- 🤖 Current agent (Backend, Frontend, CEO, etc.)
- 👑/⚡/🍃 Current model (Opus, Sonnet, Haiku)
- 📁 Current project
- 💰 Session cost
- 📝 Code changes (+added/-removed)
- ⏱️  Session duration
- 📊 Context usage (coming soon)

**Updates**: Every 300ms when messages change

---

## 🚀 Quick Setup

### Option 1: Bash Status Line (Lightweight)

```bash
# 1. Copy statusline script to your home
cp config/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

# 2. Add to your settings.json
cat >> ~/.claude/settings.json << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  }
}
EOF
```

### Option 2: Python Status Line (Feature-Rich)

```bash
# 1. Copy Python statusline
cp config/statusline.py ~/.claude/statusline.py
chmod +x ~/.claude/statusline.py

# 2. Add to your settings.json
cat >> ~/.claude/settings.json << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.py",
    "padding": 0
  }
}
EOF
```

---

## 📊 What You'll See

### Example Status Lines

#### Working with Backend Agent on Sonnet
```
🤖 Backend | ⚡ Sonnet 4.5 | 📁 book-cataloger | 💰$0.45 | 📝 +127/-43 | ⏱️  12m
```

#### Strategic Planning with CEO on Opus
```
🤖 CEO | 👑 Opus 4.1 | 📁 my-project | 💰$0.12 | ⏱️  3m
```

#### Starting Fresh
```
🤖 General | ⚡ Sonnet 4.5 | 📁 claude-dev-framework
```

---

## 🎨 Icon Legend

| Icon | Meaning |
|------|---------|
| 🤖 | Current agent role |
| 👑 | Opus model (strategic) |
| ⚡ | Sonnet model (implementation) |
| 🍃 | Haiku model (fast tasks) |
| 📁 | Current project directory |
| 💰 | Session cost in USD |
| 📝 | Lines added/removed |
| ⏱️  | Session duration |
| 📊 | Context usage % (coming soon) |

---

## 🔧 Configuration Options

### settings.json Structure

```json
{
  "statusLine": {
    "type": "command",              // Required: always "command"
    "command": "path/to/script",    // Required: path to status line script
    "padding": 0                    // Optional: 0 = edge-to-edge
  }
}
```

### Available Input Variables

Your statusline script receives JSON with these variables:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.md",
  "cwd": "/current/working/directory",
  "model": {
    "id": "claude-sonnet-4-5",
    "display_name": "Sonnet 4.5"
  },
  "workspace": {
    "current_dir": "/path/to/project",
    "project_dir": "/path/to/project"
  },
  "version": "1.2.3",
  "cost": {
    "total": 0.45,
    "duration": 720,
    "lines_added": 127,
    "lines_removed": 43
  }
}
```

---

## 🎯 Agent Role Tracking

### How Agent Tracking Works

The statusline shows which agent you're currently using. This is tracked via:

**Option 1: Slash Commands** (Automatic)
```bash
# When you use /role-backend, it sets the agent marker
/role-backend
# Status line shows: 🤖 Backend | ...
```

**Option 2: Manual Marker** (For custom workflows)
```bash
# Set current agent manually
echo "Backend" > ~/.claude/.current_agent

# Clear agent marker
rm ~/.claude/.current_agent
```

**Option 3: Environment Variable**
```bash
# Set for this session
export CLAUDE_CURRENT_AGENT="Backend"
claude

# Status line shows: 🤖 Backend | ...
```

---

## 📝 Customization Guide

### Modify What's Displayed

Edit `statusline.sh` or `statusline.py` to customize:

```bash
# In statusline.sh, change the STATUS_LINE building section:

# Minimal version (just essentials)
STATUS_LINE="$MODEL_ICON $MODEL | 📁 $PROJECT"

# Verbose version (everything)
STATUS_LINE="🤖 $AGENT | $MODEL_ICON $MODEL | 📁 $PROJECT | $COST_DISPLAY | $CODE_STATS | $TIME_DISPLAY"

# Cost-focused version
STATUS_LINE="💰$COST | ⏱️ $TIME | $MODEL_ICON $MODEL"
```

### Add Custom Information

```bash
# Add git branch
GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "no-git")
STATUS_LINE="$STATUS_LINE | 🌿 $GIT_BRANCH"

# Add sprint info
SPRINT=$(cat .ai/current_sprint.txt 2>/dev/null || echo "")
if [ -n "$SPRINT" ]; then
    STATUS_LINE="$STATUS_LINE | 🏃 Sprint $SPRINT"
fi

# Add context warning
if [ -f ~/.claude/.context_warning ]; then
    STATUS_LINE="$STATUS_LINE | ⚠️  Context High"
fi
```

---

## 🐛 Troubleshooting

### Status Line Not Showing

```bash
# 1. Verify script exists and is executable
ls -la ~/.claude/statusline.sh
# Should show: -rwxr-xr-x

# 2. Test script manually
echo '{"model":{"display_name":"Sonnet 4.5"},"workspace":{"current_dir":"'$(pwd)'"},"cost":{}}' | ~/.claude/statusline.sh

# 3. Check settings.json is valid
cat ~/.claude/settings.json | python -m json.tool

# 4. Verify jq is installed (for bash version)
which jq
# If not: brew install jq  # macOS
```

### Script Errors

```bash
# Check script syntax
bash -n ~/.claude/statusline.sh

# Run with debug output
bash -x ~/.claude/statusline.sh < test_input.json

# For Python version
python3 ~/.claude/statusline.py < test_input.json
```

### Agent Not Showing

```bash
# Check if marker file exists
cat ~/.claude/.current_agent

# Set it manually
echo "Backend" > ~/.claude/.current_agent

# Clear if stuck
rm ~/.claude/.current_agent
```

---

## 🔗 Integration with Slash Commands

### Update Slash Commands to Set Agent

Your `/role-*` commands should update the agent marker:

```bash
# In your slash command file (.claude/commands/role-backend.md)

Set current agent marker:
```bash
echo "Backend" > ~/.claude/.current_agent
```

Transform to Backend agent and begin work.
```

**Updated commands for all agents:**
- `/role-backend` → Sets "Backend"
- `/role-frontend` → Sets "Frontend"
- `/role-ceo` → Sets "CEO"
- `/role-integration` → Sets "Integration"
- `/role-testing` → Sets "Testing"
- `/role-devops` → Sets "DevOps"
- `/role-qa-automation` → Sets "QA Automation"
- `/role-ux-product` → Sets "UX/Product"

---

## 📊 Future Enhancements

### Coming Soon

- **Context Usage Tracking**: Show % of 200k token window used
- **Budget Alerts**: Color-coded cost warnings
- **Performance Metrics**: Tokens per minute
- **Team Mode**: Show multiple active agents in parallel development
- **Integration with Monitoring**: Pull from Prometheus metrics

### How to Contribute

Have ideas for the status line?
1. Fork the repo
2. Modify `statusline.sh` or `statusline.py`
3. Test thoroughly
4. Submit PR with examples

---

## 📚 Resources

- [Official Status Line Docs](https://docs.claude.com/en/docs/claude-code/statusline)
- [Settings Configuration](https://docs.claude.com/en/docs/claude-code/settings)
- [Framework Documentation](../../README.md)

---

## ✅ Quick Checklist

- [ ] Copy statusline script to `~/.claude/`
- [ ] Make script executable (`chmod +x`)
- [ ] Install `jq` if using bash version
- [ ] Add statusLine to `~/.claude/settings.json`
- [ ] Test with mock JSON input
- [ ] Restart Claude Code
- [ ] Verify status line appears at bottom
- [ ] Customize to your preferences

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Requires**: Claude Code with statusline support
