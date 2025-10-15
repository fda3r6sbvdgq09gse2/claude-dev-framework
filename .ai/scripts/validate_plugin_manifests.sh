#!/bin/bash
# Validate plugin.json files against Claude Code schema
# Usage: ./validate_plugin_manifests.sh [marketplace_path]

set -euo pipefail

MARKETPLACE_PATH="${1:-$HOME/.claude/plugins/marketplaces/Claude-Dev-Framework}"

echo "=========================================="
echo "Plugin Manifest Validator"
echo "=========================================="
echo "Checking: $MARKETPLACE_PATH"
echo ""

errors=0
warnings=0

# Required fields
REQUIRED_FIELDS=("name" "version")

# Valid optional fields
VALID_FIELDS=("name" "version" "description" "author" "homepage" "repository" "license" "keywords" "commands" "agents" "hooks" "mcpServers")

# Invalid fields that should be removed
INVALID_FIELDS=("dependencies" "optionalDependencies" "configuration" "scripts" "files" "installHook" "healthCheck" "integrations" "requires" "_note")

check_manifest() {
    local manifest="$1"
    local plugin_name=$(basename $(dirname $(dirname "$manifest")))

    echo "Checking: $plugin_name"

    if [ ! -f "$manifest" ]; then
        echo "  ❌ ERROR: plugin.json not found"
        ((errors++))
        return
    fi

    # Check if valid JSON
    if ! jq empty "$manifest" 2>/dev/null; then
        echo "  ❌ ERROR: Invalid JSON syntax"
        ((errors++))
        return
    fi

    # Check required fields
    for field in "${REQUIRED_FIELDS[@]}"; do
        if ! jq -e ".$field" "$manifest" >/dev/null 2>&1; then
            echo "  ❌ ERROR: Missing required field: $field"
            ((errors++))
        fi
    done

    # Check author format (must be object, not string)
    if jq -e '.author' "$manifest" >/dev/null 2>&1; then
        author_type=$(jq -r '.author | type' "$manifest")
        if [ "$author_type" != "object" ]; then
            echo "  ❌ ERROR: author must be object {name: \"...\"}, got $author_type"
            ((errors++))
        fi
    fi

    # Check repository format (must be string, not object)
    if jq -e '.repository' "$manifest" >/dev/null 2>&1; then
        repo_type=$(jq -r '.repository | type' "$manifest")
        if [ "$repo_type" != "string" ]; then
            echo "  ❌ ERROR: repository must be string URL, got $repo_type"
            ((errors++))
        fi
    fi

    # Check agents format (must be string path or array of paths, not array of objects)
    if jq -e '.agents' "$manifest" >/dev/null 2>&1; then
        agents_type=$(jq -r '.agents | type' "$manifest")
        if [ "$agents_type" == "array" ]; then
            # Check if it's array of strings or array of objects
            first_elem_type=$(jq -r '.agents[0] | type' "$manifest" 2>/dev/null || echo "null")
            if [ "$first_elem_type" == "object" ]; then
                echo "  ❌ ERROR: agents must be path string, not array of config objects"
                echo "     Use: \"agents\": \"./agents/\" instead"
                ((errors++))
            fi
        fi
    fi

    # Check for invalid fields
    for field in "${INVALID_FIELDS[@]}"; do
        if jq -e ".$field" "$manifest" >/dev/null 2>&1; then
            echo "  ⚠️  WARNING: Invalid field '$field' should be removed"
            ((warnings++))
        fi
    done

    # Check for unexpected fields
    all_fields=$(jq -r 'keys[]' "$manifest")
    for field in $all_fields; do
        if [[ ! " ${VALID_FIELDS[@]} " =~ " ${field} " ]] && [[ ! " ${INVALID_FIELDS[@]} " =~ " ${field} " ]]; then
            echo "  ⚠️  WARNING: Unexpected field '$field'"
            ((warnings++))
        fi
    done

    if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
        echo "  ✅ Valid"
    fi

    echo ""
}

# Find all plugin.json files
while IFS= read -r -d '' manifest; do
    check_manifest "$manifest"
done < <(find "$MARKETPLACE_PATH/plugins" -name "plugin.json" -path "*/.claude-plugin/*" -print0 2>/dev/null)

echo "=========================================="
echo "Summary"
echo "=========================================="
echo "Errors: $errors"
echo "Warnings: $warnings"
echo ""

if [ $errors -gt 0 ]; then
    echo "❌ Validation failed with $errors error(s)"
    echo "See: ../QUICK_REFERENCE_fixing_plugin_manifests.md for fix instructions"
    exit 1
else
    echo "✅ All plugin manifests are valid!"
    if [ $warnings -gt 0 ]; then
        echo "⚠️  $warnings warning(s) found - consider cleaning up invalid fields"
    fi
    exit 0
fi
