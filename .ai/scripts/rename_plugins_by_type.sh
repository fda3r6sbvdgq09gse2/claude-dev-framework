#!/usr/bin/env bash
# Rename plugins to follow type-first naming convention
# Format: {type}-{name} where type = agent|command|utility

set -euo pipefail

MARKETPLACE_PATH="${1:-$HOME/.claude/plugins/marketplaces/Claude-Dev-Framework}"
PLUGINS_DIR="$MARKETPLACE_PATH/plugins"
MARKETPLACE_JSON="$MARKETPLACE_PATH/.claude-plugin/marketplace.json"

# Rename mapping: OLD_NAME NEW_NAME
RENAME_MAP=(
    "backend-agent:agent-backend"
    "ceo-agent:agent-ceo"
    "devops-agent:agent-devops"
    "documentation-agent:agent-documentation"
    "frontend-agent:agent-frontend"
    "integration-agent:agent-integration"
    "qa-automation-agent:agent-qa-automation"
    "testing-agent:agent-testing"
    "ux-product-agent:agent-ux-product"
    "context-management-plugin:command-context-management"
    "reward-system:utility-reward-system"
)

echo "=========================================="
echo "Plugin Renaming Script"
echo "=========================================="
echo "Marketplace: $MARKETPLACE_PATH"
echo ""

# Step 1: Rename directories
echo "Step 1: Renaming plugin directories..."
for mapping in "${RENAME_MAP[@]}"; do
    old_name="${mapping%%:*}"
    new_name="${mapping##*:}"
    old_path="$PLUGINS_DIR/$old_name"
    new_path="$PLUGINS_DIR/$new_name"

    if [ -d "$old_path" ]; then
        echo "  $old_name → $new_name"
        mv "$old_path" "$new_path"
    else
        echo "  ⚠️  Warning: $old_path not found, skipping"
    fi
done
echo ""

# Step 2: Update plugin.json name fields
echo "Step 2: Updating plugin.json name fields..."
for mapping in "${RENAME_MAP[@]}"; do
    old_name="${mapping%%:*}"
    new_name="${mapping##*:}"
    plugin_json="$PLUGINS_DIR/$new_name/.claude-plugin/plugin.json"

    if [ -f "$plugin_json" ]; then
        echo "  Updating $new_name/plugin.json"
        # Use jq to update the name field
        tmp_file=$(mktemp)
        jq --arg name "$new_name" '.name = $name' "$plugin_json" > "$tmp_file"
        mv "$tmp_file" "$plugin_json"
    fi
done
echo ""

# Step 3: Will be done by sync_marketplace_from_variables.py
echo "Step 3: Skipping marketplace.json update..."
echo "  ℹ️  Run sync_marketplace_from_variables.py to update marketplace.json from VARIABLES.yaml"
echo ""

# Step 4: Summary
echo "=========================================="
echo "Summary"
echo "=========================================="
echo "Renamed ${#RENAME_MAP[@]} plugins:"
echo ""
echo "AGENTS (9):"
echo "  • backend-agent → agent-backend"
echo "  • ceo-agent → agent-ceo"
echo "  • devops-agent → agent-devops"
echo "  • documentation-agent → agent-documentation"
echo "  • frontend-agent → agent-frontend"
echo "  • integration-agent → agent-integration"
echo "  • qa-automation-agent → agent-qa-automation"
echo "  • testing-agent → agent-testing"
echo "  • ux-product-agent → agent-ux-product"
echo ""
echo "COMMANDS (1):"
echo "  • context-management-plugin → command-context-management"
echo ""
echo "UTILITIES (1):"
echo "  • reward-system → utility-reward-system"
echo ""
echo "✅ Renaming complete!"
echo ""
echo "Next steps:"
echo "  1. Run: python3 $(dirname $0)/sync_marketplace_from_variables.py"
echo "  2. Restart Claude Code"
echo "  3. Run: /plugin list"
echo "  4. Run: /agents"
