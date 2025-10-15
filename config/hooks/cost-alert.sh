#!/bin/bash
# Cost Alert Hook
# Type: Stop
# Purpose: Alert if session cost exceeds thresholds

input=$(cat)
cost=$(echo "$input" | jq -r '.cost.total // 0')

# Check if bc is available
if ! command -v bc &> /dev/null; then
    exit 0  # Silently skip if bc not available
fi

# Alert if session cost > $1.00
if (( $(echo "$cost > 1.0" | bc -l) )); then
    echo "💰 High session cost: \$$cost" >&2
fi

# Track daily total
mkdir -p ~/.claude/logs/costs
date_key=$(date +%Y-%m-%d)
cost_file=~/.claude/logs/costs/$date_key.txt
echo "$cost" >> "$cost_file"

# Calculate daily total
daily_total=$(awk '{sum+=$1} END {print sum}' "$cost_file" 2>/dev/null || echo "0")

# Alert if daily total > $10
if (( $(echo "$daily_total > 10.0" | bc -l 2>/dev/null) )); then
    echo "⚠️  Daily cost alert: \$$daily_total (exceeded \$10 limit)" >&2
fi

# Calculate monthly total
month_key=$(date +%Y-%m)
monthly_total=0
for file in ~/.claude/logs/costs/$month_key-*.txt; do
    if [ -f "$file" ]; then
        file_total=$(awk '{sum+=$1} END {print sum}' "$file" 2>/dev/null || echo "0")
        monthly_total=$(echo "$monthly_total + $file_total" | bc -l)
    fi
done

# Alert if monthly total > $200
if (( $(echo "$monthly_total > 200.0" | bc -l 2>/dev/null) )); then
    echo "🚨 Monthly budget alert: \$$monthly_total (exceeded \$200 budget)" >&2
fi

exit 0
