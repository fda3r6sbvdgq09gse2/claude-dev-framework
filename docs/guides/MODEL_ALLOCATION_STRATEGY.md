# Model Allocation Strategy - Opus Scarcity Reality
*Treating Opus like a $3B Founder's Time*
*Created: October 12, 2025*

## 🚨 THE REALITY

**Max 5x Plan Limits**:
- Opus: ~8-10 hours/week
- Sonnet: ~40 hours/week
- Haiku: Unlimited

**Current Burn Rate**: Using Opus in 1-2 days what should last a week
**Required Change**: 90% reduction in Opus usage

## 🎯 NEW ROLE HIERARCHY

### Tier 1: Superstar Founder (Opus) - Use < 5% of time
```yaml
command: /transform-role-superstar-founder
model: claude-3-opus-20240229
when_to_use:
  - Framework architecture decisions
  - $100k+ value patterns
  - Unblocking critical failures
  - Strategic pivots only
  - Pattern extraction from chaos
  - "Break glass in emergency"
cost: $8/hour
availability: 1-2 hours/week MAX
```

### Tier 2: CEO (Sonnet) - Default leadership
```yaml
command: /transform-role-ceo
model: claude-3-5-sonnet-20241022
when_to_use:
  - Sprint planning
  - Tactical decisions
  - Worker coordination
  - Pattern application
  - 90% of leadership tasks
cost: $1.60/hour
availability: 40 hours/week
```

### Tier 3: Brain (Sonnet) - Project coordination
```yaml
command: /transform-role-brain
model: claude-3-5-sonnet-20241022 ONLY
when_to_use:
  - Sprint coordination
  - Test management
  - Worker assignments
  - Daily standups
cost: $1.60/hour
availability: Shared with CEO from 40hr pool
```

### Tier 4: Workers (Sonnet/Haiku) - Implementation
```yaml
commands:
  - /transform-role-backend
  - /transform-role-frontend
  - /transform-role-integration
  - /transform-role-testing
model: sonnet for complex, haiku for simple
when_to_use:
  - All implementation
  - Bug fixes
  - Testing
  - Documentation
cost: $0.20-$1.60/hour
availability: Effectively unlimited with Haiku
```

## 📊 DECISION MATRIX: Which Model?

```python
def select_model(task):
    # Superstar Founder (Opus) - ONLY IF:
    if (task.value > 100000 or
        task.is_framework_architecture or
        task.is_emergency_unblock or
        task.creates_new_pattern):
        if opus_hours_remaining_this_week() > 0:
            return "superstar_founder"
        else:
            return "DEFER_TO_NEXT_WEEK"  # Actually wait!

    # CEO (Sonnet) - DEFAULT LEADERSHIP
    elif (task.is_planning or
          task.is_coordination or
          task.is_tactical):
        return "ceo"

    # Brain (Sonnet) - PROJECT MANAGEMENT
    elif task.is_sprint_management:
        return "brain"

    # Workers (Sonnet/Haiku)
    elif task.is_implementation:
        if task.complexity > 7:
            return "worker_sonnet"
        else:
            return "worker_haiku"
```

## 🚨 OPUS DEPLETION WARNING SYSTEM

### Level 1: Green (>50% remaining)
```
[OPUS STATUS]: 5.2 hours remaining this week (52%)
Continue normal operations
```

### Level 2: Yellow (25-50% remaining)
```
⚠️ [OPUS WARNING]: 2.5 hours remaining this week (25%)
Switch to CEO (Sonnet) for all non-critical tasks
```

### Level 3: Orange (10-25% remaining)
```
🔶 [OPUS CRITICAL]: 1.0 hours remaining this week (10%)
ONLY emergency/framework decisions
```

### Level 4: Red (<10% remaining)
```
🔴 [OPUS EXHAUSTED]: 0.5 hours remaining this week (5%)
EMERGENCY USE ONLY - Consider deferring to next week
```

## 📈 TOKEN BUDGET ALLOCATION

### Weekly Token Budget (Max 5x)
```yaml
total_budget: 5,000,000 tokens/week
allocation:
  superstar_founder: 500,000 (10%)
  ceo: 2,000,000 (40%)
  brain: 1,000,000 (20%)
  workers: 1,500,000 (30%)
```

### Daily Limits
```yaml
monday:
  superstar_founder: 100,000 tokens
  ceo: 400,000 tokens
  workers: 300,000 tokens

tuesday-friday:
  superstar_founder: 50,000 tokens/day
  ceo: 300,000 tokens/day
  workers: 200,000 tokens/day

weekend:
  superstar_founder: 50,000 tokens total
  ceo: 200,000 tokens/day
  workers: unlimited haiku
```

## 🎯 WHEN TO USE SUPERSTAR FOUNDER

### ✅ APPROVED USES (< 5% of time)
1. **Framework Architecture** ($100k+ value)
2. **Pattern Extraction** (10+ reusable patterns)
3. **Strategic Pivots** (Changes entire direction)
4. **Emergency Unblocks** (Team completely stuck)
5. **Investor Decisions** (Would a real $3B founder do this?)

### ❌ NEVER USE SUPERSTAR FOUNDER FOR
1. Sprint planning (CEO handles)
2. Bug fixes (Workers handle)
3. Testing (Workers handle)
4. Documentation (Workers handle)
5. Routine decisions (CEO handles)
6. Implementation (Workers handle)

## 💡 TOKEN EFFICIENCY TECHNIQUES

### 1. File Indexing (Don't read, query)
```python
# Instead of reading entire file:
# ❌ content = read_file("huge_file.md")  # 10,000 tokens

# Use index:
# ✅ summary = read_index("huge_file.md")  # 100 tokens
```

### 2. Lazy Loading
```python
# Load only what's needed:
if task_requires_patterns():
    load_patterns()  # Load only when needed
```

### 3. Summary Caching
```yaml
file: SPRINT_6B_LAUNCH_GUIDE.md
summary: |
  Sprint 6B: Data model + framework
  Duration: 2-3 days
  Workers: Backend, Frontend, Integration, Testing
  Key: Author names, title semantics
tokens_saved: 2,000 per reference
```

### 4. Reference Pointers
```markdown
# Instead of duplicating content:
See: @file.md#section (50 tokens)
Not: [entire section copied] (2,000 tokens)
```

## 📊 TRACKING IMPLEMENTATION

### Per-Message Tracking
```python
@track_tokens
def process_message(msg):
    start_tokens = get_token_count()
    response = generate_response(msg)
    end_tokens = get_token_count()

    log_token_usage({
        'role': current_role,
        'model': current_model,
        'tokens': end_tokens - start_tokens,
        'cost': calculate_cost(end_tokens - start_tokens),
        'timestamp': now()
    })
```

### Session Tracking
```yaml
session_started: 2025-10-12 14:30
role: superstar_founder
model: opus
tokens_used: 125,000
cost: $9.38
value_created: $527,000
roi: 56,141x
```

## 🚀 IMMEDIATE ACTIONS

1. **Rename CEO → superstar_founder** (Opus only)
2. **Rename CEO_Lite → ceo** (Sonnet default)
3. **Create all transform commands**
4. **Implement token tracking**
5. **Set up depletion warnings**
6. **Create file indices**

## 📈 EXPECTED OUTCOMES

### Before (Current)
- Opus exhausted in 1-2 days
- Constant limit hitting
- Forced downtime waiting for reset
- Inefficient token usage

### After (Optimized)
- Opus lasts full week
- Strategic use only
- Continuous productivity
- 90% cost reduction
- Same output quality

## ✅ SUCCESS METRICS

Week 1 Goals:
- [ ] Opus usage < 10 hours
- [ ] Sonnet usage > 30 hours
- [ ] Zero forced downtime
- [ ] ROI > 10,000x
- [ ] Patterns extracted: 10+

---

*"Treat Opus like meeting with Elon Musk - rare, valuable, transformative"*

**Current Status**: Restructuring needed urgently before Opus exhausted