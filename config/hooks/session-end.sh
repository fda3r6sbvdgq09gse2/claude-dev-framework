#!/bin/bash
# Session End Hook
# Type: SessionEnd
# Purpose: Save state and clean up

input=$(cat)
duration=$(echo "$input" | jq -r '.duration // 0')
cost=$(echo "$input" | jq -r '.cost.total // 0')

# Log session end
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
agent=$(cat ~/.claude/.current_agent 2>/dev/null || echo "General")
project=$(basename $(pwd))
echo "$timestamp - Session ended. Agent: $agent, Duration: ${duration}s, Cost: \$$cost, Project: $project" >> ~/.claude/logs/sessions.log

# Clear agent marker
rm -f ~/.claude/.current_agent
rm -f ~/.claude/.context_warning

# Archive large log files
if [ -f ~/.claude/logs/tool-usage.jsonl ]; then
    log_size=$(wc -c < ~/.claude/logs/tool-usage.jsonl)
    if [ "$log_size" -gt 1000000 ]; then  # > 1MB
        date_suffix=$(date +%Y%m%d-%H%M%S)
        gzip -c ~/.claude/logs/tool-usage.jsonl > ~/.claude/logs/tool-usage-$date_suffix.jsonl.gz
        > ~/.claude/logs/tool-usage.jsonl  # Truncate
    fi
fi

exit 0
