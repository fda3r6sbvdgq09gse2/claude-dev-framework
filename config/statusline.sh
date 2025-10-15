#!/bin/bash
# Claude Multi-Agent Framework Status Line
# Shows: Agent | Model | Project | Cost | Stats

# Read JSON input from stdin
input=$(cat)

# Extract key information
MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // "~"')
PROJECT=$(basename "$CURRENT_DIR")
COST=$(echo "$input" | jq -r '.cost.total // 0')
LINES_ADDED=$(echo "$input" | jq -r '.cost.lines_added // 0')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.lines_removed // 0')
DURATION=$(echo "$input" | jq -r '.cost.duration // 0')

# Determine agent role from environment or transcript
AGENT="General"
if [ -f "$HOME/.claude/.current_agent" ]; then
    AGENT=$(cat "$HOME/.claude/.current_agent")
fi

# Format model display
case "$MODEL" in
    *"opus"*)
        MODEL_ICON="👑"
        MODEL_COLOR="\033[95m" # Magenta for Opus
        ;;
    *"sonnet"*)
        MODEL_ICON="⚡"
        MODEL_COLOR="\033[94m" # Blue for Sonnet
        ;;
    *"haiku"*)
        MODEL_ICON="🍃"
        MODEL_COLOR="\033[92m" # Green for Haiku
        ;;
    *)
        MODEL_ICON="🤖"
        MODEL_COLOR="\033[97m" # White default
        ;;
esac

# Format cost
if (( $(echo "$COST > 0" | bc -l 2>/dev/null || echo "0") )); then
    COST_DISPLAY=$(printf "💰\$%.2f" "$COST")
else
    COST_DISPLAY=""
fi

# Format code changes
if [ "$LINES_ADDED" -gt 0 ] || [ "$LINES_REMOVED" -gt 0 ]; then
    CODE_STATS="📝 +$LINES_ADDED/-$LINES_REMOVED"
else
    CODE_STATS=""
fi

# Format duration
if [ "$DURATION" -gt 0 ]; then
    MINUTES=$((DURATION / 60))
    if [ "$MINUTES" -gt 0 ]; then
        TIME_DISPLAY="⏱️  ${MINUTES}m"
    else
        TIME_DISPLAY=""
    fi
else
    TIME_DISPLAY=""
fi

# Build status line
STATUS_LINE=""

# Agent
STATUS_LINE="🤖 $AGENT"

# Model
STATUS_LINE="$STATUS_LINE | $MODEL_ICON $MODEL"

# Project
STATUS_LINE="$STATUS_LINE | 📁 $PROJECT"

# Cost (if any)
if [ -n "$COST_DISPLAY" ]; then
    STATUS_LINE="$STATUS_LINE | $COST_DISPLAY"
fi

# Code stats (if any)
if [ -n "$CODE_STATS" ]; then
    STATUS_LINE="$STATUS_LINE | $CODE_STATS"
fi

# Time (if any)
if [ -n "$TIME_DISPLAY" ]; then
    STATUS_LINE="$STATUS_LINE | $TIME_DISPLAY"
fi

# Output status line
echo "$STATUS_LINE"
