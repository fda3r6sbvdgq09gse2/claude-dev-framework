# Hooks Guide
*Automated Workflows & Safety for Claude Multi-Agent Framework*
*Based on: [Official Hooks Documentation](https://docs.claude.com/en/docs/claude-code/hooks)*

---

## 🎯 What Are Hooks?

**Hooks** are shell scripts that run automatically at specific points during Claude Code execution. They enable:

- ✅ **Validation**: Block dangerous operations
- ✅ **Automation**: Run tasks automatically
- ✅ **Tracking**: Log agent activity
- ✅ **Safety**: Protect critical files
- ✅ **Integration**: Connect with external tools

---

## 🔔 Available Hook Types

| Hook Type | When It Runs | Use For |
|-----------|--------------|---------|
| **SessionStart** | New session begins | Setup, load context |
| **SessionEnd** | Session terminates | Cleanup, save state |
| **UserPromptSubmit** | User submits message | Add context, track agent |
| **PreToolUse** | Before tool executes | Validate, block dangerous ops |
| **PostToolUse** | After tool succeeds | Log, update tracking |
| **Stop** | Agent finishes responding | Process complete response |
| **SubagentStop** | Subagent completes | Track agent performance |
| **PreCompact** | Before context compaction | Save important context |
| **Notification** | System notification | Handle alerts |

---

## ⚙️ Hook Configuration

### Location

Hooks are configured in `settings.json`:

```json
{
  "hooks": {
    "HookType": [
      {
        "matcher": "ToolPattern",  // Optional: filter by tool
        "hooks": [
          {
            "type": "command",
            "command": "path/to/script.sh",
            "timeout": 60  // Optional: seconds (default 60)
          }
        ]
      }
    ]
  }
}
```

### Hook Levels

- **User** (`~/.claude/settings.json`): Personal hooks for all projects
- **Project** (`.claude/settings.json`): Team hooks for this project
- **Plugin** (plugin settings): Plugin-specific hooks

All hooks are merged and run in parallel.

---

## 🛡️ Safety Hooks

### 1. Block Dangerous Commands

**Hook**: `PreToolUse`
**Purpose**: Prevent destructive operations

**Example** (`~/.claude/hooks/safety-check.sh`):
```bash
#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool')
args=$(echo "$input" | jq -r '.arguments // {} | tostring')

# Block dangerous rm commands
if [ "$tool" = "Bash" ]; then
    if echo "$args" | grep -qE 'rm -rf /|rm -rf ~|dd if='; then
        echo '{"decision": "block", "explanation": "Dangerous command blocked for safety"}' | jq
        exit 2
    fi
fi

# Block writing to sensitive files
if [ "$tool" = "Write" ]; then
    if echo "$args" | grep -qE '\.env|\.ssh|\.aws|credentials'; then
        echo '{"decision": "block", "explanation": "Cannot write to sensitive files"}' | jq
        exit 2
    fi
fi

# Allow operation
echo '{"decision": "continue"}' | jq
exit 0
```

**Configuration** (`~/.claude/settings.json`):
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/safety-check.sh"
          }
        ]
      },
      {
        "matcher": "Write(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/safety-check.sh"
          }
        ]
      }
    ]
  }
}
```

---

### 2. Protect Critical Files

**Hook**: `PreToolUse`
**Purpose**: Block modifications to framework files

**Example** (`~/.claude/hooks/protect-framework.sh`):
```bash
#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool')
args=$(echo "$input" | jq -r '.arguments // {} | tostring')

# Protected patterns
PROTECTED_PATTERNS=(
    "\.ai/.*\.md$"
    "\.claude/agents/.*\.md$"
    "config/VARIABLES\.yaml$"
    "config/STAKEHOLDERS\.yaml$"
)

# Check if trying to modify protected files
if [ "$tool" = "Write" ] || [ "$tool" = "Edit" ]; then
    file_path=$(echo "$input" | jq -r '.arguments.file_path // ""')

    for pattern in "${PROTECTED_PATTERNS[@]}"; do
        if echo "$file_path" | grep -qE "$pattern"; then
            echo '{"decision": "block", "explanation": "Protected framework file. Ask user permission first."}' | jq
            exit 2
        fi
    done
fi

echo '{"decision": "continue"}' | jq
exit 0
```

---

## 📊 Tracking Hooks

### 3. Track Agent Usage

**Hook**: `UserPromptSubmit`
**Purpose**: Log which agent is being used

**Example** (`~/.claude/hooks/track-agent.sh`):
```bash
#!/bin/bash
input=$(cat)
message=$(echo "$input" | jq -r '.message // ""')

# Detect agent from slash command
if echo "$message" | grep -q "^/role-"; then
    agent=$(echo "$message" | sed 's/^\/role-//')

    # Save current agent
    echo "$agent" > ~/.claude/.current_agent

    # Log usage
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Agent: $agent" >> ~/.claude/logs/agent-usage.log
fi

# Don't modify message
echo "$input" | jq
exit 0
```

**Configuration**:
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/track-agent.sh"
          }
        ]
      }
    ]
  }
}
```

---

### 4. Log Tool Usage

**Hook**: `PostToolUse`
**Purpose**: Track what tools agents use

**Example** (`~/.claude/hooks/log-tools.sh`):
```bash
#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool')
success=$(echo "$input" | jq -r '.success')
agent=$(cat ~/.claude/.current_agent 2>/dev/null || echo "General")

# Log to file
log_entry="{\"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\", \"agent\": \"$agent\", \"tool\": \"$tool\", \"success\": $success}"
echo "$log_entry" >> ~/.claude/logs/tool-usage.jsonl

# Send to monitoring (if configured)
if [ -n "$OTEL_EXPORTER_OTLP_ENDPOINT" ]; then
    # Could send to OpenTelemetry here
    :
fi

exit 0
```

---

## 🚀 Automation Hooks

### 5. Auto-Format on Edit

**Hook**: `PostToolUse`
**Purpose**: Automatically format code after edits

**Example** (`~/.claude/hooks/auto-format.sh`):
```bash
#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool')
success=$(echo "$input" | jq -r '.success')

if [ "$tool" = "Edit" ] && [ "$success" = "true" ]; then
    file_path=$(echo "$input" | jq -r '.arguments.file_path // ""')

    # Python files: Black formatting
    if [[ "$file_path" == *.py ]]; then
        black "$file_path" 2>/dev/null
    fi

    # JavaScript/TypeScript: Prettier
    if [[ "$file_path" == *.js ]] || [[ "$file_path" == *.ts ]] || [[ "$file_path" == *.tsx ]]; then
        prettier --write "$file_path" 2>/dev/null
    fi
fi

exit 0
```

---

### 6. Session Setup

**Hook**: `SessionStart`
**Purpose**: Initialize framework context

**Example** (`~/.claude/hooks/session-start.sh`):
```bash
#!/bin/bash

# Create log directory
mkdir -p ~/.claude/logs

# Clear old agent marker
rm -f ~/.claude/.current_agent

# Log session start
echo "$(date '+%Y-%m-%d %H:%M:%S') - Session started in $(pwd)" >> ~/.claude/logs/sessions.log

# Check if monitoring is running
if ! curl -s http://localhost:9090/-/healthy >/dev/null 2>&1; then
    echo "⚠️  Warning: Monitoring stack not running" >&2
    echo "Run: docker-compose -f monitoring/setup/docker-compose.yml up -d" >&2
fi

exit 0
```

**Configuration**:
```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/session-start.sh"
          }
        ]
      }
    ]
  }
}
```

---

### 7. Session Cleanup

**Hook**: `SessionEnd`
**Purpose**: Save state and clean up

**Example** (`~/.claude/hooks/session-end.sh`):
```bash
#!/bin/bash
input=$(cat)
duration=$(echo "$input" | jq -r '.duration // 0')
cost=$(echo "$input" | jq -r '.cost.total // 0')

# Log session end
agent=$(cat ~/.claude/.current_agent 2>/dev/null || echo "General")
echo "$(date '+%Y-%m-%d %H:%M:%S') - Session ended. Agent: $agent, Duration: ${duration}s, Cost: \$$cost" >> ~/.claude/logs/sessions.log

# Clear agent marker
rm -f ~/.claude/.current_agent

# Archive logs if too large
log_size=$(wc -c < ~/.claude/logs/tool-usage.jsonl 2>/dev/null || echo 0)
if [ "$log_size" -gt 1000000 ]; then  # > 1MB
    gzip ~/.claude/logs/tool-usage.jsonl
    mv ~/.claude/logs/tool-usage.jsonl.gz ~/.claude/logs/tool-usage-$(date +%Y%m%d).jsonl.gz
    touch ~/.claude/logs/tool-usage.jsonl
fi

exit 0
```

---

## 💡 Advanced Hooks

### 8. Context Warning

**Hook**: `PreCompact`
**Purpose**: Save important context before compaction

**Example** (`~/.claude/hooks/pre-compact.sh`):
```bash
#!/bin/bash
input=$(cat)

# Create marker file
touch ~/.claude/.context_warning

# Notify user
echo "⚠️  Context is being compacted. Consider starting a fresh session." >&2

# Could save current context summary here
echo "$input" | jq '.context_summary // {}' > ~/.claude/logs/last-compact-context.json

exit 0
```

---

### 9. Cost Alerts

**Hook**: `Stop`
**Purpose**: Alert if session cost is high

**Example** (`~/.claude/hooks/cost-alert.sh`):
```bash
#!/bin/bash
input=$(cat)
cost=$(echo "$input" | jq -r '.cost.total // 0')

# Alert if cost > $1.00 for this session
if (( $(echo "$cost > 1.0" | bc -l) )); then
    echo "💰 High cost alert: \$$cost for this session" >&2
fi

# Track daily total
date_key=$(date +%Y-%m-%d)
echo "$cost" >> ~/.claude/logs/costs-$date_key.txt

# Calculate daily total
daily_total=$(awk '{sum+=$1} END {print sum}' ~/.claude/logs/costs-$date_key.txt)
if (( $(echo "$daily_total > 10.0" | bc -l) )); then
    echo "⚠️  Daily cost: \$$daily_total (exceeded \$10)" >&2
fi

exit 0
```

---

## 📋 Framework Hook Setup

### Complete Hook Configuration

**File**: `~/.claude/settings.json`

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
            "command": "~/.claude/hooks/protect-framework.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/log-tools.sh",
            "timeout": 10
          }
        ]
      },
      {
        "matcher": "Edit(*)",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/auto-format.sh",
            "timeout": 30
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

## 🔧 Hook Script Template

```bash
#!/bin/bash
# Hook Name: [Name]
# Hook Type: [PreToolUse/PostToolUse/etc]
# Purpose: [What it does]

# Read JSON input from stdin
input=$(cat)

# Extract needed fields
# field=$(echo "$input" | jq -r '.field')

# Your logic here
#  ...

# Return decision (for PreToolUse hooks)
# echo '{"decision": "continue"}' | jq
# OR
# echo '{"decision": "block", "explanation": "Reason"}' | jq

# For other hooks, just exit
exit 0
```

---

## 🐛 Debugging Hooks

### Test Hook Manually

```bash
# Create test input
cat > test-input.json << 'EOF'
{
  "tool": "Bash",
  "arguments": {
    "command": "rm -rf /tmp/test"
  }
}
EOF

# Run hook
cat test-input.json | ~/.claude/hooks/safety-check.sh

# Check exit code
echo $?  # 0 = continue, 2 = block
```

### Enable Hook Logging

```bash
# In your hook script, add:
echo "Hook input: $input" >> ~/.claude/logs/hook-debug.log
echo "Hook output: ..." >> ~/.claude/logs/hook-debug.log
```

### Common Issues

1. **Hook not running**: Check executable permission (`chmod +x`)
2. **Hook timing out**: Increase timeout or optimize script
3. **JSON parsing errors**: Validate JSON syntax
4. **Path issues**: Use absolute paths

---

## ✅ Best Practices

### DO

- ✅ Use absolute paths in hooks
- ✅ Quote shell variables properly
- ✅ Handle missing input fields gracefully
- ✅ Set appropriate timeouts
- ✅ Log to files, not stdout (except decisions)
- ✅ Test hooks manually before deploying

### DON'T

- ❌ Run expensive operations in hooks
- ❌ Access network without timeout
- ❌ Block operations unnecessarily
- ❌ Leave sensitive data in logs
- ❌ Forget to handle errors

---

## 📚 Resources

**Official Documentation**:
- [Hooks Guide](https://docs.claude.com/en/docs/claude-code/hooks)
- [Settings Configuration](https://docs.claude.com/en/docs/claude-code/settings)

**Framework Documentation**:
- [Configuration Architecture](./CONFIGURATION_ARCHITECTURE.md)
- [Context Optimization](./CONTEXT_OPTIMIZATION.md)

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Based On**: Official Claude Code Hooks Documentation
