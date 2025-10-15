#!/bin/bash
# Save Context - Graceful shutdown with state preservation
# Called by shutdown hook or manually for session end

set -e

CONTEXT_DIR=".ai/context"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SESSION_FILE="$CONTEXT_DIR/session_$TIMESTAMP.md"

mkdir -p "$CONTEXT_DIR"

echo "💾 Saving session context..."
echo ""

# Create session snapshot
cat > "$SESSION_FILE" <<EOF
# Session Context Snapshot
**Saved**: $(date)
**Branch**: $(git branch --show-current 2>/dev/null || echo "unknown")
**Framework**: v2.0.0 (locked)

---

## Git Status

\`\`\`
$(git status 2>/dev/null || echo "Git not available")
\`\`\`

---

## Modified Files

\`\`\`
$(git status --short 2>/dev/null || echo "No changes")
\`\`\`

---

## Recent Commits (last 5)

\`\`\`
$(git log -5 --oneline 2>/dev/null || echo "No commits")
\`\`\`

---

## Project State

### Framework Version
- **Locked**: v2.0.0
- **Location**: ../claude-dev-framework
- **Status**: $(cd ../claude-dev-framework 2>/dev/null && git describe --tags 2>/dev/null || echo "unknown")

### Project Additions
$(cat .claude-plugin/project-marketplace.json 2>/dev/null | grep -A 5 metadata || echo "No project marketplace")

### Extraction Candidates
$(cat .ai/learnings/GENERIC_PATTERNS.md 2>/dev/null | grep -A 20 "## Discovered Patterns" || echo "No patterns yet")

---

## Next Steps

### Immediate Tasks
$(cat .ai/context/TODO.md 2>/dev/null | head -20 || echo "No TODOs")

### In Progress
$(git status --short | grep "^ M" | head -10 || echo "No files in progress")

---

## How to Resume

\`\`\`bash
# 1. Verify framework still locked
.ai/scripts/verify_framework_immutability.sh

# 2. Review this session file
cat .ai/context/session_${TIMESTAMP}.md

# 3. Check what was in progress
git status

# 4. Start Claude Code
claude

# 5. Say: "Review the session context and help me continue"
\`\`\`

---

## Cost & Usage (if available)

To check costs after resuming, use:
\`\`\`
/cost
/usage
\`\`\`

---

**Session End**: $(date)
EOF

# Create symlink to latest session
ln -sf "session_$TIMESTAMP.md" "$CONTEXT_DIR/latest_session.md"

# Save current TODO state
if [ -f ".ai/context/TODO.md" ]; then
    cp ".ai/context/TODO.md" "$CONTEXT_DIR/TODO_$TIMESTAMP.md"
fi

# Save project framework log
if [ -f ".ai/PROJECT_FRAMEWORK_LOG.md" ]; then
    cp ".ai/PROJECT_FRAMEWORK_LOG.md" "$CONTEXT_DIR/FRAMEWORK_LOG_$TIMESTAMP.md"
fi

echo "✅ Context saved to: $SESSION_FILE"
echo ""
echo "To resume:"
echo "  1. Run: .ai/scripts/resume_context.sh"
echo "  2. Or read: $SESSION_FILE"
echo ""
echo "Latest session always available at:"
echo "  .ai/context/latest_session.md"
echo ""

# Show summary
echo "Session Summary:"
echo "  Modified files: $(git status --short 2>/dev/null | wc -l | tr -d ' ')"
echo "  Branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"
echo "  Framework: v2.0.0 (locked)"
echo ""
