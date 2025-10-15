# Framework vs Patterns: Strategic Definitions
*The spine and brain for all future projects*
*Created: October 12, 2025*

## 🏛️ FRAMEWORK - The Skeleton

**Definition**: The Framework is the **permanent strategic architecture** that defines HOW work gets done across ALL projects, forever.

### What Framework IS:
- **The spine** - Structural support for everything
- **The constitution** - Unchangeable rules and principles
- **The blueprint** - Master plan for all construction
- **The DNA** - Core instructions that replicate across projects
- **The operating system** - Foundation everything runs on

### Framework Components (LEVEL 4 PROTECTED):
```yaml
FRAMEWORK:
  architecture:
    - Role hierarchy and responsibilities
    - Command structure and permissions
    - Decision-making protocols
    - Information flow patterns
    - File organization standards

  methodology:
    - Sprint structure and phases
    - Development workflow
    - Testing protocols
    - Deployment procedures
    - Quality standards

  principles:
    - Zero hardcoding
    - Single source of truth
    - Token efficiency
    - Military discipline
    - Pattern-first development

  systems:
    - Variable resolution system
    - Permission enforcement
    - Token tracking
    - Audit logging
    - Emergency protocols
```

### Who Controls Framework:
- **CREATE**: Superstar Founder (4-star) ONLY
- **MODIFY**: Superstar Founder with Creator approval
- **IMPLEMENT**: CEO (3-star) executes framework
- **FOLLOW**: Everyone else follows framework

### Framework is IMMUTABLE except by 4-star+:
```python
if role_rank < 4:
    raise PermissionError("Framework modification requires 4-star rank")
```

## 🧩 PATTERNS - The Muscles

**Definition**: Patterns are **reusable chunks of work/code** that solve specific problems and can be applied across projects.

### What Patterns ARE:
- **The muscles** - Do the actual work
- **The tools** - Specific solutions to specific problems
- **The recipes** - Step-by-step instructions
- **The templates** - Fill-in-the-blank solutions
- **The building blocks** - Combinable pieces

### Pattern Categories:
```yaml
PATTERNS:
  core_patterns:
    - Graceful shutdown (save session state)
    - Model fallback (Opus → Sonnet degradation)
    - Single source of truth (variable system)
    - Token economics (tracking and optimization)

  implementation_patterns:
    - API retry pattern
    - Database transaction pattern
    - Error handling pattern
    - Logging pattern
    - Testing pattern

  ui_patterns:
    - Modal dialog pattern
    - Form validation pattern
    - Loading state pattern
    - Error display pattern

  coordination_patterns:
    - Handoff protocol pattern
    - Status reporting pattern
    - Sprint ceremony pattern
    - Escalation pattern
```

### Who Controls Patterns:
- **EXTRACT**: Superstar Founder (identifies meta-patterns)
- **CREATE**: CEO can create tactical patterns
- **APPLY**: Brain/Workers apply patterns
- **USE**: Everyone uses patterns

## 🎯 THE CRITICAL DISTINCTION

### FRAMEWORK (Strategic/Permanent)
```yaml
Framework:
  created_by: "Superstar Founder"
  modified_by: "Superstar Founder + Creator"
  nature: "Constitutional/Permanent"
  scope: "All projects forever"
  examples:
    - "How roles are structured"
    - "How decisions flow"
    - "How permissions work"
    - "How sprints run"
  protection: "LEVEL 4 - SECRET"
```

### PATTERNS (Tactical/Reusable)
```yaml
Patterns:
  created_by: "Anyone (but verified by CEO+)"
  modified_by: "CEO with justification"
  nature: "Tactical/Evolutionary"
  scope: "Specific problems"
  examples:
    - "How to save state"
    - "How to retry API calls"
    - "How to validate forms"
    - "How to handle errors"
  protection: "LEVEL 3 - CONFIDENTIAL"
```

## 📐 THE HIERARCHY

```
CREATOR (5⭐)
    ↓ Defines existence
SUPERSTAR FOUNDER (4⭐)
    ↓ Creates FRAMEWORK (the spine)
    ↓ Extracts META-PATTERNS (the principles)
CEO (3⭐)
    ↓ Implements FRAMEWORK
    ↓ Creates TACTICAL PATTERNS
BRAIN (2⭐)
    ↓ Coordinates within FRAMEWORK
    ↓ Applies PATTERNS
WORKERS (1⭐)
    ↓ Execute within FRAMEWORK
    ↓ Use PATTERNS
```

## 🚨 VIOLATIONS

### Framework Violations (COURT MARTIAL)
```python
# ILLEGAL - Worker trying to change framework
if role == "worker" and target == "FRAMEWORK":
    terminate_session("Framework modification by worker - COURT MARTIAL")

# ILLEGAL - Brain changing framework
if role == "brain" and action == "modify_framework":
    terminate_session("Brain exceeded authority - COURT MARTIAL")

# ILLEGAL - CEO changing framework without approval
if role == "ceo" and target == "FRAMEWORK" and not superstar_approval:
    terminate_session("Unauthorized framework change - COURT MARTIAL")
```

### Pattern Violations (DISCIPLINARY ACTION)
```python
# WARNING - Worker creating patterns without approval
if role == "worker" and action == "create_pattern" and not ceo_approval:
    warning("Workers must get pattern approval from CEO")

# WARNING - Using outdated patterns
if pattern.version < current_version:
    warning("Using outdated pattern - update required")
```

## 💎 WHY THIS MATTERS

### Framework = Constitution
- Changes rarely (like constitutional amendments)
- Requires highest authority
- Affects everything
- Must be stable

### Patterns = Laws
- Change as needed
- Can be improved
- Solve specific problems
- Can evolve

### The Framework defines HOW we build
### The Patterns define WHAT we build with

## 📋 EXAMPLES TO CLARIFY

### FRAMEWORK Examples (4-star control):
1. **Role System** - Who does what, chain of command
2. **Sprint Structure** - Planning→Implementation→Testing→Closure
3. **Permission System** - Who can access what
4. **Decision Thresholds** - $100k to Superstar Founder
5. **Token Allocation** - Opus for strategy, Sonnet for tactics

### PATTERN Examples (3-star control):
1. **Save Session Pattern** - How to preserve state
2. **API Retry Pattern** - How to handle failures
3. **Form Validation Pattern** - How to check inputs
4. **Test Structure Pattern** - How to write tests
5. **Error Display Pattern** - How to show errors

## ✅ REMEMBER

- **Framework** = The rules of the game (4-star changes only)
- **Patterns** = The plays in the playbook (3-star can add plays)
- **Workers** = Run the plays, don't write the playbook
- **Brain** = Call the plays, don't change the rules

---

*"The Framework is our constitution. Patterns are our tools."*
*"Respect the Framework. Apply the Patterns. Stay in your lane."*

**THIS DISTINCTION IS SACRED - VIOLATE AT YOUR PERIL**