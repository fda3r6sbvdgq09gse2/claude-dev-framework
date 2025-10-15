#!/bin/bash
# Sprint Launch Automation Script
# Automates sprint setup, minimizing manual actions

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Sprint configuration
SPRINT_NUMBER=""
SPRINT_NAME=""
PROJECT_DIR=$(pwd)

# Functions
print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Parse arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <sprint_number> <sprint_name>"
    echo "Example: $0 7A \"Camera Scanner Polish\""
    exit 1
fi

SPRINT_NUMBER=$1
SPRINT_NAME=$2

print_header "🚀 Sprint $SPRINT_NUMBER Launch: $SPRINT_NAME"

# Step 1: Pre-flight checks
echo ""
echo -e "${BLUE}Step 1: Pre-flight Checks${NC}"
echo "────────────────────────────────────────────────────────────"

# Check git status
if [ -n "$(git status --porcelain)" ]; then
    print_warning "Uncommitted changes detected"
    read -p "Commit changes before starting sprint? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "Pre-sprint commit before Sprint $SPRINT_NUMBER"
        print_success "Changes committed"
    fi
fi

# Check if main branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    print_warning "Not on main branch (currently on: $current_branch)"
    read -p "Switch to main? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git checkout main
        print_success "Switched to main"
    fi
fi

print_success "Pre-flight checks complete"

# Step 2: Create sprint directory
echo ""
echo -e "${BLUE}Step 2: Create Sprint Directory${NC}"
echo "────────────────────────────────────────────────────────────"

SPRINT_DIR=".ai/sprints/sprint-$SPRINT_NUMBER"
mkdir -p "$SPRINT_DIR"
print_success "Created $SPRINT_DIR"

# Step 3: Create sprint documentation files
echo ""
echo -e "${BLUE}Step 3: Initialize Sprint Documentation${NC}"
echo "────────────────────────────────────────────────────────────"

# Create plan.md
cat > "$SPRINT_DIR/plan.md" << EOF
# Sprint $SPRINT_NUMBER: $SPRINT_NAME
*Created: $(date '+%Y-%m-%d %H:%M:%S')*

## Sprint Goal
[To be filled by CEO/Planning session]

## Features
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Agent Assignments
[To be determined during planning]

## Time Estimate
[To be determined during planning]
EOF

print_success "Created plan.md"

# Create execution-log.md
cat > "$SPRINT_DIR/execution-log.md" << EOF
# Sprint $SPRINT_NUMBER Execution Log

## Turn Tracking

### Turn 1 - [Agent Name]
**Time**: [timestamp]
**Task**: [task description]
**Status**: [in progress/completed/blocked]
**Context**: [X%]
EOF

print_success "Created execution-log.md"

# Create test results stub
cat > "$SPRINT_DIR/user-testing.md" << EOF
# Sprint $SPRINT_NUMBER User Testing

## Test Environment
- Date: [date]
- Branch: main (post-merge)
- Version: sprint-$SPRINT_NUMBER

## Features Tested
[To be filled during user testing]

## Bugs Found
[To be filled during user testing]

## Feedback
[To be filled by user]
EOF

print_success "Created user-testing.md"

# Step 4: Update current sprint marker
echo ""
echo -e "${BLUE}Step 4: Update Sprint Markers${NC}"
echo "────────────────────────────────────────────────────────────"

cat > ".ai/current_sprint.txt" << EOF
$SPRINT_NUMBER
EOF

cat > ".ai/current_sprint.md" << EOF
# Current Sprint: $SPRINT_NUMBER
*$SPRINT_NAME*

**Status**: Planning
**Started**: $(date '+%Y-%m-%d %H:%M:%S')

## Quick Links
- Plan: .ai/sprints/sprint-$SPRINT_NUMBER/plan.md
- Execution Log: .ai/sprints/sprint-$SPRINT_NUMBER/execution-log.md
- User Testing: .ai/sprints/sprint-$SPRINT_NUMBER/user-testing.md
EOF

print_success "Updated sprint markers"

# Step 5: Generate HMRP for planning
echo ""
echo -e "${BLUE}Step 5: Generate Planning HMRP${NC}"
echo "────────────────────────────────────────────────────────────"

cat > "$SPRINT_DIR/HMRP_planning.md" << 'EOF'
═══════════════════════════════════════════════════════════
📋 SPRINT_PLANNING: Sprint [NUMBER] - [NAME]
═══════════════════════════════════════════════════════════

## 🎯 PURPOSE
Plan and coordinate Sprint [NUMBER] with agent task assignments

## 👤 FOR
Creator

## 🤖 TARGET
CEO Agent

## ⏱️ ESTIMATED TIME
30-60 minutes

## 🚦 PRIORITY
🔴 CRITICAL - Required before sprint execution

───────────────────────────────────────────────────────────
## 📝 GLUE COMMAND
───────────────────────────────────────────────────────────

claude
/role-ceo

Read sprint context and previous feedback:
@.ai/sprints/sprint-[NUMBER]/plan.md
@.ai/current_task.md

[Then provide your sprint goals]

───────────────────────────────────────────────────────────
## 🎮 EXECUTION STEPS
───────────────────────────────────────────────────────────

### Step 1: Start CEO Agent
```bash
claude
/role-ceo
```

### Step 2: Provide Sprint Goals
Paste this template:
```
Plan Sprint [NUMBER]: [Name]

Goals:
1. [Goal 1]
2. [Goal 2]
3. [Goal 3]

Constraints:
- Time: [X hours]
- Priority: [features to focus on]

Success criteria:
- [Measurable outcome 1]
- [Measurable outcome 2]
```

### Step 3: Review CEO's Task Breakdown
CEO will provide:
- Agent assignments
- Time estimates
- Dependencies
- Deliverables

### Step 4: Approve or Modify
- ✅ Approve: "Launch sprint"
- ❌ Modify: "Change [specific aspect]"

───────────────────────────────────────────────────────────
## 📊 EXPECTED OUTPUT
───────────────────────────────────────────────────────────

CEO provides:
- Complete task breakdown
- Agent assignments with XP estimates
- Dependency map
- Launch instructions

───────────────────────────────────────────────────────────
## ✅ COMPLETION CRITERIA
───────────────────────────────────────────────────────────

Planning complete when:
- [ ] All tasks assigned to agents
- [ ] Dependencies identified
- [ ] Time estimates provided
- [ ] Human approves plan
- [ ] Ready to launch agents

═══════════════════════════════════════════════════════════
EOF

# Replace placeholders
sed -i '' "s/\[NUMBER\]/$SPRINT_NUMBER/g" "$SPRINT_DIR/HMRP_planning.md"
sed -i '' "s/\[NAME\]/$SPRINT_NAME/g" "$SPRINT_DIR/HMRP_planning.md"

print_success "Generated HMRP for planning"

# Step 6: Summary and next steps
echo ""
print_header "✅ Sprint $SPRINT_NUMBER Initialized"
echo ""
echo -e "${GREEN}Sprint directory created:${NC} $SPRINT_DIR"
echo -e "${GREEN}Current sprint marker:${NC} .ai/current_sprint.txt"
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}📋 NEXT STEPS${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "1️⃣  Review the planning HMRP:"
echo "    cat $SPRINT_DIR/HMRP_planning.md"
echo ""
echo "2️⃣  Start planning session:"
echo "    claude"
echo "    /role-ceo"
echo ""
echo "3️⃣  Provide sprint goals to CEO agent"
echo ""
echo "4️⃣  After planning, launch agents with:"
echo "    ./scripts/execute-sprint.sh $SPRINT_NUMBER"
echo ""
echo -e "${YELLOW}⚠️  Human actions required:${NC}"
echo "   - Provide strategic direction to CEO"
echo "   - Review and approve agent assignments"
echo "   - Test features after sprint completes"
echo ""
print_success "Ready to plan Sprint $SPRINT_NUMBER!"
