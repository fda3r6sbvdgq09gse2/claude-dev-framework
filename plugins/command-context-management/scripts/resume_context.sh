#!/bin/bash
# Resume Context - Load last saved session state

set -e

CONTEXT_DIR=".ai/context"
LATEST_SESSION="$CONTEXT_DIR/latest_session.md"

echo "🔄 Resuming from last session..."
echo ""

if [ ! -f "$LATEST_SESSION" ]; then
    echo "❌ No saved session found."
    echo ""
    echo "To save a session, run:"
    echo "  .ai/scripts/save_context.sh"
    echo ""
    exit 1
fi

# Show latest session
echo "════════════════════════════════════════════════════"
echo "📖 Last Session Context"
echo "════════════════════════════════════════════════════"
echo ""
cat "$LATEST_SESSION"
echo ""
echo "════════════════════════════════════════════════════"
echo ""

# Verify framework still locked
echo "🔍 Verifying framework status..."
if .ai/scripts/verify_framework_immutability.sh > /dev/null 2>&1; then
    echo "✅ Framework still locked at v2.0.0"
else
    echo "⚠️  Framework verification issues - run full check:"
    echo "   .ai/scripts/verify_framework_immutability.sh"
fi
echo ""

# Check for uncommitted changes
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "✅ No uncommitted changes"
else
    echo "📝 You have uncommitted changes:"
    git status --short
fi
echo ""

# Show available commands
echo "💡 Useful Commands:"
echo "  /cost                    - Check API costs"
echo "  /usage                   - Check token usage"
echo "  /agents                  - List available agents"
echo "  /help                    - Show all commands"
echo ""

# Show resume instructions
echo "🚀 Ready to continue!"
echo ""
echo "Next steps:"
echo "  1. Review session context above"
echo "  2. Check git status for in-progress work"
echo "  3. Start Claude Code: claude"
echo "  4. Say: 'Review the session context and help me continue'"
echo ""
