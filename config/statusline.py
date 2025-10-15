#!/usr/bin/env python3
"""
Claude Multi-Agent Framework Status Line (Python version)
Shows: Agent | Model | Project | Cost | Stats

More feature-rich than bash version with context tracking.
"""

import json
import sys
import os
from pathlib import Path

def get_current_agent():
    """Get current agent from marker file or environment."""
    agent_file = Path.home() / ".claude" / ".current_agent"
    if agent_file.exists():
        return agent_file.read_text().strip()
    return os.getenv("CLAUDE_CURRENT_AGENT", "General")

def format_model_display(model_name):
    """Format model with appropriate icon and styling."""
    model_lower = model_name.lower()
    if "opus" in model_lower:
        return "👑 " + model_name, "opus"
    elif "sonnet" in model_lower:
        return "⚡ " + model_name, "sonnet"
    elif "haiku" in model_lower:
        return "🍃 " + model_name, "haiku"
    else:
        return "🤖 " + model_name, "unknown"

def format_cost(cost):
    """Format cost display."""
    if cost and float(cost) > 0:
        return f"💰${float(cost):.2f}"
    return None

def format_code_stats(lines_added, lines_removed):
    """Format code change statistics."""
    if lines_added or lines_removed:
        added = int(lines_added or 0)
        removed = int(lines_removed or 0)
        return f"📝 +{added}/-{removed}"
    return None

def format_duration(duration):
    """Format session duration."""
    if duration and int(duration) > 0:
        minutes = int(duration) // 60
        if minutes > 0:
            return f"⏱️  {minutes}m"
    return None

def get_context_usage():
    """
    Estimate context usage (if available).
    This is a placeholder - actual implementation would need
    to track token usage throughout the session.
    """
    # TODO: Integrate with actual context tracking
    return None

def main():
    try:
        # Read JSON input from stdin
        data = json.load(sys.stdin)

        # Extract key information
        model_name = data.get("model", {}).get("display_name", "Unknown")
        current_dir = data.get("workspace", {}).get("current_dir", "~")
        project = os.path.basename(current_dir)

        cost_data = data.get("cost", {})
        cost = cost_data.get("total", 0)
        lines_added = cost_data.get("lines_added", 0)
        lines_removed = cost_data.get("lines_removed", 0)
        duration = cost_data.get("duration", 0)

        # Get current agent
        agent = get_current_agent()

        # Build status line components
        components = []

        # Agent
        components.append(f"🤖 {agent}")

        # Model
        model_display, model_type = format_model_display(model_name)
        components.append(model_display)

        # Project
        components.append(f"📁 {project}")

        # Cost (if any)
        cost_display = format_cost(cost)
        if cost_display:
            components.append(cost_display)

        # Code stats (if any)
        code_stats = format_code_stats(lines_added, lines_removed)
        if code_stats:
            components.append(code_stats)

        # Duration (if any)
        time_display = format_duration(duration)
        if time_display:
            components.append(time_display)

        # Context usage (if available)
        context_usage = get_context_usage()
        if context_usage:
            components.append(f"📊 {context_usage}%")

        # Join and output
        status_line = " | ".join(components)
        print(status_line)

    except Exception as e:
        # Fallback: show minimal info
        print(f"🤖 Claude | ⚠️  Status error: {str(e)}")
        sys.exit(0)  # Don't crash Claude

if __name__ == "__main__":
    main()
