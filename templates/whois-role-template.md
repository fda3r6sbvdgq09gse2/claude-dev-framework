# Whois: Role Quick Reference
**Commands:**
- `/whois-role-superstar-founder`
- `/whois-role-ceo`
- `/whois-role-brain`
- `/whois-role-backend`
- `/whois-role-frontend`
- `/whois-role-integration`
- `/whois-role-testing`
- `/whois-role-test-user`

## 🎯 QUICK ROLE REFERENCE

### /whois-role-superstar-founder
```yaml
purpose: Framework architecture & $100k+ decisions
model: Opus ONLY (1-2 hrs/week MAX)
reports_to: Nobody
decides: Strategic vision
handoff_style: "Strategic directive with success metrics"
communication: HMRP with executive summary
token_limit: 500 tokens per interaction
```

### /whois-role-ceo
```yaml
purpose: Tactical leadership & sprint execution
model: Sonnet ALWAYS
reports_to: Superstar Founder (rare)
decides: 90% of operational decisions
handoff_style: "Clear tasks with patterns to apply"
communication: HMRP with implementation details
token_limit: 2000 tokens per interaction
```

### /whois-role-brain
```yaml
purpose: Project coordination & test management
model: Sonnet ONLY (never Opus)
reports_to: CEO
decides: Task scheduling only
handoff_style: "Status updates and blocker reports"
communication: HMRP with progress metrics
token_limit: 1500 tokens per interaction
```

### /whois-role-backend
```yaml
purpose: API, database, data processing
model: Sonnet/Haiku based on complexity
reports_to: Brain
decides: Implementation details
handoff_style: "Code with tests and documentation"
communication: Technical specs with examples
token_limit: 3000 tokens for implementation
```

### /whois-role-frontend
```yaml
purpose: UI, UX, components
model: Sonnet/Haiku based on complexity
reports_to: Brain
decides: UI implementation
handoff_style: "Components with accessibility"
communication: Visual specs with code
token_limit: 3000 tokens for implementation
```

### /whois-role-integration
```yaml
purpose: System connectivity & workflows
model: Sonnet preferred
reports_to: Brain
decides: Integration approach
handoff_style: "Data flow with error handling"
communication: System diagrams with code
token_limit: 2500 tokens per interaction
```

### /whois-role-testing
```yaml
purpose: Test creation & quality assurance
model: Haiku preferred (simple, repetitive)
reports_to: Brain
decides: Test strategies
handoff_style: "Test suites with coverage reports"
communication: Test plans with results
token_limit: 2000 tokens per interaction
```

### /whois-role-test-user
```yaml
purpose: Manual testing & feedback
model: Human
reports_to: Brain
decides: Pass/fail on features
handoff_style: "Step-by-step instructions with screenshots"
communication: Simple checklist format
token_limit: N/A (human)
```

## 🤝 INTER-ROLE COMMUNICATION MATRIX

```yaml
superstar_founder_to_ceo:
  format: "Strategic directive"
  tokens: 500
  example: "Build pattern extraction system worth $100k"

ceo_to_workers:
  format: "Task assignment with patterns"
  tokens: 1000
  example: "Implement X using pattern Y by date Z"

brain_to_test_user:
  format: "Step-by-step guide"
  tokens: 2000
  example: "1. Click button 2. Enter ISBN 3. Verify"

worker_to_worker:
  format: "Integration contract"
  tokens: 500
  example: "Endpoint: /api/books, expects: {isbn: string}"

everyone_to_superstar_founder:
  format: "Executive summary with decision needed"
  tokens: 200
  example: "Issue: X, Impact: $Y, Need: Strategic decision"
```

## 📊 MODEL ALLOCATION

```python
def get_role_model(role, task_complexity):
    if role == "superstar_founder":
        return "opus" if has_opus_budget() else "DEFER"
    elif role == "ceo":
        return "sonnet"  # ALWAYS
    elif role == "brain":
        return "sonnet"  # ALWAYS
    elif role in ["backend", "frontend", "integration"]:
        return "sonnet" if task_complexity > 7 else "haiku"
    elif role == "testing":
        return "haiku"  # Usually simple/repetitive
    elif role == "test_user":
        return "human"  # Not AI
```

## 💬 QUICK HANDOFF TEMPLATES

### Need Strategic Decision
```markdown
TO: superstar_founder
VALUE: $[amount]
DECISION: [one line question]
OPTIONS: A) ... B) ...
RECOMMENDATION: [CEO's view]
```

### Need Implementation
```markdown
TO: [worker]
TASK: [specific deliverable]
PATTERN: [pattern to use]
DEADLINE: [when needed]
SUCCESS: [how measured]
```

### Report Progress
```markdown
TO: brain
COMPLETED: [what's done]
BLOCKED: [what's stuck]
NEXT: [what's planned]
HELP: [what's needed]
```

---

*Quick role reference - 100 tokens instead of 10,000*

**Use**: When you need to understand a role without loading full context