# ADR-[NUMBER]: [Decision Title]
*Architecture Decision Record*

**Status:** Proposed / Accepted / Superseded / Deprecated
**Date:** [YYYY-MM-DD]
**Deciders:** Brain Worker, [User name if applicable]
**Sprint:** [Sprint number where this applies]

---

## Context

**Problem Statement:**
[Clear description of the problem or decision that needs to be made]

**Current Situation:**
[How things work now, what limitations exist]

**Why This Matters:**
[Business/technical impact, user needs, strategic goals]

**Constraints:**
- [Constraint 1: e.g., "Must maintain backward compatibility"]
- [Constraint 2: e.g., "Limited to 3 hours implementation time"]
- [Constraint 3: e.g., "Must support existing data"]

---

## Decision Drivers

**Must Have:**
- [Critical requirement 1]
- [Critical requirement 2]

**Should Have:**
- [Important but not critical 1]
- [Important but not critical 2]

**Nice to Have:**
- [Desirable feature 1]
- [Desirable feature 2]

**Will Not Have (this time):**
- [Out of scope 1]
- [Out of scope 2]

---

## Options Considered

### Option 1: [Name]

**Description:**
[Detailed description of this approach]

**Implementation:**
```python
# Pseudo-code or example
[Code example showing approach]
```

**Pros:**
- ✅ [Advantage 1]
- ✅ [Advantage 2]
- ✅ [Advantage 3]

**Cons:**
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Effort:** [X hours]
**Risk:** Low / Medium / High
**Complexity:** Low / Medium / High

---

### Option 2: [Name]

**Description:**
[Detailed description of this approach]

**Implementation:**
```python
# Pseudo-code or example
[Code example showing approach]
```

**Pros:**
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons:**
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Effort:** [X hours]
**Risk:** Low / Medium / High
**Complexity:** Low / Medium / High

---

### Option 3: [Name] (if applicable)

[Same structure as above]

---

## Research & Best Practices

### Industry Standards

**[Standard Name] ([Organization]):**
[How this standard addresses the problem]
- Key principle: [Principle]
- Applicability: [How relevant to our case]
- Reference: [URL or citation]

**[Standard Name] ([Organization]):**
[How this standard addresses the problem]

### Real-World Examples

**[System/Product Name]:**
- Approach: [What they do]
- Context: [When/why they do it]
- Lessons: [What we can learn]

### Academic/Technical Research

**[Paper/Article Title]:**
- Finding: [Key insight]
- Applicability: [How it relates]

---

## Decision

**Chosen Option:** Option [N] - [Name]

**Rationale:**
[Detailed explanation of why this option was chosen over others]

**Key Factors:**
1. [Factor 1: e.g., "Aligns with Library of Congress standards"]
2. [Factor 2: e.g., "Lowest migration risk"]
3. [Factor 3: e.g., "Best long-term maintainability"]

**Acceptable Trade-offs:**
- ⚖️ [Trade-off 1: What we're giving up and why it's okay]
- ⚖️ [Trade-off 2: What we're giving up and why it's okay]

**Rejected Alternatives:**
- Option [X] rejected because: [Reason]
- Option [Y] rejected because: [Reason]

---

## Implementation Plan

### Data Model Changes

**Before:**
```python
[Current data model]
```

**After:**
```python
[New data model]
```

### Database Migration

```python
def migrate_[feature_name]():
    """
    Migration strategy for existing data.
    """
    [Migration pseudo-code]
```

**Migration Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Rollback Plan:**
```python
[How to undo if migration fails]
```

### Code Changes Required

**Files to Create:**
- `[path]` - [Purpose] ([estimated LOC])

**Files to Modify:**
- `[path]` - [Changes needed]

**Files to Deprecate:**
- `[path]` - [Replacement path]

### Worker Assignment

**Which worker implements this ADR:**
- **Worker:** [Backend/Frontend/Integration/Testing]
- **Slash Command:** `/[worker]`
- **Role Identity:** Terminal assumes [Worker] role for implementation
- **Sprint:** Sprint [NUMBER]
- **Estimated Duration:** [X hours]

**Role Boundaries:**
- ✅ This worker WILL: [Specific implementation tasks]
- ❌ This worker WILL NOT: [Tasks deferred to other workers]
- 🤝 Coordination needed with: [Other workers, if any]

### Testing Strategy

**Unit Tests:**
- Test [scenario 1]
- Test [scenario 2]

**Integration Tests:**
- Test [workflow 1]
- Test [workflow 2]

**Migration Tests:**
- Test migration with [data scenario 1]
- Test rollback scenario

---

## Consequences

### Positive Consequences

**Immediate Benefits:**
- ✅ [Benefit 1]
- ✅ [Benefit 2]

**Long-term Benefits:**
- ✅ [Benefit 1]
- ✅ [Benefit 2]

**Technical Benefits:**
- ✅ [Benefit 1: e.g., "Reduced coupling"]
- ✅ [Benefit 2: e.g., "Easier testing"]

### Negative Consequences

**Technical Debt:**
- ⚠️ [Debt 1: e.g., "Requires maintaining both old and new fields temporarily"]
- ⚠️ [Debt 2]

**Complexity:**
- ⚠️ [Complexity 1: e.g., "More files to maintain"]

**Performance:**
- ⚠️ [Impact 1: e.g., "Slight increase in query time"]

### Mitigation Strategies

**For [Negative Consequence]:**
- Mitigation: [How we'll minimize impact]
- Timeline: [When we'll address]

---

## Dependencies

### Blocks These Features:
- [Feature/Sprint] - Cannot proceed until this ADR is implemented

### Depends On:
- [ADR/Feature] - Must be complete before implementing this

### Related ADRs:
- ADR-[XXX]: [Title] - [Relationship]

---

## Success Metrics

**How we'll know this decision was good:**

**Technical Metrics:**
- [Metric 1]: Target [value]
- [Metric 2]: Target [value]

**User Experience Metrics:**
- [Metric 1]: Target [value]
- [Metric 2]: Target [value]

**Process Metrics:**
- Implementation time: Target [X hours]
- Migration success rate: Target [Y%]

---

## Timeline

**Decision Date:** [YYYY-MM-DD]
**Planned Implementation:** Sprint [NUMBER]
**Estimated Duration:** [X hours]
**Review Date:** [YYYY-MM-DD] (3 months post-implementation)

---

## Validation & Review

### Pre-Implementation Checklist
- [ ] User has reviewed and approved
- [ ] Migration strategy validated
- [ ] Test plan created
- [ ] Documentation updated
- [ ] Worker assigned

### Post-Implementation Review

**After implementation, assess:**
- Did we meet success metrics?
- Were estimates accurate?
- What did we learn?
- Would we make the same decision again?

---

## References

**Standards & Best Practices:**
- [Standard name]: [URL]
- [Standard name]: [URL]

**Research Papers:**
- [Paper title]: [Citation]

**Related Discussions:**
- Sprint [X] feedback: [Path to feedback doc]
- User request: [Context]

**Code Examples:**
- [Project/library name]: [URL to example]

---

## Notes

**Open Questions:**
- [Question 1 that still needs answering]
- [Question 2 that still needs answering]

**Future Enhancements:**
- [Enhancement 1 that could build on this]
- [Enhancement 2 that could build on this]

**Alternatives to Revisit:**
- [Alternative approach to reconsider in future if context changes]

---

**Status:** [Current status]
**Last Updated:** [YYYY-MM-DD]
**Next Review:** [YYYY-MM-DD or "After Sprint [X]"]
