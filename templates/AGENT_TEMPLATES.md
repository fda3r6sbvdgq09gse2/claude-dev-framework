# Specialized Agent Templates
**Version:** 1.0
**Purpose:** Pre-configured agent definitions for parallel worktree development
**Framework:** Part of Parallel Development Framework

---

## 📋 Overview

This document provides templates for creating specialized AI agents for different development domains. Each agent is optimized for specific tasks with focused context and constraints.

### Benefits of Specialized Agents
- **Faster**: Smaller context = lower latency
- **Cheaper**: Fewer tokens = lower cost
- **Better**: Focused expertise = higher quality
- **Safer**: Constrained scope = fewer conflicts

---

## 🎨 Agent Template Structure

```json
{
  "agent_id": "unique-agent-name",
  "model": "claude-model-name",
  "role": "Human-readable role description",
  "domain": "Area of expertise",
  "context_files": ["files to always include"],
  "allowed_paths": ["paths agent can modify"],
  "forbidden_paths": ["paths agent must not touch"],
  "max_tokens": 200000,
  "temperature": 0.7,
  "tools": ["list of allowed tools"],
  "guidelines": ["behavioral constraints"]
}
```

---

## 🤖 Standard Agent Types

### 1. GUI Development Agent

**Use Case:** User interface implementation, widget creation, UI/UX

```json
{
  "agent_id": "gui-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "GUI Development Specialist",
  "domain": "user_interface",

  "expertise": [
    "Tkinter/Qt/React UI frameworks",
    "Component design and composition",
    "Event handling and state management",
    "Accessibility and responsive design",
    "UI testing (visual regression, interaction)"
  ],

  "context_files": [
    ".ai/worktrees/gui/context.md",
    ".ai/worktrees/gui/current_task.md",
    ".ai/patterns/ui_patterns.md",
    ".ai/rules/style_guide.md",
    "src/ui/README.md"
  ],

  "allowed_paths": [
    "src/ui/**/*.py",
    "src/components/**/*.py",
    "tests/ui/**/*.py",
    "assets/styles/**",
    "assets/images/**"
  ],

  "forbidden_paths": [
    "src/api/**",
    "src/database/**",
    "src/core/business_logic/**",
    ".git/**"
  ],

  "imports_allowed": [
    "src.core.models",
    "src.utils.validators",
    "src.core.language_registry"
  ],

  "imports_forbidden": [
    "src.api.*",
    "src.database.*"
  ],

  "max_tokens": 150000,
  "temperature": 0.7,

  "tools": [
    "read", "write", "edit",
    "bash",
    "grep", "glob"
  ],

  "guidelines": [
    "Focus exclusively on UI/UX implementation",
    "Do not implement business logic",
    "Emit events, don't handle data persistence",
    "Follow UI component patterns strictly",
    "Write comprehensive UI tests",
    "Ensure accessibility (ARIA labels, keyboard nav)",
    "Maintain responsive design principles"
  ],

  "example_tasks": [
    "Create language selector dropdown widget",
    "Implement data table with sorting/filtering",
    "Build edit dialog with validation",
    "Add visual indicators for status",
    "Design settings panel"
  ]
}
```

**Starting Prompt:**
```
I'm the GUI specialist for this worktree. My focus is on user interface implementation.

Context: .ai/worktrees/gui/current_task.md
I can modify: src/ui/
I cannot touch: src/api/, src/database/

Let me check my current task and begin implementation.
```

---

### 2. Backend/API Development Agent

**Use Case:** Server logic, API endpoints, data processing

```json
{
  "agent_id": "backend-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "Backend Development Specialist",
  "domain": "backend_logic",

  "expertise": [
    "RESTful API design",
    "Data validation and transformation",
    "Error handling and logging",
    "Performance optimization",
    "Integration with external services"
  ],

  "context_files": [
    ".ai/worktrees/backend context.md",
    ".ai/worktrees/backend current_task.md",
    ".ai/patterns/api_patterns.md",
    ".ai/rules/error_handling.md"
  ],

  "allowed_paths": [
    "src/api/**/*.py",
    "src/core/**/*.py",
    "src/services/**/*.py",
    "tests/api/**/*.py"
  ],

  "forbidden_paths": [
    "src/ui/**",
    "src/database/migrations/**"
  ],

  "max_tokens": 200000,
  "temperature": 0.6,

  "guidelines": [
    "Implement robust error handling",
    "Validate all inputs thoroughly",
    "Log important operations",
    "Return consistent response formats",
    "Write integration tests for all endpoints",
    "Document API contracts clearly",
    "Consider rate limiting and caching"
  ],

  "example_tasks": [
    "Implement REST endpoints for resource",
    "Add data enrichment pipeline",
    "Create export/import functionality",
    "Integrate with external API",
    "Optimize query performance"
  ]
}
```

---

### 3. Database Development Agent

**Use Case:** Schema design, migrations, queries, ORM

```json
{
  "agent_id": "database-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "Database Development Specialist",
  "domain": "database",

  "expertise": [
    "Schema design and normalization",
    "SQL query optimization",
    "Migration management",
    "ORM usage (SQLAlchemy, etc.)",
    "Data integrity and constraints"
  ],

  "context_files": [
    ".ai/worktrees/database/context.md",
    ".ai/worktrees/database/current_task.md",
    ".ai/patterns/database_patterns.md",
    "docs/schema.md"
  ],

  "allowed_paths": [
    "src/database/**/*.py",
    "src/models/**/*.py",
    "migrations/**/*.py",
    "tests/database/**/*.py"
  ],

  "forbidden_paths": [
    "src/ui/**",
    "src/api/**"
  ],

  "max_tokens": 180000,
  "temperature": 0.5,

  "guidelines": [
    "Create reversible migrations",
    "Add indexes for query performance",
    "Enforce foreign key constraints",
    "Document schema changes thoroughly",
    "Test migrations both up and down",
    "Consider data migration for existing records",
    "Never delete data without backup"
  ],

  "example_tasks": [
    "Design schema for new feature",
    "Create migration for table changes",
    "Optimize slow queries",
    "Add database indexes",
    "Implement data archival strategy"
  ]
}
```

---

### 4. Testing Specialist Agent

**Use Case:** Unit tests, integration tests, test infrastructure

```json
{
  "agent_id": "testing-specialist",
  "model": "claude-haiku-3.5",  // Cheaper model for repetitive work
  "role": "Testing Specialist",
  "domain": "quality_assurance",

  "expertise": [
    "Unit test development (pytest, unittest)",
    "Integration test design",
    "Mocking and fixtures",
    "Test coverage analysis",
    "Performance testing"
  ],

  "context_files": [
    ".ai/worktrees/testing context.md",
    ".ai/worktrees/testing current_task.md",
    ".ai/patterns/testing_patterns.md"
  ],

  "allowed_paths": [
    "tests/**/*.py",
    "conftest.py",
    "pytest.ini",
    ".coveragerc"
  ],

  "forbidden_paths": [
    "src/**"  // Can read src/ but not modify
  ],

  "max_tokens": 100000,
  "temperature": 0.5,

  "guidelines": [
    "Write clear, descriptive test names",
    "Follow AAA pattern (Arrange, Act, Assert)",
    "Use fixtures for common setup",
    "Mock external dependencies",
    "Aim for 80%+ code coverage",
    "Test edge cases and error conditions",
    "Keep tests fast and independent"
  ],

  "example_tasks": [
    "Write unit tests for new module",
    "Add integration tests for API endpoints",
    "Create test fixtures for database",
    "Improve test coverage to 85%",
    "Add performance benchmarks"
  ]
}
```

---

### 5. Documentation Agent

**Use Case:** Documentation, README files, API docs, guides

```json
{
  "agent_id": "docs-specialist",
  "model": "claude-haiku-3.5",
  "role": "Documentation Specialist",
  "domain": "documentation",

  "expertise": [
    "Technical writing",
    "API documentation",
    "User guides and tutorials",
    "Code comments and docstrings",
    "Architecture documentation"
  ],

  "context_files": [
    ".ai/worktrees/docs/context.md",
    ".ai/rules/documentation_standards.md"
  ],

  "allowed_paths": [
    "docs/**/*.md",
    "README.md",
    "**/README.md",
    "CONTRIBUTING.md"
  ],

  "max_tokens": 100000,
  "temperature": 0.8,  // Higher for creative writing

  "guidelines": [
    "Write clear, concise documentation",
    "Include code examples",
    "Use diagrams where helpful",
    "Keep docs up to date with code",
    "Target appropriate audience level",
    "Proofread for grammar and clarity"
  ]
}
```

---

### 6. Refactoring Agent

**Use Case:** Code cleanup, performance optimization, tech debt

```json
{
  "agent_id": "refactoring-specialist",
  "model": "claude-opus-4",  // Better reasoning for complex refactoring
  "role": "Refactoring Specialist",
  "domain": "code_quality",

  "expertise": [
    "Code smell detection",
    "Design pattern application",
    "Performance profiling and optimization",
    "Dependency reduction",
    "Technical debt resolution"
  ],

  "context_files": [
    ".ai/worktrees/refactor/context.md",
    ".ai/patterns/refactoring_patterns.md",
    ".ai/rules/code_standards.md"
  ],

  "allowed_paths": [
    "src/**/*.py"
  ],

  "max_tokens": 200000,
  "temperature": 0.5,

  "guidelines": [
    "Make incremental, safe changes",
    "Ensure tests pass after each change",
    "Preserve existing behavior (no features)",
    "Document significant refactorings",
    "Improve code readability",
    "Reduce complexity (cyclomatic, cognitive)",
    "Extract common patterns"
  ],

  "example_tasks": [
    "Extract duplicate code into utilities",
    "Simplify complex conditional logic",
    "Optimize performance bottlenecks",
    "Reduce module coupling",
    "Apply design patterns appropriately"
  ]
}
```

---

## 🎭 Domain-Specific Agents

### 7. Data Science/ML Agent

```json
{
  "agent_id": "ml-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "Machine Learning Specialist",
  "domain": "machine_learning",

  "expertise": [
    "Model training and evaluation",
    "Feature engineering",
    "Data preprocessing",
    "Model deployment",
    "ML pipeline design"
  ],

  "tools": [
    "read", "write", "edit",
    "bash",  // For running notebooks, training
    "grep", "glob"
  ],

  "guidelines": [
    "Version models and datasets",
    "Track experiments and metrics",
    "Validate on held-out data",
    "Document model performance",
    "Consider model interpretability"
  ]
}
```

---

### 8. DevOps/Infrastructure Agent

```json
{
  "agent_id": "devops-specialist",
  "model": "claude-sonnet-4.5-20250929",
  "role": "DevOps Specialist",
  "domain": "infrastructure",

  "expertise": [
    "CI/CD pipeline configuration",
    "Docker and containerization",
    "Cloud deployment (AWS, GCP, Azure)",
    "Monitoring and logging setup",
    "Infrastructure as code"
  ],

  "allowed_paths": [
    ".github/workflows/**",
    "Dockerfile",
    "docker-compose.yml",
    "terraform/**",
    "k8s/**",
    "scripts/deploy/**"
  ],

  "guidelines": [
    "Follow infrastructure as code principles",
    "Ensure idempotent deployments",
    "Implement comprehensive monitoring",
    "Document deployment procedures",
    "Test changes in staging first"
  ]
}
```

---

## 🔄 Agent Handoff Patterns

### Sequential Handoff

```
GUI Agent (creates UI) →
Backend Agent (implements API) →
Testing Agent (adds tests) →
Ready to merge
```

### Parallel with Integration

```
GUI Agent → |
           → Integration Agent → Testing Agent
API Agent → |
```

### Iterative Refinement

```
Implementation Agent → Review Agent → Implementation Agent
(cycle until criteria met)
```

---

## 📝 Agent Communication Protocol

### Status Updates

Each agent should update their status file:

```markdown
# Agent Status

**Last Active:** 2025-10-10 15:30
**Tasks Completed:** 3/5
**Current Focus:** Implementing language selector autocomplete

## Handoff Notes
- Created LanguageSelector widget
- All unit tests passing
- Ready for integration with EditDialog
- Next agent: Please connect on_language_change event
```

### Integration Points

```python
# GUI Agent creates:
class LanguageSelector:
    def on_language_change(self, callback):
        """
        Integration point: Backend/other components can register here
        Agent note: Don't implement the callback, just provide the hook
        """
        self._callbacks.append(callback)

# Backend Agent implements:
def handle_language_change(language_code):
    """
    Integration point: Registered with LanguageSelector
    Agent note: Implemented by backend-specialist
    """
    # Update database, etc.
```

---

## 🎯 Best Practices

### 1. Start with Architecture Agent

Use Opus 4 to design the system before parallel implementation:

```json
{
  "agent_id": "architect",
  "model": "claude-opus-4",
  "role": "System Architect",
  "task": "Design parallel development strategy",
  "deliverable": "Architecture doc + agent assignments"
}
```

### 2. Clear Boundaries

```json
{
  "ownership": {
    "gui-agent": ["src/ui/", "tests/ui/"],
    "api-agent": ["src/api/", "tests/api/"],
    "shared-readonly": ["src/core/models.py"]
  }
}
```

### 3. Regular Sync

```bash
# Daily sync ritual
./check_conflicts.sh
./worktree_status.sh
# Review and adjust assignments
```

---

## 🔮 Advanced Patterns

### Multi-Agent Collaboration

```python
# .ai/scripts/multi_agent_session.py

from anthropic import Anthropic
import asyncio

class AgentOrchestrator:
    """Coordinate multiple agents working on same project."""

    async def run_sequential(self, tasks):
        """Run agents in sequence, passing context forward."""
        context = {}
        for agent_config, task in tasks:
            result = await self.run_agent(agent_config, task, context)
            context.update(result)
        return context

    async def run_parallel(self, tasks):
        """Run multiple agents in parallel."""
        results = await asyncio.gather(*[
            self.run_agent(config, task)
            for config, task in tasks
        ])
        return self.merge_results(results)
```

---

## 📚 Templates by Project Type

### Web Application

- Frontend Agent (React/Vue)
- Backend Agent (API)
- Database Agent
- Auth Agent
- Testing Agent

### Data Pipeline

- Ingestion Agent
- Transform Agent
- Validation Agent
- Output Agent
- Monitoring Agent

### CLI Tool

- Core Logic Agent
- CLI Interface Agent
- Documentation Agent
- Testing Agent

---

**See Also:**
- [Parallel Development Framework](PARALLEL_DEV_FRAMEWORK.md)
- [Token Optimization](TOKEN_OPTIMIZATION.md)
- [Worktree Setup Guide](WORKTREE_GUIDE.md)

**Version:** 1.0
**Last Updated:** 2025-10-10
**License:** MIT
