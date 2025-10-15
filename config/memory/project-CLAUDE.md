# Project: [Your Project Name]
*Template for project-level CLAUDE.md*
*Location: Place in project root or `.claude/` directory*

---

## 🎯 Project Overview

**Name**: [Your Project Name]
**Purpose**: [One-sentence description]
**Stack**: [Tech stack - e.g., "FastAPI + React + PostgreSQL"]
**Current Sprint**: [Sprint number or phase]

---

## 🏗️ Architecture

### Core Components
```
your-project/
├── backend/          # [Description]
├── frontend/         # [Description]
├── database/         # [Description]
├── tests/            # [Description]
└── docs/             # [Description]
```

### Key Technologies
- **Backend**: [Framework, language, key libraries]
- **Frontend**: [Framework, language, key libraries]
- **Database**: [Database type, ORM]
- **Testing**: [Testing frameworks]
- **Deployment**: [Platform, CI/CD]

---

## 📋 Current Task

**Active Work**:
```
@.ai/context/current_task.md
```

**Completed Work**:
```
@.ai/context/completed_tasks.md
```

**Roadmap**:
```
@.ai/context/roadmap.md
```

---

## 🎨 Code Standards

### Module Design
- **Size**: 100-300 lines per module (optimal for Claude context)
- **Responsibility**: Single responsibility per module
- **Documentation**: Comprehensive docstrings + inline comments

### Naming Conventions
```
Files:      snake_case.py / kebab-case.ts
Classes:    PascalCase
Functions:  snake_case / camelCase
Constants:  UPPER_SNAKE_CASE
```

### Import from Standards
```
@.ai/rules/code_standards.md
@.ai/rules/module_size.md
@.ai/rules/documentation.md
```

---

## 🔧 Development Workflow

### Starting Work
1. Check current task: `@.ai/context/current_task.md`
2. Load relevant agent: `/role-backend` or `/role-frontend`
3. Check context: `/context`
4. Begin work

### During Work
1. Follow patterns: `@.ai/patterns/[relevant-pattern].md`
2. Update progress in `.ai/context/current_task.md`
3. Check context usage every 30 minutes
4. Commit working increments

### Finishing Work
1. Run tests: `[your test command]`
2. Update completed tasks: `.ai/context/completed_tasks.md`
3. Commit with descriptive message
4. Update current task for next session

---

## ✅ Testing Requirements

**Coverage Target**: [85% / 90% / Your target]

**Test Commands**:
```bash
# Unit tests
[Your unit test command - e.g., pytest tests/unit/]

# Integration tests
[Your integration test command]

# E2E tests
[Your E2E test command - e.g., playwright test]

# All tests
[Your all tests command]
```

**Test Organization**:
```
tests/
├── unit/              # Testing Agent
├── integration/       # Testing Agent
└── e2e/               # QA Automation Agent
```

---

## 🎯 Agents for This Project

**Active Agents**:
- ✅ Backend (APIs, data, services)
- ✅ Frontend (UI/UX)
- ✅ Integration (business logic)
- ✅ Testing (QA)
- ⚠️  CEO (strategic planning only)

**Optional Agents**:
- DevOps (if infrastructure work needed)
- QA Automation (if UI testing needed)
- UX/Product (if user feedback needed)

---

## 🚀 Deployment

**Environment**: [Development / Staging / Production]

**Deployment Commands**:
```bash
# Build
[Your build command]

# Deploy
[Your deploy command]

# Rollback
[Your rollback command]
```

---

## 🔐 Security & Secrets

**Environment Variables**: `.env` (gitignored)

**Required Secrets**:
```
API_KEY=            # [Description]
DATABASE_URL=       # [Description]
[Other secrets]
```

**Never Commit**:
- `.env` files
- API keys
- Passwords
- Private keys
- Credentials

---

## 📚 Key Documentation

**Project Docs**:
```
@README.md
@ARCHITECTURE.md          # If exists
@API_DOCUMENTATION.md     # If exists
```

**Framework Patterns**:
```
@.ai/patterns/api_integration.md
@.ai/patterns/ui_patterns.md
@.ai/patterns/testing_patterns.md
```

---

## 🎯 Success Metrics

**Quality**:
- Test coverage: [Target %]
- Bugs in production: [Target: 0]
- Code review score: [Target]

**Performance**:
- API response time: [Target ms]
- Page load time: [Target ms]
- Uptime: [Target %]

**Development**:
- Sprint velocity: [Story points]
- Time per feature: [Target]
- Token efficiency: [Target]

---

## 🤝 Team Collaboration

### Git Workflow
```bash
# Feature branch pattern
git checkout -b feature/[feature-name]

# Commit message format
[type]: [description]
# Types: feat, fix, docs, style, refactor, test, chore

# Before PR
- Run all tests
- Update documentation
- Check for secrets
```

### Code Review
- All code requires review (except solo dev)
- Address all comments
- Run tests before requesting review

---

## 📝 Project-Specific Notes

### Known Issues
[List any known issues or technical debt]

### Decisions Log
[Key architectural or technical decisions made]

### Future Plans
[Features or improvements planned for future sprints]

---

## 🔗 Resources

**Repository**: [GitHub/GitLab URL]
**Documentation**: [Docs URL]
**Issue Tracker**: [Issues URL]
**Monitoring**: [Dashboard URL]

---

## 🎛️ Configuration

**Framework Variables**:
```
@config/VARIABLES.yaml
```

**Project Settings**:
```
@.claude/settings.json
```

---

**Version**: 1.0.0
**Last Updated**: [Date]
**Review**: Update at start of each sprint
