# HMRP Template - Human-Machine Request Protocol
*Reusable Template for Consistent Request Structure*
*Version: 1.0*

## 📋 Template Structure

```markdown
═══════════════════════════════════════════════════════════
📋 [REQUEST_TYPE]: [Brief Description]
═══════════════════════════════════════════════════════════

## 🎯 PURPOSE
[Why this request exists - the goal]

## 👤 FOR
[Target human role: creator/test_user_primary/developer]

## 🖥️ TERMINAL
[Which terminal: 1-6, specify role]

## 🤖 TARGET
[Which AI role: CEO/Brain/Backend/Frontend/Integration/Testing]

## ⏱️ ESTIMATED TIME
[Realistic time estimate]

## 🚦 PRIORITY
[🔴 CRITICAL | 🟡 HIGH | 🟢 NORMAL | ⚪ LOW]

───────────────────────────────────────────────────────────
## 📝 GLUE COMMAND
───────────────────────────────────────────────────────────

```
[Exact command(s) to copy and paste]
/role-[role]

[Initial context loading]
@/path/to/relevant/file.md

[Specific instructions]
```

───────────────────────────────────────────────────────────
## 🎮 EXECUTION STEPS
───────────────────────────────────────────────────────────

### Step 1: [First Action]
[Detailed instructions]

### Step 2: [Second Action]
[Detailed instructions]

### Step 3: [Third Action]
[Detailed instructions]

───────────────────────────────────────────────────────────
## 📊 EXPECTED OUTPUT
───────────────────────────────────────────────────────────

### Format
[Describe output format]

### Example
```
[Show example output]
```

### Success Metrics
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [Measurable outcome 3]

───────────────────────────────────────────────────────────
## ⚠️ ERROR HANDLING
───────────────────────────────────────────────────────────

### Common Issues
1. [Potential problem]: [Solution]
2. [Potential problem]: [Solution]

### Fallback
If blocked: [Alternative approach]

───────────────────────────────────────────────────────────
## ✅ COMPLETION CRITERIA
───────────────────────────────────────────────────────────

Request complete when:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

───────────────────────────────────────────────────────────
## 📝 NOTES
───────────────────────────────────────────────────────────

[Any additional context or warnings]

═══════════════════════════════════════════════════════════

*Protocol created by: [ROLE]*
*Date: [YYYY-MM-DD]*
*Reusable for: [Use cases]*
```

## 🎯 Usage Guidelines

### When to Use HMRP
- Complex multi-step requests
- Cross-role coordination
- User-facing tasks
- Repeatable processes
- Testing protocols

### Template Variables
Replace these in your HMRP:
- `[REQUEST_TYPE]`: USER_TEST, SPRINT_PLANNING, BUG_FIX, etc.
- `[Brief Description]`: One-line summary
- `[role]`: ceo, brain, backend, frontend, integration, testing
- `[YYYY-MM-DD]`: Actual date

### Emoji Standards
Consistent emoji use:
- 📋 Requests/Documents
- 🎯 Purpose/Goals
- 👤 Human roles
- 🖥️ Terminals
- 🤖 AI roles
- ⏱️ Time
- 🚦 Priority
- ✅ Success
- ⚠️ Warnings
- 📊 Data/Metrics
- 🎮 Actions
- 🔄 Process
- 💰 Economics
- ⚡ Power/Supercharge
- 🏀 Sports analogies

### Section Dividers
```
═══════════════════════════════════════════════════════════  # Main sections
───────────────────────────────────────────────────────────  # Subsections
```

## 📊 HMRP Types Catalog

### Testing Protocols
- `USER_TEST_COORDINATION`: Guide testing
- `REGRESSION_TEST`: Automated testing
- `PERFORMANCE_TEST`: Speed testing

### Development Protocols
- `SPRINT_PLANNING`: Sprint coordination
- `BUG_FIX`: Issue resolution
- `FEATURE_IMPLEMENTATION`: New features
- `REFACTORING`: Code improvement

### Framework Protocols
- `PATTERN_EXTRACTION`: Find reusable patterns
- `DOCUMENTATION`: Create docs
- `ARCHITECTURE_REVIEW`: Design decisions

### Coordination Protocols
- `WORKER_HANDOFF`: Task transfer
- `ROLE_TRANSITION`: Role switching
- `SUPERCHARGE_REQUEST`: Power-up approval

## 🔄 Version History

### v1.0 (2025-10-12)
- Initial template creation
- Standardized structure
- Emoji guidelines
- Section formatting

## ✅ Quality Checklist

Before publishing an HMRP:
- [ ] All sections filled
- [ ] Glue command tested
- [ ] Time estimate realistic
- [ ] Success criteria measurable
- [ ] Error handling included
- [ ] Template variables replaced
- [ ] Formatting consistent

---

*Master template maintained by: CEO*
*For updates: Create ADR for template changes*