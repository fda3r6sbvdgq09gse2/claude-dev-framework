#!/bin/bash
# Marketplace.json validation and auto-sync script
# This script validates the marketplace schema and automatically pushes valid changes

set -e

MARKETPLACE_FILE=".claude-plugin/marketplace.json"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$REPO_DIR"

echo "🔍 Validating marketplace.json schema..."

# Check if file exists
if [ ! -f "$MARKETPLACE_FILE" ]; then
    echo "❌ Error: $MARKETPLACE_FILE not found"
    exit 1
fi

# Validate JSON syntax
if ! jq empty "$MARKETPLACE_FILE" 2>/dev/null; then
    echo "❌ Error: Invalid JSON syntax in $MARKETPLACE_FILE"
    exit 1
fi

# Validate required fields
echo "  Checking required fields..."
REQUIRED_FIELDS=("name" "version" "owner" "plugins")
for field in "${REQUIRED_FIELDS[@]}"; do
    if ! jq -e ".$field" "$MARKETPLACE_FILE" > /dev/null 2>&1; then
        echo "❌ Error: Missing required field: $field"
        exit 1
    fi
done

# Check for invalid 'requires' fields in plugins
echo "  Checking for invalid 'requires' fields..."
if jq -e '.plugins[] | select(.requires != null)' "$MARKETPLACE_FILE" > /dev/null 2>&1; then
    echo "❌ Error: Found 'requires' fields in plugins (not supported by Claude Code schema)"
    echo "  Plugins with 'requires' field:"
    jq -r '.plugins[] | select(.requires != null) | "  - \(.name)"' "$MARKETPLACE_FILE"
    exit 1
fi

# Validate command paths (must start with ./ and end with .md)
echo "  Checking command paths..."
INVALID_COMMANDS=$(jq -r '.plugins[] | select(.commands != null) | .commands[] | select(startswith("./") | not or endswith(".md") | not)' "$MARKETPLACE_FILE" 2>/dev/null || true)
if [ -n "$INVALID_COMMANDS" ]; then
    echo "❌ Error: Invalid command paths found (must start with './' and end with '.md'):"
    echo "$INVALID_COMMANDS" | sed 's/^/  - /'
    exit 1
fi

# Validate agent paths (must start with ./ and end with .md)
echo "  Checking agent paths..."
INVALID_AGENTS=$(jq -r '.plugins[] | select(.agents != null) | .agents[] | select(startswith("./") | not or endswith(".md") | not)' "$MARKETPLACE_FILE" 2>/dev/null || true)
if [ -n "$INVALID_AGENTS" ]; then
    echo "❌ Error: Invalid agent paths found (must start with './' and end with '.md'):"
    echo "$INVALID_AGENTS" | sed 's/^/  - /'
    exit 1
fi

echo "✅ Marketplace.json validation passed!"

# Check if running in Claude Code context (has git changes)
if [ -n "$(git status --porcelain "$MARKETPLACE_FILE" 2>/dev/null)" ]; then
    echo ""
    echo "📝 Detected changes to marketplace.json"

    # Check if CLAUDE_CODE_AUTO_PUSH is enabled
    if [ "${CLAUDE_CODE_AUTO_PUSH}" = "true" ]; then
        echo "🚀 Auto-push enabled, committing and pushing changes..."

        git add "$MARKETPLACE_FILE"
        git commit -m "chore: Update marketplace.json

✅ Schema validation passed
🤖 Auto-committed by validate-marketplace.sh"

        git push
        echo "✅ Changes pushed to GitHub successfully!"
    else
        echo "ℹ️  Auto-push disabled. Set CLAUDE_CODE_AUTO_PUSH=true to enable automatic commits."
        echo "   To commit manually:"
        echo "   git add $MARKETPLACE_FILE"
        echo "   git commit -m 'chore: Update marketplace.json'"
        echo "   git push"
    fi
fi

echo ""
echo "🎉 Marketplace validation complete!"
