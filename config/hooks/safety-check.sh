#!/bin/bash
# Safety Check Hook
# Type: PreToolUse
# Purpose: Block dangerous operations before execution

input=$(cat)
tool=$(echo "$input" | jq -r '.tool')
args=$(echo "$input" | jq -r '.arguments // {} | tostring')

# Block dangerous Bash commands
if [ "$tool" = "Bash" ]; then
    # Extremely dangerous commands
    if echo "$args" | grep -qE 'rm -rf /|rm -rf ~|dd if=|:(){ :|:& };:|mkfs\.|format '; then
        echo '{"decision": "block", "explanation": "⛔ Extremely dangerous command blocked for safety"}' | jq
        exit 2
    fi

    # Potentially dangerous commands (require confirmation)
    if echo "$args" | grep -qE 'sudo |rm -rf|git push --force|git reset --hard|docker system prune'; then
        echo '{"decision": "block", "explanation": "⚠️  Potentially dangerous command. Please confirm with user first."}' | jq
        exit 2
    fi
fi

# Block writing to sensitive files
if [ "$tool" = "Write" ] || [ "$tool" = "Edit" ]; then
    file_path=$(echo "$input" | jq -r '.arguments.file_path // ""')

    # Sensitive file patterns
    if echo "$file_path" | grep -qE '\.env$|\.aws/|\.ssh/|credentials|\.key$|\.pem$|secrets'; then
        echo '{"decision": "block", "explanation": "🔒 Cannot modify sensitive files"}' | jq
        exit 2
    fi
fi

# Allow operation
echo '{"decision": "continue"}' | jq
exit 0
