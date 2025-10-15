# Comprehensive Monitoring System
*Token Usage, Cost Tracking, Time Metrics, PR Analytics*
*Version: 1.0.0*

## 🎯 Why Monitoring Matters

### The Known Limitations
```yaml
Claude Context Windows:
  - Opus: 500k tokens (200k in desktop, 1M in API)
  - Sonnet: 200k tokens
  - Haiku: 200k tokens

Real Constraints:
  - Token limits per conversation
  - API rate limits
  - Cost per token
  - Time per operation
```

### What We Measure
1. **Token Usage** - Stay within limits
2. **Cost** - Track spending per agent/project
3. **Time** - Identify bottlenecks
4. **Quality** - PR metrics, bug rates
5. **Context** - Prevent context overflow

---

## 📊 Monitoring Architecture

### Data Collection Points
```yaml
agent_level:
  - Tokens used per session
  - Cost per session
  - Time spent per task
  - Files modified

project_level:
  - Total tokens across all agents
  - Total cost
  - Sprint velocity
  - PR metrics

team_level:
  - Agent productivity comparison
  - Cost per feature
  - Token efficiency trends
```

### Storage
```
monitoring/
├── sessions/
│   ├── 2025-01-15-backend-001.json
│   ├── 2025-01-15-frontend-002.json
│   └── ...
├── aggregated/
│   ├── daily.json
│   ├── weekly.json
│   └── monthly.json
├── alerts/
│   └── thresholds.yaml
└── reports/
    ├── cost_report.html
    └── efficiency_dashboard.html
```

---

## 🔢 Token Tracking

### Session-Level Tracking

**Automatic Collection:**
```python
# monitoring/token_tracker.py

class TokenTracker:
    def track_session(self, agent_id: str, session_data: dict):
        """Track token usage for a session"""
        data = {
            "timestamp": now(),
            "agent_id": agent_id,
            "model": session_data["model"],
            "tokens_input": session_data["tokens_in"],
            "tokens_output": session_data["tokens_out"],
            "tokens_total": session_data["tokens_total"],
            "context_used": session_data["tokens_total"] / max_context,
            "cost_usd": calculate_cost(session_data),
            "duration_seconds": session_data["duration"],
            "files_read": len(session_data["files_read"]),
            "files_modified": len(session_data["files_modified"]),
            "lines_changed": session_data["lines_changed"]
        }
        self.save_session(data)
```

### Real-Time Display

```
╔═══════════════════════════════════════════════════════════╗
║            SESSION METRICS - Backend Agent                ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  🎯 Tokens                                                ║
║     Input:   45,230 tokens                                ║
║     Output:  12,450 tokens                                ║
║     Total:   57,680 tokens (28.8% of 200k limit)          ║
║                                                           ║
║  💰 Cost                                                  ║
║     This session: $0.87                                   ║
║     Today total:  $3.42                                   ║
║     Week total:   $12.85                                  ║
║                                                           ║
║  ⏱️ Time                                                  ║
║     Duration: 45 minutes                                  ║
║     Effective rate: 1,282 tokens/min                      ║
║                                                           ║
║  📝 Output                                                ║
║     Files read: 23                                        ║
║     Files modified: 8                                     ║
║     Lines changed: +487 / -124                            ║
║                                                           ║
║  ⚠️ Alerts                                                ║
║     Context usage: 28.8% (HEALTHY)                        ║
║     Daily budget: $3.42 / $10.00 (GOOD)                   ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

### Context Management Strategy

```yaml
context_thresholds:
  green: 0-50%      # Safe, plenty of room
  yellow: 50-75%    # Caution, start cleanup
  orange: 75-90%    # Warning, cleanup required
  red: 90-100%      # Critical, must reset

cleanup_strategies:
  at_50_percent:
    - Remove old pattern references
    - Summarize completed tasks
    - Archive resolved discussions

  at_75_percent:
    - Start fresh conversation
    - Save state to handoff file
    - Load minimal context

  at_90_percent:
    - Forced conversation reset
    - Critical context only
    - Pattern library by reference
```

---

## 💰 Cost Tracking

### Model Pricing (as of 2025-01)
```yaml
pricing:
  opus_4_1:
    input:  $15 per 1M tokens
    output: $75 per 1M tokens

  sonnet_3_5:
    input:  $3 per 1M tokens
    output: $15 per 1M tokens

  haiku_3_5:
    input:  $0.80 per 1M tokens
    output: $4 per 1M tokens
```

### Cost Calculation
```python
def calculate_session_cost(tokens_in, tokens_out, model):
    """Calculate cost for a session"""
    rates = PRICING[model]
    cost_input = (tokens_in / 1_000_000) * rates["input"]
    cost_output = (tokens_out / 1_000_000) * rates["output"]
    return cost_input + cost_output
```

### Budget Alerts
```yaml
budget_thresholds:
  per_session:
    warning: $5.00
    critical: $10.00

  per_day:
    warning: $20.00
    critical: $50.00

  per_week:
    warning: $100.00
    critical: $200.00

  per_project:
    warning: $500.00
    critical: $1000.00

actions:
  warning:
    - Log alert
    - Notify user
    - Continue operation

  critical:
    - Halt operation
    - Require approval to continue
    - Send email/slack alert
```

### Cost Dashboard
```
╔═══════════════════════════════════════════════════════════╗
║              PROJECT COST BREAKDOWN                       ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  📅 This Week (Jan 8-15)                                  ║
║                                                           ║
║     Backend Agent:      $42.50  (35%)                     ║
║     ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░░░░░░░░░░                        ║
║                                                           ║
║     Frontend Agent:     $38.20  (31%)                     ║
║     ▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░░░░░░░░░░░░                       ║
║                                                           ║
║     Integration:        $25.80  (21%)                     ║
║     ▰▰▰▰▰▰▰▰▰░░░░░░░░░░░░░░░░░░░░░                       ║
║                                                           ║
║     Testing:            $10.50  (9%)                      ║
║     ▰▰▰▰░░░░░░░░░░░░░░░░░░░░░░░░░░░                      ║
║                                                           ║
║     CEO:                $5.00   (4%)                      ║
║     ▰▰░░░░░░░░░░░░░░░░░░░░░░░░░░░░░                      ║
║                                                           ║
║  ─────────────────────────────────────────────            ║
║  Total This Week:      $122.00 / $200.00 (61%)            ║
║  Remaining Budget:     $78.00                             ║
║                                                           ║
║  📊 Efficiency Metrics                                    ║
║     Cost per feature:   $24.40                            ║
║     Cost per sprint:    $122.00                           ║
║     Token efficiency:   +23% vs last week                 ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## ⏱️ Time Tracking

### Task-Level Timing
```python
class TimeTracker:
    def track_task(self, agent, task_description):
        """Track time spent on a task"""
        start_time = time.time()

        # Task execution...

        duration = time.time() - start_time
        self.log_task({
            "agent": agent,
            "task": task_description,
            "duration_seconds": duration,
            "timestamp": now()
        })
```

### Time Metrics
```yaml
what_we_measure:
  - Time per task
  - Time per file modified
  - Time per test written
  - Time per bug fixed
  - Idle time
  - Context switching time

insights:
  - Which tasks are slowest
  - Which agents are most efficient
  - Bottlenecks in workflow
  - Parallelization opportunities
```

### Time Dashboard
```
╔═══════════════════════════════════════════════════════════╗
║              TIME ANALYSIS - Sprint 6B                    ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  ⏱️ Total Time Spent                                      ║
║     Development:    18.5 hours                            ║
║     Testing:        4.2 hours                             ║
║     Documentation:  2.1 hours                             ║
║     Planning:       1.8 hours                             ║
║     ────────────────────────                              ║
║     Total:          26.6 hours                            ║
║                                                           ║
║  🎯 Time per Agent                                        ║
║     Backend:        8.5 hours (32%)                       ║
║     Frontend:       7.2 hours (27%)                       ║
║     Integration:    5.8 hours (22%)                       ║
║     Testing:        4.2 hours (16%)                       ║
║     CEO:            0.9 hours (3%)                        ║
║                                                           ║
║  📊 Efficiency                                            ║
║     Avg time per feature:     3.2 hours                   ║
║     Avg time per bug fix:     0.8 hours                   ║
║     Parallel efficiency:      73% (3 agents active)       ║
║                                                           ║
║  🚀 Speed Trends                                          ║
║     vs Sprint 6A:  +18% faster                            ║
║     vs Sprint 5:   +42% faster                            ║
║     Learning curve: Improving ✅                          ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## 📈 Pull Request Metrics

### What We Track
```yaml
pr_metrics:
  size:
    - Lines added
    - Lines deleted
    - Files changed
    - Commits

  quality:
    - Test coverage change
    - Passing tests
    - Review comments
    - Time to merge

  process:
    - Time to first review
    - Time in review
    - Number of reviewers
    - Revision count

  outcome:
    - Merged successfully
    - Bugs introduced (post-merge)
    - Reverted (yes/no)
```

### PR Dashboard
```
╔═══════════════════════════════════════════════════════════╗
║           PULL REQUEST ANALYTICS - Sprint 6B              ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  📊 PR Statistics                                         ║
║     Total PRs:           12                               ║
║     Merged:              11 (92%)                         ║
║     Open:                1                                ║
║     Closed (no merge):   0                                ║
║                                                           ║
║  📏 PR Size (Merged)                                      ║
║     Avg lines changed:   487 lines                        ║
║     Avg files changed:   8 files                          ║
║     Largest PR:          1,240 lines (feature/backend)    ║
║     Smallest PR:         42 lines (bug fix)               ║
║                                                           ║
║  ⏱️ Time Metrics                                          ║
║     Avg time to merge:   4.2 hours                        ║
║     Fastest merge:       1.5 hours                        ║
║     Slowest merge:       18.3 hours                       ║
║     Avg review time:     1.8 hours                        ║
║                                                           ║
║  ✅ Quality                                               ║
║     PRs with tests:      11 / 11 (100%)                   ║
║     Avg test coverage:   +2.3% per PR                     ║
║     Bugs introduced:     0 (excellent!)                   ║
║     Reverted:            0                                ║
║                                                           ║
║  👥 By Agent                                              ║
║     Backend:     4 PRs, 487 avg lines, 100% merged        ║
║     Frontend:    3 PRs, 392 avg lines, 100% merged        ║
║     Integration: 3 PRs, 284 avg lines, 100% merged        ║
║     Testing:     1 PR,  156 lines,     100% merged        ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

### PR Health Indicators
```yaml
healthy_pr:
  - Size: < 500 lines
  - Time to merge: < 8 hours
  - Tests: 100% passing
  - Coverage: Not decreased
  - Review comments: < 10
  - Revisions: < 3

warning_signs:
  - Size: > 1000 lines (too big)
  - Time to merge: > 24 hours (stale)
  - Tests failing
  - Coverage decreased
  - Many review comments (quality issues)
  - Multiple revisions (unclear requirements)

recommended_actions:
  large_pr: "Split into smaller PRs"
  slow_merge: "Prioritize review"
  failing_tests: "Block merge until fixed"
  coverage_drop: "Require additional tests"
```

---

## 🎯 Context Management System

### The Context Problem
```yaml
known_issues:
  - 200k token limit fills up fast
  - Loading full pattern library = 50k tokens
  - Large codebases exceed limit
  - Long conversations lose context

solution:
  - Selective context loading
  - Pattern library by reference
  - Conversation checkpoints
  - State handoff files
```

### Context Budget Allocation
```yaml
context_budget_200k:
  system_prompt:      5,000 tokens  (2.5%)
  agent_profile:      3,000 tokens  (1.5%)
  current_task:       2,000 tokens  (1.0%)
  relevant_code:     80,000 tokens  (40%)
  pattern_library:   20,000 tokens  (10%)
  conversation:      70,000 tokens  (35%)
  response:          20,000 tokens  (10%)
  ────────────────────────────────
  total:            200,000 tokens  (100%)

strategy:
  - Load only relevant patterns (not all 50+)
  - Use pattern index for lookup
  - Summarize long conversations
  - Reference docs by link, not full text
```

### Selective Pattern Loading
```python
# Instead of loading all patterns
def load_relevant_patterns(task_description):
    """Load only patterns relevant to current task"""

    # Example task: "Add API rate limiting"
    relevant_patterns = pattern_index.search(task_description)

    # Returns:
    # - api_rate_limiting.pattern (high relevance)
    # - error_handling.pattern (medium relevance)
    # - api_fallback.pattern (low relevance)

    # Load top 3 patterns only (save 30k tokens)
    return [load_pattern(p) for p in relevant_patterns[:3]]
```

### Conversation Checkpoints
```yaml
checkpoint_triggers:
  - Every 50k tokens used
  - Every 30 minutes
  - Before major task change
  - When context_used > 60%

checkpoint_process:
  1. Summarize conversation so far
  2. Save current state
  3. Create handoff file
  4. Start fresh conversation
  5. Load handoff context (minimal)

handoff_file_contents:
  - Task objectives
  - Completed work
  - Remaining work
  - Key decisions made
  - Patterns used
  - Files modified
  - Next steps
```

---

## 📊 Monitoring Dashboard

### Real-Time Command
```bash
# View current session metrics
/monitor status

# View agent comparison
/monitor agents

# View cost analysis
/monitor cost

# View PR metrics
/monitor prs

# View context status
/monitor context
```

### Weekly Report Email
```
Subject: AI Team Weekly Report - Jan 8-15

📊 Sprint 6B Summary
─────────────────────

💰 Cost: $122.00 / $200 budget (61%)
  • Well within budget
  • +15% more efficient than last week
  • Backend most expensive ($42.50)

⏱️ Time: 26.6 hours total
  • 18.5 hrs development
  • 4.2 hrs testing
  • 2.1 hrs docs
  • Parallel efficiency: 73%

📈 Output
  • 12 PRs (11 merged, 1 open)
  • 5,364 lines added
  • 1,486 lines removed
  • 0 bugs introduced
  • 100% test coverage maintained

🎯 Quality
  • All tests passing ✅
  • No production issues ✅
  • Documentation current ✅
  • Velocity: +18% vs last sprint

🔥 Top Performers
  1. Backend - 8.5 hrs, $42.50, 4 PRs
  2. Frontend - 7.2 hrs, $38.20, 3 PRs
  3. Integration - 5.8 hrs, $25.80, 3 PRs

📝 Recommendations
  • Continue current pace
  • Consider adding Documentation agent
  • Pattern library growing well

Next Sprint: 6C - Polish & Performance
```

---

## 🚨 Alert System

### Alert Types
```yaml
token_alerts:
  context_75_percent:
    severity: warning
    action: "Start context cleanup"
    notify: agent

  context_90_percent:
    severity: critical
    action: "Force conversation reset"
    notify: agent + user

cost_alerts:
  daily_budget_80_percent:
    severity: warning
    action: "Log and continue"
    notify: user

  daily_budget_100_percent:
    severity: critical
    action: "Pause operations"
    notify: user + email

time_alerts:
  task_over_2_hours:
    severity: info
    action: "Log extended task"
    notify: agent

  session_over_4_hours:
    severity: warning
    action: "Suggest break/checkpoint"
    notify: agent + user

quality_alerts:
  test_coverage_decreased:
    severity: warning
    action: "Block PR merge"
    notify: agent

  production_bug:
    severity: critical
    action: "Immediate investigation"
    notify: all_agents + user
```

---

## 🔧 Configuration

### Enable Monitoring
```yaml
# .claude/config.yaml

monitoring:
  enabled: true

  token_tracking:
    enabled: true
    alert_threshold: 0.75  # 75% of limit

  cost_tracking:
    enabled: true
    currency: USD
    budgets:
      daily: 50.00
      weekly: 200.00
      monthly: 800.00

  time_tracking:
    enabled: true
    track_idle: true

  pr_metrics:
    enabled: true
    github_token: ${GITHUB_TOKEN}

  context_management:
    enabled: true
    checkpoint_interval_tokens: 50000
    checkpoint_interval_minutes: 30
```

---

## 📈 Success Metrics

After implementing monitoring:

```yaml
improvements:
  token_efficiency: +35%
  cost_reduction: -28%
  context_overflow: -100% (eliminated)
  budget_overruns: 0
  visibility: High

insights_gained:
  - Backend agent uses 40% of tokens (API docs)
  - Morning sessions 23% more efficient
  - Pattern library lookups save 30k tokens
  - PR size inversely correlated with quality
  - Parallel work saves 3.2x time
```

---

**Remember:** You can't manage what you don't measure. Monitor everything, optimize constantly.

*"The best teams know their numbers."*
