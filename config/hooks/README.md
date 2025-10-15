# Framework Hooks
*Ready-to-use hooks for claude-multi-agent-framework*

## 🎯 Available Hooks

### 1. `safety-check.sh`
**Type**: PreToolUse
**Purpose**: Block dangerous operations

**Blocks**:
- ⛔ Extremely dangerous: `rm -rf /`, `dd if=`, format commands
- ⚠️  Potentially dangerous: `sudo`, `git push --force`, `docker system prune`
- 🔒 Sensitive files: `.env`, `.ssh`, `.aws`, credentials

**Usage**: Prevents accidental destructive operations

---

### 2. `track-agent.sh`
**Type**: UserPromptSubmit
**Purpose**: Track agent usage

**Features**:
- Detects `/role-*` commands
- Saves current agent to `~/.claude/.current_agent` (for statusline)
- Logs agent usage to `~/.claude/logs/agent-usage.log`

**Usage**: Know which agents you use most

---

### 3. `session-start.sh`
**Type**: SessionStart
**Purpose**: Initialize session

**Features**:
- Creates log directories
- Clears old agent marker
- Checks for `jq` installation
- Tips for monitoring stack

**Usage**: Automatic session setup

---

### 4. `session-end.sh`
**Type**: SessionEnd
**Purpose**: Clean up and save state

**Features**:
- Logs session duration and cost
- Archives large log files
- Clears agent marker

**Usage**: Automatic cleanup

---

### 5. `cost-alert.sh`
**Type**: Stop
**Purpose**: Alert on high costs

**Features**:
- Alerts if session > $1
- Tracks daily total (alerts > $10)
- Tracks monthly total (alerts > $200)
- Stores in `~/.claude/logs/costs/`

**Usage**: Budget management

---

## 🚀 Installation

### Quick Setup (All Hooks)

```bash
# 1. Copy hooks to your home directory
cp -r config/hooks ~/.claude/hooks

# 2. Make executable
chmod +x ~/.claude/hooks/*.sh

# 3. Add to your settings.json
# See: config/templates/user-settings-with-hooks.json
```

### Manual Setup (Individual Hooks)

```bash
# Copy specific hook
cp config/hooks/safety-check.sh ~/.claude/hooks/

# Make executable
chmod +x ~/.claude/hooks/safety-check.sh

# Add to ~/.claude/settings.json
```

---

## ⚙️ Configuration

### Complete Hook Configuration

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/session-start.sh",
            "timeout": 30
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/session-end.sh",
            "timeout": 30
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/track-agent.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/safety-check.sh",
            "timeout": 10
          }
        ]
      },
      {
        "matcher": "Write(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/safety-check.sh",
            "timeout": 10
          }
        ]
      },
      {
        "matcher": "Edit(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/safety-check.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/cost-alert.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

---

## 🧪 Testing Hooks

### Test Safety Hook

```bash
# Create test input
cat > /tmp/test-bash.json << 'EOF'
{
  "tool": "Bash",
  "arguments": {
    "command": "rm -rf /tmp/test"
  }
}
EOF

# Run hook
cat /tmp/test-bash.json | ~/.claude/hooks/safety-check.sh

# Should output: {"decision": "block", ...}
echo "Exit code: $?"  # Should be 2 (blocked)
```

### Test Agent Tracking

```bash
# Create test input
cat > /tmp/test-prompt.json << 'EOF'
{
  "message": "/role-backend"
}
EOF

# Run hook
cat /tmp/test-prompt.json | ~/.claude/hooks/track-agent.sh

# Check result
cat ~/.claude/.current_agent  # Should show "Backend"
tail ~/.claude/logs/agent-usage.log  # Should show log entry
```

---

## 📊 Viewing Hook Data

### Agent Usage

```bash
# View agent usage log
cat ~/.claude/logs/agent-usage.log

# Count agent usage
grep -o 'Agent: [^-]*' ~/.claude/logs/agent-usage.log | sort | uniq -c

# Example output:
#   12 Agent: Backend
#    8 Agent: Frontend
#    5 Agent: CEO
#    3 Agent: Testing
```

### Session History

```bash
# View session log
cat ~/.claude/logs/sessions.log

# Recent sessions
tail -10 ~/.claude/logs/sessions.log
```

### Cost Tracking

```bash
# Today's cost
cat ~/.claude/logs/costs/$(date +%Y-%m-%d).txt | awk '{sum+=$1} END {print "$" sum}'

# This month's cost
cat ~/.claude/logs/costs/$(date +%Y-%m)-*.txt | awk '{sum+=$1} END {print "$" sum}'
```

---

## 🎨 Customization

### Modify Safety Rules

Edit `~/.claude/hooks/safety-check.sh`:

```bash
# Add your own dangerous patterns
if echo "$args" | grep -qE 'your-pattern|another-pattern'; then
    echo '{"decision": "block", "explanation": "Your reason"}' | jq
    exit 2
fi

# Modify sensitive file patterns
if echo "$file_path" | grep -qE 'your-pattern'; then
    # ...
fi
```

### Adjust Cost Alerts

Edit `~/.claude/hooks/cost-alert.sh`:

```bash
# Change thresholds
if (( $(echo "$cost > 0.50" | bc -l) )); then  # Alert at $0.50 instead of $1
    echo "💰 Cost: \$$cost" >&2
fi

if (( $(echo "$daily_total > 5.0" | bc -l) )); then  # Daily limit $5
    echo "⚠️  Daily: \$$daily_total" >&2
fi
```

---

## 🐛 Troubleshooting

### Hook Not Running

```bash
# Check if file exists
ls -la ~/.claude/hooks/safety-check.sh

# Check if executable
# Should show: -rwxr-xr-x
# If not: chmod +x ~/.claude/hooks/safety-check.sh

# Check settings.json
cat ~/.claude/settings.json | jq '.hooks'
```

### JSON Errors

```bash
# Install jq
brew install jq  # macOS
sudo apt install jq  # Linux

# Verify jq works
echo '{"test": "value"}' | jq
```

### Logs Not Created

```bash
# Check directory permissions
ls -la ~/.claude/

# Create logs directory if missing
mkdir -p ~/.claude/logs
```

---

## 📚 Resources

- [Hooks Guide](../../docs/HOOKS_GUIDE.md) - Comprehensive documentation
- [Official Hooks Docs](https://docs.claude.com/en/docs/claude-code/hooks)
- [Settings Configuration](https://docs.claude.com/en/docs/claude-code/settings)

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Requires**: `jq` for JSON parsing, `bc` for cost calculations
