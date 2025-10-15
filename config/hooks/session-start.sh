#!/bin/bash
# Session Start Hook
# Type: SessionStart
# Purpose: Initialize framework context and check environment

# Create necessary directories
mkdir -p ~/.claude/logs
mkdir -p ~/.claude/.cache

# Clear old agent marker
rm -f ~/.claude/.current_agent

# Log session start
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
project=$(basename $(pwd))
echo "$timestamp - Session started in: $project" >> ~/.claude/logs/sessions.log

# Check if jq is installed (needed for hooks)
if ! command -v jq &> /dev/null; then
    echo "⚠️  Warning: jq not installed. Install with: brew install jq" >&2
fi

# Check if monitoring stack is running (optional)
if [ -f "monitoring/setup/docker-compose.yml" ]; then
    if ! curl -s http://localhost:9090/-/healthy >/dev/null 2>&1; then
        echo "ℹ️  Tip: Start monitoring with: docker-compose -f monitoring/setup/docker-compose.yml up -d" >&2
    fi
fi

exit 0
