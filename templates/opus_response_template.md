# Opus Response Template for Reverse Glue Commands
**Purpose**: Standardize Opus responses to Claude Code escalations
**Efficiency**: Minimize tokens while providing clear direction

## Response Structure for Escalations

When Opus receives a reverse Glue Command from Claude Code via the user, respond using this optimized format to maintain token efficiency while providing comprehensive guidance.

### Template for BLOCKING Escalations

```markdown
## STRATEGIC DECISION

**Issue**: [Restate issue briefly]
**Decision**: [Clear architectural direction in 1-2 sentences]

**Rationale**: [Brief explanation of why this approach, 2-3 sentences max]

## IMPLEMENTATION DIRECTIVE

[Specific technical guidance in 3-5 bullet points]
- Use [specific technology/pattern] for [reason]
- Implement [approach] to handle [issue]
- Maintain [constraint] while solving [problem]

## GLUE COMMAND FOR CODE

\```bash
claude-code \
  --task="Resume implementation with [specific direction]" \
  --decision="[architectural decision summary]" \
  --approach="[implementation approach]" \
  --constraints="[key constraints to maintain]" \
  --module="[current module]" \
  --continue-from="[last checkpoint]"
\```
```

### Template for STRATEGIC Clarifications

```markdown
## GUIDANCE

**Question**: [Restate question]
**Recommendation**: [Preferred approach in one sentence]

**Quick Rationale**: [1-2 sentences explaining why]

Continue with default approach unless [specific condition].
```

### Template for Progress Reviews

```markdown
## STAGE TRANSITION APPROVED

**From**: [Current stage]
**To**: [Next stage]

**Priority Shift**: [New focus in one sentence]

## NEXT PHASE GLUE COMMAND

\```bash
claude-code \
  --stage="[New stage name]" \
  --priority="[user testing | feature completion | performance]" \
  --focus="[specific focus area]" \
  --user-testing="[enabled/deferred]"
\```
```

## Response Efficiency Guidelines

Opus should frontload decisions to enable immediate Code continuation. Rationales should be brief, providing just enough context to justify the decision without extensive explanation. Implementation directives must be specific and actionable, avoiding abstract guidance that requires interpretation. Glue Commands should be complete and ready for immediate execution without requiring user modification.

When Code provides multiple options in an escalation, Opus should select one definitively rather than analyzing all options at length. If the escalation includes attempted solutions, acknowledge them briefly but focus on the path forward. For non-blocking escalations, confirm whether Code's default approach is acceptable or provide a brief alternative.

## Examples of Efficient Responses

### Example 1: Performance Crisis

```markdown
## STRATEGIC DECISION

**Issue**: Cannot achieve <2 second target with sequential API calls
**Decision**: Implement async parallel calls with 3-API limit to balance speed and rate limits.

**Rationale**: Accept 3-second performance for MVP. Caching will provide sub-second responses for repeat lookups, which satisfies the user experience requirement.

## IMPLEMENTATION DIRECTIVE

- Use asyncio.gather() with semaphore limiting concurrent calls to 3
- Implement exponential backoff for rate limit handling
- Cache all responses immediately, even partial results
- Log response times for future optimization targets

## GLUE COMMAND FOR CODE

\```bash
claude-code \
  --task="Implement async orchestrator with 3-API concurrency limit" \
  --decision="Use asyncio for parallel calls, accept 3-second target for MVP" \
  --approach="asyncio.gather with semaphore, exponential backoff, aggressive caching" \
  --constraints="max_concurrent=3, timeout=5s per API, cache_everything=true" \
  --module="enrichment_orchestrator" \
  --continue-from="data_merger complete"
\```
```

### Example 2: Architectural Conflict

```markdown
## STRATEGIC DECISION

**Issue**: SQLite inadequate for concurrent access patterns
**Decision**: Keep SQLite but implement write queue pattern.

**Rationale**: Avoid external dependencies for single-user application. Queue pattern sufficient for expected load.

## IMPLEMENTATION DIRECTIVE

- Implement write queue with threading.Queue
- Batch writes every 100ms or 10 operations
- Keep read path synchronous and direct
- Add simple retry logic for SQLITE_BUSY errors

## GLUE COMMAND FOR CODE

\```bash
claude-code \
  --task="Implement write queue for SQLite cache manager" \
  --decision="Keep SQLite with write queue pattern" \
  --approach="threading.Queue for writes, batch operations, direct reads" \
  --module="cache_manager" \
  --pattern="write_queue"
\```
```

## Token Optimization Techniques

Avoid repeating information already in Code's escalation context. Reference the escalation file rather than restating details. Use abbreviations and technical shorthand that Code will understand. Eliminate ceremonial language and focus on actionable content. Provide one clear path forward rather than discussing multiple options.

Remember that Claude Code needs direction, not discussion. Every word should either clarify the decision or specify implementation details. The goal is to unblock Code and enable immediate progress with minimal token expenditure.
