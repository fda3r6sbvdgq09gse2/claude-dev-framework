#!/bin/bash
# Initialize project-specific marketplace for Claude Dev Framework
# Usage: ./scripts/init-project-marketplace.sh <project-name>
#
# This script:
# 1. Creates .claude-plugin directory
# 2. Copies project-marketplace template
# 3. Customizes marketplace name
# 4. Updates .claude/settings.json if it exists
# 5. Creates directories for project-specific agents

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$FRAMEWORK_DIR/config/templates"

# Check if project name provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Project name required${NC}"
    echo "Usage: $0 <project-name>"
    echo ""
    echo "Example:"
    echo "  cd ~/my-project"
    echo "  $0 my-project"
    exit 1
fi

PROJECT_NAME="$1"
MARKETPLACE_NAME="${PROJECT_NAME}-Marketplace"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Claude Dev Framework - Project Marketplace Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Project Name: $PROJECT_NAME"
echo "Marketplace Name: $MARKETPLACE_NAME"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${YELLOW}Warning: Not in a git repository${NC}"
    echo "Consider running 'git init' first"
    echo ""
fi

# 1. Create .claude-plugin directory
echo -e "${GREEN}1. Creating .claude-plugin directory...${NC}"
mkdir -p .claude-plugin
mkdir -p .claude/agents

# 2. Copy template if it doesn't exist
echo -e "${GREEN}2. Setting up project marketplace...${NC}"
if [ -f ".claude-plugin/project-marketplace.json" ]; then
    echo -e "${YELLOW}   ⚠ project-marketplace.json already exists, skipping${NC}"
else
    if [ ! -f "$TEMPLATE_DIR/project-marketplace.json" ]; then
        echo -e "${RED}Error: Template not found at $TEMPLATE_DIR/project-marketplace.json${NC}"
        exit 1
    fi

    cp "$TEMPLATE_DIR/project-marketplace.json" .claude-plugin/project-marketplace.json

    # Customize marketplace name (cross-platform sed)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/YourProject-Marketplace/$MARKETPLACE_NAME/g" .claude-plugin/project-marketplace.json
        sed -i '' "s/yourproject/$PROJECT_NAME/g" .claude-plugin/project-marketplace.json
    else
        # Linux
        sed -i "s/YourProject-Marketplace/$MARKETPLACE_NAME/g" .claude-plugin/project-marketplace.json
        sed -i "s/yourproject/$PROJECT_NAME/g" .claude-plugin/project-marketplace.json
    fi

    echo -e "${GREEN}   ✓ Created .claude-plugin/project-marketplace.json${NC}"
fi

# 3. Update or create .claude/settings.json
echo -e "${GREEN}3. Configuring Claude settings...${NC}"
if [ ! -f ".claude/settings.json" ]; then
    echo -e "${YELLOW}   No .claude/settings.json found, creating from template${NC}"
    mkdir -p .claude

    if [ ! -f "$TEMPLATE_DIR/project-settings.json" ]; then
        echo -e "${RED}Error: Template not found at $TEMPLATE_DIR/project-settings.json${NC}"
        exit 1
    fi

    cp "$TEMPLATE_DIR/project-settings.json" .claude/settings.json

    # Customize project name (cross-platform sed)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/your-project-name/$PROJECT_NAME/g" .claude/settings.json
        sed -i '' "s/YourProject-Marketplace/$MARKETPLACE_NAME/g" .claude/settings.json
    else
        sed -i "s/your-project-name/$PROJECT_NAME/g" .claude/settings.json
        sed -i "s/YourProject-Marketplace/$MARKETPLACE_NAME/g" .claude/settings.json
    fi

    echo -e "${GREEN}   ✓ Created .claude/settings.json${NC}"
else
    echo -e "${YELLOW}   .claude/settings.json already exists${NC}"
    echo -e "${YELLOW}   Please manually add marketplace to extraKnownMarketplaces:${NC}"
    echo ""
    echo "    \"$MARKETPLACE_NAME\": {"
    echo "      \"source\": {"
    echo "        \"source\": \"file\","
    echo "        \"path\": \"./.claude-plugin/project-marketplace.json\""
    echo "      }"
    echo "    }"
    echo ""
fi

# 4. Update .gitignore
echo -e "${GREEN}4. Updating .gitignore...${NC}"
if [ -f ".gitignore" ]; then
    if ! grep -q ".claude/settings.local.json" .gitignore; then
        echo ".claude/settings.local.json" >> .gitignore
        echo -e "${GREEN}   ✓ Added .claude/settings.local.json to .gitignore${NC}"
    else
        echo -e "${YELLOW}   Already in .gitignore${NC}"
    fi
else
    echo ".claude/settings.local.json" > .gitignore
    echo -e "${GREEN}   ✓ Created .gitignore${NC}"
fi

# 5. Summary
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Project marketplace setup complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Created files:"
echo "  📄 .claude-plugin/project-marketplace.json"
echo "  📁 .claude/agents/ (for project-specific agents)"
if [ ! -f ".claude/settings.json" ]; then
    echo "  ⚙️  .claude/settings.json"
fi
echo ""
echo "Next steps:"
echo "  1. Review .claude/settings.json"
echo "  2. Edit .claude-plugin/project-marketplace.json"
echo "  3. Add project-specific agents to .claude/agents/"
echo "  4. Test with: claude"
echo ""
echo "Documentation:"
echo "  📚 $FRAMEWORK_DIR/docs/CONFIGURATION_ARCHITECTURE.md"
echo ""
echo "To add to git:"
echo "  git add .claude/ .claude-plugin/ .gitignore"
echo "  git commit -m \"Initialize Claude framework configuration\""
echo ""
