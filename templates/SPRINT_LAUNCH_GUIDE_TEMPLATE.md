# 🚀 Sprint [NUMBER][LETTER] Launch Guide - [SPRINT NAME]
*[One-line sprint description]*

**Sprint Goal:** [What we're building/fixing]
**Estimated Duration:** [X-Y hours] parallel ([Z worker-hours] sequential)
**Team Size:** [N] workers ([Worker names])
**Sprint Priority:** 🔴 CRITICAL / 🟡 HIGH / 🟢 MEDIUM

---

## 🎯 Sprint Mission

**[High-level description of what this sprint accomplishes]**

### [Category 1: e.g., Critical Bugs]
1. **[Bug/Feature Name]** - [One-line description]
2. **[Bug/Feature Name]** - [One-line description]

### [Category 2: e.g., UI Polish]
3. **[Feature Name]** - [One-line description]
4. **[Feature Name]** - [One-line description]

---

## 📊 Issue Details

### 🔴 [Category]: [Issue Name]

**Problem:**
```
[Code example or description of current behavior]
```

**Expected:**
```
[Code example or description of desired behavior]
```

**Location:** `[file path]:[line numbers]`

**Test ISBN/Data:** [ISBN or test data to verify fix]

**Fix Strategy:**
```python
[Pseudo-code or approach description]
```

**Worker:** [Worker name]
**Time Estimate:** [X minutes/hours]

---

## 👥 Worker Assignments

### [Worker Name] (Terminal [N])
**Time:** [X-Y hours]
**XP:** +[points]
**Current:** Level [N], [XXX] XP ([distance] to Level [N+1])

**Tasks:**
1. **[Task name]** - [Description]
   - [Subtask 1]
   - [Subtask 2]
   - [Subtask 3]

2. **[Task name]** - [Description]
   - [Subtask 1]
   - [Subtask 2]

**Dependencies:** [None / Blocked by X / Blocks Y]

**Deliverables:**
- ✅ [File/feature created or updated]
- ✅ [Tests written and passing]
- ✅ [Manual verification complete]

**Test Script:**
```bash
# Quick validation commands
[commands to verify work]
```

---

## 🚀 Launch Sequence

### Step 1: Pre-Flight Check

**Brain (Terminal 1):**
```bash
cd /Users/z/dev/book-cataloger

# Verify current state
git status
pytest -v  # Ensure all tests pass before starting
```

**Expected:** [What should be true before starting]

---

### Step 2: Launch Workers (Sequential/Parallel)

**[If sequential, explain order and why]**
**[If parallel, explain independent paths]**

**Terminal [N] ([Worker Name]) - [START FIRST/PARALLEL]:**
```bash
cd /Users/z/dev/book-cataloger
claude
```

**Prompt:**
```
/[worker]

Now reading sprint-specific tasks:
@/Users/z/dev/book-cataloger/.ai/SPRINT_[NUMBER][LETTER]_LAUNCH_GUIDE.md

My task: [Specific task from launch guide]

[Any additional context or constraints]

Let me start...
```

**Slash Command Reference:**
- `/role-backend` - Backend Worker identity & patterns
- `/role-frontend` - Frontend Worker identity & UI patterns
- `/role-integration` - Integration Worker identity & orchestration patterns
- `/role-testing` - Testing Worker identity & quality patterns
- `/role-brain` - Brain Worker identity & coordination framework

---

### Step 3: Monitor Progress

**Terminal 1 (Brain):**

```bash
# Watch for new files
watch -n 30 'git status'

# Check specific deliverables
ls -lh [expected file path]

# Run tests periodically
pytest -v --tb=short | tail -20
```

**Handoff checkpoints:**
- [ ] [Worker A] completes [Task X] → [Worker B] can start
- [ ] [Worker B] completes [Task Y] → [Worker C] can start

---

## 🎯 Success Criteria

### [Worker Name] Complete When:
- ✅ [Specific deliverable]
- ✅ [Specific deliverable]
- ✅ [Test count] tests passing
- ✅ Manual verification: [specific check]

### Sprint Complete When:
- ✅ All worker tasks complete
- ✅ All tests passing ([expected count]+)
- ✅ Manual testing checklist complete
- ✅ No regressions in existing features

---

## 🧪 Manual Testing Checklist

**After all workers complete, user tests:**

### [Test Category 1]
- [ ] [Specific test case]
- [ ] [Specific test case]
- [ ] [Specific test case]

### [Test Category 2]
- [ ] [Specific test case]
- [ ] [Specific test case]

**Test Data:**
- ISBN: [specific ISBN for testing]
- File: [specific file for testing]

---

## 🎮 XP Projections

| Worker | Current XP | Sprint XP | New Total | To Next Level |
|--------|-----------|-----------|-----------|---------------|
| [Name] | [XXX] | +[YY] | [ZZZ] | [distance] to Level [N] |
| [Name] | [XXX] | +[YY] | [ZZZ] | **LEVEL [N]!** 🎉 |

**[Worker Name] will LEVEL UP!** 🚀

---

## 📊 Timeline

```
0:00 - [Worker A] starts ([task])
0:XX - [Worker A] done ✅ → [Worker B] can start
1:XX - [Worker B] done ✅
2:XX - All work complete ✅
2:XX - User testing begins
3:XX - Sprint complete! 🎉
```

**Critical path:** [Worker A] → [Worker B] → [Worker C]

---

## 🚨 Known Risks

**Risk 1: [Description]**
- **Likelihood:** High/Medium/Low
- **Impact:** High/Medium/Low
- **Mitigation:** [How to handle]
- **Fallback:** [Plan B if mitigation fails]

---

## 📝 After Sprint Complete

**When all workers finish:**

1. **User Tests** (run manual checklist above)
2. **Brain Reviews** (verify success criteria met)
3. **XP Awards** (update worker profiles)
4. **Learning Capture** (document new patterns if any)
5. **Commit:**
```bash
git add [specific files]
git commit -m "Sprint [NUMBER][LETTER]: [Brief summary]

- [Change 1]
- [Change 2]
- [Change 3]

Fixes #[issue]"
```

6. **Plan Next Sprint** (if user has feedback, analyze it)

---

## 🎯 Sprint Context

**Why this sprint?**
[Explain strategic rationale - user need, blocking issue, etc.]

**What's next after this?**
[Preview next sprint or phase]

---

**Ready to launch Sprint [NUMBER][LETTER]!** 🚀

**Remember:**
1. [Key reminder 1]
2. [Key reminder 2]
3. [Key reminder 3]
