# HMRP Dynamic System - Audience-Aware Templates
*Sprint-Cycle Aware, Role-Specific, Zero Hardcoding*
*Version: 2.0*

## 🎯 Core Principle

**Every HMRP adapts to:**
- WHO is reading (human vs machine)
- WHICH role (CEO, Brain, Worker, User)
- WHEN in sprint cycle (Planning, Implementation, Testing, Analysis)
- WHAT context (references CURRENT_SPRINT.md dynamically)

## 📊 Audience Matrix

### Human Recipients
```yaml
humans:
  creator:
    reading_style: Strategic overview
    detail_level: Summary + options
    terminology: Business-friendly
    examples: Required

  test_user_primary:
    reading_style: Step-by-step
    detail_level: Explicit instructions
    terminology: Non-technical
    examples: Visual/screenshots

  developer:
    reading_style: Technical specs
    detail_level: Implementation details
    terminology: Technical
    examples: Code snippets
```

### Machine Recipients
```yaml
machines:
  ceo:
    format: Strategic patterns
    context: Framework-wide
    references: "@/SUPER_BRAIN_VISION_001.md"
    output: Patterns and vision

  brain:
    format: Coordination tasks
    context: "@/CURRENT_SPRINT.md"
    references: Sprint guides
    output: Plans and assignments

  workers:
    format: Implementation specs
    context: Task-specific
    references: Pattern library
    output: Code and tests
```

## 🔄 Sprint Cycle Templates

### Phase 1: Planning (Day 0-1)
```markdown
# Dynamic HMRP - Planning Phase

═══════════════════════════════════════════════════════════
📋 SPRINT_PLANNING: {{current_sprint.next}}
═══════════════════════════════════════════════════════════

## 🎯 PURPOSE
Plan {{current_sprint.next}} based on {{current_sprint.current}} results

## 📍 DYNAMIC REFERENCES
Sprint Status: @{{paths.current_sprint}}
Previous Sprint: @{{paths.last_sprint_results}}
Pattern Library: @{{paths.pattern_index}}

## 🤖 FOR: {{role.brain}}
[BRAIN]: Load current context from:
- {{paths.current_sprint}}
- {{paths.sprint_guide}}
- {{paths.worker_profiles}}

## 👤 FOR: {{role.creator}}
Review options and approve plan
```

### Phase 2: Implementation (Day 1-3)
```markdown
# Dynamic HMRP - Implementation Phase

═══════════════════════════════════════════════════════════
📋 IMPLEMENTATION: {{current_sprint.current}} Day {{sprint.day}}
═══════════════════════════════════════════════════════════

## 🎯 PARALLEL WORK STREAMS
Workers: @{{paths.worker_assignments}}
Dependencies: @{{paths.dependency_graph}}

## 🤖 FOR: {{role.worker}}
[{{worker.role}}]: Your tasks from:
@{{paths.current_sprint}}#{{worker.section}}

## 🔄 COORDINATION
Brain monitors via: @{{paths.progress_tracker}}
```

### Phase 3: Testing (Day 3-4)
```markdown
# Dynamic HMRP - Testing Phase

═══════════════════════════════════════════════════════════
📋 USER_TESTING: {{current_sprint.current}} Validation
═══════════════════════════════════════════════════════════

## 👤 FOR: {{role.test_user}}
Test protocol: @{{paths.test_protocol}}
Previous issues: @{{paths.last_test_results}}

## 🤖 FOR: {{role.brain}}
Coordinate testing via protocol at:
@{{paths.test_protocol}}
```

### Phase 4: Analysis (Day 4-5)
```markdown
# Dynamic HMRP - Analysis Phase

═══════════════════════════════════════════════════════════
📋 SPRINT_ANALYSIS: {{current_sprint.current}} Results
═══════════════════════════════════════════════════════════

## 🤖 FOR: {{role.ceo}}
Extract patterns from: @{{paths.sprint_deliverables}}
Update: @{{paths.pattern_library}}

## 👤 FOR: {{role.creator}}
Review results: @{{paths.sprint_summary}}
Approve next: @{{paths.next_sprint_proposal}}
```

## 🔧 Dynamic Variable System

### Path Variables (Never Hardcode)
```python
paths = {
    "current_sprint": "/Users/z/dev/book-cataloger/.ai/CURRENT_SPRINT.md",
    "sprint_guide": lambda: f"{read_current_sprint().guide_path}",
    "test_protocol": lambda: f".ai/SPRINT_{get_sprint_number()}_TEST_PROTOCOL.md",
    "pattern_index": "/Users/z/.claude-framework/patterns/PATTERN_INDEX.md",
    "worker_profiles": "/Users/z/.claude-workers/*/profile.md",
    "temporal": "/Users/z/dev/book-cataloger/.ai/TEMPORAL_AWARENESS.md"
}
```

### Sprint Variables (Auto-Updated)
```python
current_sprint = {
    "current": read_from("CURRENT_SPRINT.md", "active_sprint"),
    "next": calculate_next_sprint(),
    "day": calculate_sprint_day(),
    "phase": determine_sprint_phase()
}
```

### Role Variables (Context-Aware)
```python
role = {
    "current": detect_current_role(),
    "model": detect_current_model(),
    "level": read_from(f"{role}_profile.md", "level"),
    "xp": read_from(f"{role}_profile.md", "xp")
}
```

## 📝 Template Selection Logic

```python
def select_hmrp_template(context):
    """Select appropriate HMRP based on context"""

    # Determine sprint phase
    phase = get_sprint_phase()  # Planning/Implementation/Testing/Analysis

    # Determine audience
    audience = detect_audience()  # human/machine
    role = detect_role()  # ceo/brain/worker/user

    # Select template
    template = load_template(f"hmrp_{phase}_{audience}_{role}.md")

    # Inject dynamic variables
    template = template.replace_variables({
        "{{current_sprint}}": read_current_sprint(),
        "{{paths}}": get_dynamic_paths(),
        "{{role}}": get_role_context()
    })

    return template
```

## 🎭 Audience-Specific Formatting

### For Humans
```markdown
# Clear Headers
**Bold key points**
- Bullet lists for steps
- Examples with real values
- Visual indicators 🎯 ✅ ⚠️
- Time estimates included
- Success criteria explicit
```

### For Machines (AI Roles)
```markdown
@/exact/file/paths.md
```yaml
structured_data:
  key: value
  list: [items]
```
[ROLE]: Specific instruction format
Pattern references: PATTERN_###
No redundant explanation
```

## 🔄 Sprint Cycle Integration

### Automatic Phase Detection
```python
def get_current_phase():
    sprint_day = get_sprint_day()
    if sprint_day == 0:
        return "PLANNING"
    elif sprint_day <= 3:
        return "IMPLEMENTATION"
    elif sprint_day == 4:
        return "TESTING"
    else:
        return "ANALYSIS"
```

### Phase-Specific HMRP Selection
```yaml
planning:
  templates: [sprint_planning, pattern_review, resource_allocation]
  audience: [brain, ceo, creator]

implementation:
  templates: [worker_tasks, progress_check, blocker_resolution]
  audience: [workers, brain]

testing:
  templates: [user_testing, regression_testing, performance_testing]
  audience: [test_user, testing_worker, brain]

analysis:
  templates: [results_analysis, pattern_extraction, next_sprint]
  audience: [ceo, brain, creator]
```

## 🚀 Usage Examples

### Example 1: Dynamic Sprint Reference
```markdown
# Instead of:
"Sprint 6B Implementation"

# Use:
"{{current_sprint.current}} {{current_sprint.phase}}"

# Resolves to:
"Sprint 6B Implementation" (dynamically)
```

### Example 2: Role-Aware Instructions
```markdown
# Template:
## FOR: {{audience.type}}
{{audience.instructions}}

# Resolves for human:
## FOR: Test User
Please follow these steps:
1. Open the application
2. Click the green button
3. Enter test data

# Resolves for machine:
## FOR: Backend Worker
@/implementation/specs.md
Execute: pattern_###
Output: /src/module.py
```

### Example 3: Phase-Aware Content
```markdown
# Template:
## Current Phase: {{sprint.phase}}
{{phase_specific_content}}

# Resolves Day 0:
## Current Phase: Planning
Review feedback and plan next sprint

# Resolves Day 2:
## Current Phase: Implementation
Continue assigned tasks, report blockers
```

## ✅ Benefits of Dynamic System

1. **No Hardcoding**: Everything references source files
2. **Sprint-Aware**: Knows where we are in cycle
3. **Audience-Optimized**: Different format per recipient
4. **Self-Updating**: Changes flow from source files
5. **Reusable**: Same template works every sprint
6. **Context-Rich**: Full awareness of current state

## 📋 Implementation Checklist

To make any HMRP dynamic:
- [ ] Replace sprint numbers with {{current_sprint}}
- [ ] Replace file paths with {{paths.variable}}
- [ ] Add audience detection
- [ ] Include phase awareness
- [ ] Reference CURRENT_SPRINT.md
- [ ] Reference TEMPORAL_AWARENESS.md
- [ ] No hardcoded dates
- [ ] No hardcoded roles
- [ ] Clear recipient marking

---

*Dynamic system by: CEO-OPUS*
*Single sources of truth respected*
*Zero hardcoding guaranteed*