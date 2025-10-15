#!/bin/bash
# Agent Tracking Hook
# Type: UserPromptSubmit
# Purpose: Track which agent is being used and update statusline

input=$(cat)
message=$(echo "$input" | jq -r '.message // ""')

# Create logs directory if needed
mkdir -p ~/.claude/logs

# Detect agent from slash command
if echo "$message" | grep -q "^/role-"; then
    # Extract agent name (e.g., /role-backend → Backend)
    agent=$(echo "$message" | sed 's/^\/role-//' | sed 's/.*/\u&/')  # Capitalize first letter

    # Save current agent for statusline
    echo "$agent" > ~/.claude/.current_agent

    # Log usage
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - Agent: $agent - Project: $(basename $(pwd))" >> ~/.claude/logs/agent-usage.log
fi

# Don't modify the message
echo "$input" | jq
exit 0
