# Quick Start Guide

## Installation (5 minutes)

### 1. Set Up Worker Profiles
```bash
cp -r worker-profiles/.claude-workers ~/
```

### 2. Set Up Your Project
```bash
cd your-project

# Create .ai directory structure
mkdir -p .ai/{context,patterns,progress,templates}

# Copy templates
cp -r /path/to/claude-dev-framework/templates/* .ai/templates/

# Copy slash commands
mkdir -p .claude/commands
cp /path/to/claude-dev-framework/.claude/commands/* .claude/commands/
```

### 3. Initialize Sprint
```bash
cd your-project/.ai

# Create current sprint tracker
cat > CURRENT_SPRINT.md << 'SPRINT'
# Current Sprint Status
- **Sprint**: Sprint 1
- **Status**: Planning
- **Focus**: [Your focus]
SPRINT
```

### 4. Start First Worker
```bash
cd your-project
claude

# In Claude Code:
/role-ceo
# or
/role-backend
```

## First Sprint Workflow

1. **CEO plans** (`/role-ceo`)
2. **Workers implement** in parallel worktrees
3. **Integration merges** feature branches
4. **Testing validates** everything works
5. **Repeat**

## Parallel Development Setup

### Create Worktrees for Each Worker
```bash
cd your-project

# Backend worker
git worktree add ../your-project-backend -b feature/backend

# Frontend worker
git worktree add ../your-project-frontend -b feature/frontend

# Integration worker
git worktree add ../your-project-integration -b feature/integration

# Testing worker
git worktree add ../your-project-testing -b feature/testing
```

### Open Multiple Terminal Windows
```bash
# Terminal 1 - Backend
cd ../your-project-backend
claude
/role-backend

# Terminal 2 - Frontend
cd ../your-project-frontend
claude
/role-frontend

# Terminal 3 - Integration
cd ../your-project-integration
claude
/role-integration

# Terminal 4 - Testing
cd ../your-project-testing
claude
/role-testing
```

## Tips for Success

1. **Start with CEO planning** - Get the architecture right first
2. **Use patterns** - Don't reinvent solutions
3. **Track progress** - Update .ai/context files regularly
4. **Test frequently** - Quality over speed
5. **Document learnings** - Extract new patterns

## Next Steps

- Read [Super Brain Vision](vision/SUPER_BRAIN_VISION_001.md) for the big picture
- Study [Model-Aware Framework](guides/MODEL_AWARE_FRAMEWORK.md) for optimal model usage
- Browse [Pattern Library](../patterns/) for reusable solutions
- Check [Worker Profiles](../worker-profiles/) to understand each role

See [full documentation](guides/) for detailed guidance.
