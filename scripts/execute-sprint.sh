#!/bin/bash
# Sprint Execution Automation
# Launches agents in parallel using worktrees

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

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

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <sprint_number> [agent1 agent2 ...]"
    echo "Example: $0 7A backend frontend integration testing"
    echo "If no agents specified, reads from sprint plan"
    exit 1
fi

SPRINT_NUMBER=$1
shift
AGENTS=("$@")

SPRINT_DIR=".ai/sprints/sprint-$SPRINT_NUMBER"
PROJECT_NAME=$(basename $(pwd))

print_header "🚀 Executing Sprint $SPRINT_NUMBER"

# Check sprint exists
if [ ! -d "$SPRINT_DIR" ]; then
    print_error "Sprint directory not found: $SPRINT_DIR"
    echo "Run: ./scripts/launch-sprint.sh $SPRINT_NUMBER \"Sprint Name\""
    exit 1
fi

# If no agents specified, try to read from plan
if [ ${#AGENTS[@]} -eq 0 ]; then
    echo "No agents specified. Reading from sprint plan..."
    # This would need to parse the plan.md file
    # For now, default to common agents
    AGENTS=("backend" "frontend" "integration" "testing")
    print_warning "Using default agents: ${AGENTS[*]}"
fi

# Check worktrees exist
echo ""
echo -e "${BLUE}Checking Worktrees${NC}"
echo "────────────────────────────────────────────────────────────"

for agent in "${AGENTS[@]}"; do
    worktree_path="../${PROJECT_NAME}-${agent}"
    if [ ! -d "$worktree_path" ]; then
        print_warning "Worktree not found: $worktree_path"
        echo "Creating worktree..."
        git worktree add "$worktree_path" -b "feature/sprint-${SPRINT_NUMBER}-${agent}"
        print_success "Created worktree for $agent"
    else
        print_success "Worktree exists: $agent"
    fi
done

# Generate terminal instructions
echo ""
print_header "🎮 Agent Launch Instructions"
echo ""
echo "Open ${#AGENTS[@]} terminal windows/tabs and run these commands:"
echo ""

terminal_num=1
for agent in "${AGENTS[@]}"; do
    worktree_path="../${PROJECT_NAME}-${agent}"

    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}Terminal $terminal_num: ${agent^^} Agent${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "cd $worktree_path"
    echo "claude"
    echo "/role-$agent"
    echo ""
    echo "Load sprint context:"
    echo "@$SPRINT_DIR/plan.md"
    echo ""
    echo "Start working on assigned tasks..."
    echo ""

    ((terminal_num++))
done

# Save execution instructions to file
echo ""
echo -e "${BLUE}Saving Instructions${NC}"
echo "────────────────────────────────────────────────────────────"

INSTRUCTIONS_FILE="$SPRINT_DIR/execution-instructions.md"
cat > "$INSTRUCTIONS_FILE" << EOF
# Sprint $SPRINT_NUMBER Execution Instructions
*Generated: $(date '+%Y-%m-%d %H:%M:%S')*

## Agent Launch Commands

EOF

terminal_num=1
for agent in "${AGENTS[@]}"; do
    worktree_path="../${PROJECT_NAME}-${agent}"

    cat >> "$INSTRUCTIONS_FILE" << EOF
### Terminal $terminal_num: ${agent^^} Agent

\`\`\`bash
cd $worktree_path
claude
/role-$agent

# Load sprint context
@$SPRINT_DIR/plan.md

# Start working on your assigned tasks
\`\`\`

EOF
    ((terminal_num++))
done

cat >> "$INSTRUCTIONS_FILE" << EOF
## Execution Guidelines

1. **Each agent works independently** in their worktree
2. **Check context regularly**: Use \`/context\` command
3. **Commit frequently**: Commit working code to feature branch
4. **Test as you go**: Run tests after each significant change
5. **Stay in domain**: Don't edit files outside your responsibility
6. **Exit when done**: Type \`exit\` and report completion

## During Sprint

- Context usage should stay < 60%
- If context > 60%, save state and start fresh session
- Each agent commits to their feature branch
- No agent should touch another agent's domain

## Completion

When all agents complete:
1. Run: \`./scripts/integrate-sprint.sh $SPRINT_NUMBER\`
2. This will merge branches and run tests
3. Then user testing begins
EOF

print_success "Instructions saved to $INSTRUCTIONS_FILE"

# Update sprint status
cat > ".ai/current_sprint.md" << EOF
# Current Sprint: $SPRINT_NUMBER

**Status**: Executing
**Started**: $(date '+%Y-%m-%d %H:%M:%S')
**Agents**: ${AGENTS[*]}

## Quick Links
- Instructions: $INSTRUCTIONS_FILE
- Plan: $SPRINT_DIR/plan.md
- Execution Log: $SPRINT_DIR/execution-log.md
EOF

# Create agent status tracking file
cat > "$SPRINT_DIR/agent-status.yaml" << EOF
sprint: $SPRINT_NUMBER
status: executing
started: $(date '+%Y-%m-%d %H:%M:%S')

agents:
EOF

for agent in "${AGENTS[@]}"; do
    cat >> "$SPRINT_DIR/agent-status.yaml" << EOF
  $agent:
    status: not_started
    worktree: ../${PROJECT_NAME}-${agent}
    branch: feature/sprint-${SPRINT_NUMBER}-${agent}
    tasks_complete: 0
    context_usage: 0
EOF
done

print_success "Agent status tracking initialized"

echo ""
print_header "✅ Sprint $SPRINT_NUMBER Ready to Execute"
echo ""
echo -e "${GREEN}Next Steps:${NC}"
echo ""
echo "1️⃣  Open ${#AGENTS[@]} terminal windows"
echo ""
echo "2️⃣  Copy/paste commands from above (or from $INSTRUCTIONS_FILE)"
echo ""
echo "3️⃣  Agents work in parallel"
echo ""
echo "4️⃣  When all agents complete, integrate with:"
echo "    ./scripts/integrate-sprint.sh $SPRINT_NUMBER"
echo ""
echo -e "${YELLOW}⚠️  Human Role During Execution:${NC}"
echo "   - Monitor agent progress (optional)"
echo "   - Answer questions if agents get blocked"
echo "   - Otherwise, let agents work autonomously"
echo ""
print_success "Sprint execution ready!"
