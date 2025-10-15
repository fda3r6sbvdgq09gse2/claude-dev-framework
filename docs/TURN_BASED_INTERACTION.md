# Turn-Based Interaction Model
*Human-AI Collaboration Protocol for Claude Multi-Agent Framework*
*Version: 1.0.0*

---

## 🎯 Core Concept

Development with AI agents follows a **turn-based model**, similar to chess:

```
Human Turn → AI Turn → Human Turn → AI Turn → ...
```

Each turn has a clear beginning, middle, and end. **Context is managed strategically** between turns to optimize token usage and maintain focus.

---

## 📚 Established Terminology

Based on 2025 research in agentic AI systems:

| Term | Definition | Example |
|------|------------|---------|
| **Turn** | One complete input-process-output cycle | Human asks → AI responds |
| **Human Turn** | When human provides input/direction | "Add login feature" |
| **AI Turn** | When AI agent processes and acts | Agent writes code, runs tests |
| **Agentic Loop** | Iterative problem-solving by AI | Agent breaks task → executes → verifies |
| **HITL** | Human-In-The-Loop - human intervention points | Human reviews AI output |
| **Multi-Turn Dialogue** | Back-and-forth conversation | Multiple request-response cycles |
| **Turn Handoff** | Transition between human and AI control | AI finishes → human reviews |

---

## 🔄 What is a "Turn"?

### Human Turn

**Definition**: When a human provides input based on **human cognition**.

**Characteristics**:
- ✅ **Human-generated thought**: Originates from human brain
- ✅ **Intentional direction**: Human decides what happens next
- ✅ **Context evaluation**: Human assesses AI output
- ✅ **Decision authority**: Human chooses path forward

**Types of Human Input**:
1. **Direct instruction**: "Implement OAuth2 login"
2. **Feedback**: "This button should be blue, not red"
3. **Correction**: "Actually, use POST not GET"
4. **Approval/rejection**: "Yes, proceed" or "No, try again"
5. **Context provision**: Pasting error logs, screenshots
6. **Strategic direction**: "Let's pivot to approach B"

**Examples**:
```
✅ Human Turn:
- Creator types: "The login form is confusing, simplify it"
- Creator pastes: [error log from running app]
- Creator says: "Good! Now add the logout button"

❌ NOT Human Turn (AI-generated):
- AI reads a file
- AI runs a command via tool
- AI follows previous instruction
```

### AI Turn

**Definition**: When an AI agent processes input and acts **autonomously**.

**Characteristics**:
- 🤖 **AI-driven execution**: Agent decides implementation details
- 🤖 **Tool usage**: Agent uses Read, Write, Edit, Bash, etc.
- 🤖 **Iterative work**: Agent refines solution
- 🤖 **Pattern application**: Agent applies learned patterns

**AI Turn Phases**:
```
1. Understand: Parse human input
2. Plan: Break down into subtasks
3. Execute: Use tools to implement
4. Verify: Check work (run tests, validate)
5. Report: Summarize what was done
6. Handoff: Return control to human
```

**Examples**:
```
🤖 AI Turn:
- Agent reads files to understand codebase
- Agent writes implementation code
- Agent runs tests
- Agent commits changes
- Agent explains what was done
- Agent says: "Ready for your feedback"
```

---

## 🔀 Turn Handoff Protocol

### Human → AI Handoff

**When**: Human provides input
**AI Response**: Acknowledge and begin work

```markdown
Human: "Add dark mode toggle to settings"

AI Turn Begins:
1. ✅ Acknowledge request
2. 📋 Check context (/context)
3. 📖 Load relevant files (settings UI)
4. 🔧 Implement feature
5. ✅ Test implementation
6. 💾 Commit (if working)
7. 📝 Report completion
8. 🤝 Handoff: "Ready for your review"

Human Turn Begins (awaiting human input)
```

### AI → Human Handoff

**When**: AI completes work or needs direction
**Signal**: Explicit handoff statement

**AI Handoff Signals**:
```
✅ Clear Handoffs:
- "Ready for your review. Test with: [command]"
- "Implementation complete. Your turn - please verify."
- "I need your input: should I proceed with approach A or B?"
- "Blocked: requires API key from you"

❌ Unclear (NOT handoff):
- "Done." (What should human do?)
- [No message, just exits] (Unclear state)
```

**Human Response Options**:
1. **Approve & Continue**: "Good! Now add feature B"
2. **Request Changes**: "Make the button larger"
3. **Ask Questions**: "Why did you choose approach X?"
4. **Provide More Context**: [paste screenshot, logs]
5. **Change Direction**: "Actually, let's try approach B instead"
6. **End Session**: "Great, that's all for now"

---

## 🧠 Context Management Between Turns

### Problem: Context Accumulation

```
Turn 1: Load 20k tokens
Turn 2: Load 30k more → 50k total
Turn 3: Load 40k more → 90k total
Turn 4: Load 50k more → 140k total (70% of 200k limit!)
Turn 5: Load 30k more → 170k total (85% - DANGER!)
```

### Solution: Strategic Context Clearing

**Clear context when:**
- ✅ Task is complete
- ✅ Context > 60% (120k tokens)
- ✅ Switching to unrelated task
- ✅ Don't need old information anymore

**Save before clearing:**
- 💾 Completed task summary
- 💾 Key decisions made
- 💾 Next steps
- 💾 Commit working code

---

## 🔄 Turn-Based Workflow

### Standard Turn Cycle

```
┌─────────────────────────────────────┐
│         HUMAN TURN                  │
│  - Review AI output                 │
│  - Test functionality               │
│  - Provide feedback/direction       │
│  - Commit if working                │
└────────────┬────────────────────────┘
             │ Handoff
             ↓
┌─────────────────────────────────────┐
│         AI TURN                     │
│  1. Acknowledge                     │
│  2. Check context usage (/context) │
│  3. Load only needed files          │
│  4. Implement requested changes     │
│  5. Test implementation             │
│  6. Report completion               │
└────────────┬────────────────────────┘
             │ Handoff
             ↓
┌─────────────────────────────────────┐
│         HUMAN TURN                  │
│  (cycle repeats)                    │
└─────────────────────────────────────┘
```

---

## 📋 Turn Documentation

### Track Turns in .ai/context/

**File**: `.ai/context/turn_log.md`

```markdown
# Turn Log: [Project Name]

## Turn 1 - Human (2025-01-15 14:00)
**Input**: "Implement user authentication"
**Type**: Feature request
**Context**: Starting fresh

## Turn 1 - AI (Backend Agent)
**Actions**:
- Created auth API endpoint
- Added JWT generation
- Wrote tests (8 passing)
**Files Modified**: src/api/auth.py, tests/test_auth.py
**Committed**: Yes (abc123)
**Context Used**: 35k/200k (18%)
**Handoff**: "Ready for testing. Run: python test_auth.py"

## Turn 2 - Human (2025-01-15 14:30)
**Input**: "Tests pass! Now add logout endpoint"
**Type**: Approval + new request
**Context**: Continuing auth work

## Turn 2 - AI (Backend Agent)
**Actions**:
- Added logout endpoint
- Invalidates JWT tokens
- Updated tests (12 passing)
**Files Modified**: src/api/auth.py, tests/test_auth.py
**Committed**: Yes (def456)
**Context Used**: 55k/200k (28%)
**Handoff**: "Logout complete. Test with: [commands]"

## Turn 3 - Human (2025-01-15 15:00)
**Input**: "Perfect! Context is getting high. Let's start fresh for the next feature."
**Type**: Context management decision

## Turn 3 - AI
**Actions**:
- Saved current state to .ai/context/auth_complete.md
- Updated current_task.md with "Auth feature complete"
- Cleared context (exit + new session)
**Context**: Fresh session started

## Turn 4 - Human (2025-01-15 15:05)
**Input**: "Now implement password reset functionality"
**Type**: New feature request
**Context**: Fresh session (5k/200k - 3%)
```

---

## 🏷️ Input Source Tracking

### Human-Generated vs AI-Generated

**Why it matters:**
- Human input reflects **human cognition & creativity**
- AI input reflects **autonomous execution**
- Different sources require different handling

### Tracking System

**Add to every interaction:**

```markdown
## Current Interaction

**Turn**: 15
**Source**: Human
**Timestamp**: 2025-01-15 15:30
**Agent**: Backend
**Context**: 45k/200k (23%)

**Input**:
[Human provides feedback]

---

**Turn**: 16
**Source**: AI (Backend Agent)
**Timestamp**: 2025-01-15 15:32
**Context Start**: 45k/200k
**Context End**: 72k/200k (36%)

**Actions**:
- Read: src/api/users.py
- Edit: src/api/users.py (added function)
- Write: tests/test_users.py (new file)
- Bash: pytest tests/test_users.py (passed)

**Handoff**: "Ready for review"
```

---

## 🎯 Best Practices

### For Humans (You!)

**During Your Turn:**
1. ✅ **Review** AI output thoroughly
2. ✅ **Test** functionality (run code, try app)
3. ✅ **Commit** working code immediately
4. ✅ **Provide clear direction** for next AI turn
5. ✅ **Check context** if session feels slow
6. ✅ **Save state** before ending session

**Example Good Human Turn:**
```
Turn 12 - Human:

Tests pass! ✅

Commits:
git add src/api/auth.py tests/test_auth.py
git commit -m "Add authentication endpoints"

Next steps:
"Now add password reset. Email should use SendGrid.
When done, I'll test with my test account."

Context: 68k/200k (34%) - still good
```

### For AI Agents

**During Your Turn:**
1. ✅ **Check context** immediately (`/context`)
2. ✅ **Load selectively** (only needed files)
3. ✅ **Work incrementally** (test as you go)
4. ✅ **Clear handoff** (tell human what to do next)
5. ✅ **Report context usage** at end of turn
6. ✅ **Recommend refresh** if context > 60%

**Example Good AI Turn:**
```
Turn 12 - AI (Backend Agent):

Context check: 45k/200k (23%) ✅

Actions:
1. Read src/api/auth.py
2. Added logout endpoint
3. Updated tests
4. Ran tests: 12/12 passing ✅

Files:
- src/api/auth.py (+45 lines)
- tests/test_auth.py (+15 lines)

Committed: No (waiting for your approval)

Context now: 68k/200k (34%)

═══════════════════════════════════════
YOUR TURN - Please test:

1. Run tests:
   pytest tests/test_auth.py

2. Test logout:
   curl -X POST http://localhost:8000/api/logout \
     -H "Authorization: Bearer YOUR_TOKEN"

3. If working:
   git add src/api/auth.py tests/test_auth.py
   git commit -m "Add logout endpoint"

4. Then provide next direction or end session.
═══════════════════════════════════════
```

---

## 🔄 Context Refresh Protocol

### When to Refresh Context

```
Trigger Points:
- Context > 60% (120k tokens)
- Task completed
- Switching to unrelated feature
- AI recommends refresh
- Session feels slow/confused
```

### Refresh Procedure

**1. Before Exiting Session:**
```markdown
AI:
> Updating turn log with current state...
> Saving decisions to .ai/context/decisions.md
> Current task status: [status]
> Recommended next steps: [steps]
> Exit now to refresh context
```

**2. Human Exits:**
```bash
> exit
```

**3. Human Reviews State:**
```bash
# Check what was saved
cat .ai/context/current_task.md
cat .ai/context/turn_log.md

# Commit if working
git status
git add [files]
git commit -m "[message]"
```

**4. Start Fresh Session:**
```bash
# New session with clean context
claude

# First message provides continuation context
> "Continue from Turn 12. We completed auth logout.
   Context loaded from .ai/context/current_task.md
   Ready to implement password reset."
```

---

## 📊 Metrics to Track

### Per Turn
- Context usage (tokens)
- Files accessed
- Tools used
- Duration
- Outcome (success/blocked/needs input)

### Per Session
- Total turns
- Human turns vs AI turns
- Context refreshes needed
- Features completed
- Cost

### Example Metrics

```yaml
Session: 2025-01-15 Afternoon
Total Duration: 2h 15m
Total Cost: $2.45

Turns:
  Human: 8
  AI: 8
  Total: 16

Context:
  Refreshes: 1 (after turn 12)
  Peak usage: 165k/200k (83%)
  Average: 45k/200k (23%)

Outcomes:
  Features completed: 2
  Tests added: 24
  Lines of code: +487/-123
  Commits: 4
```

---

## 🎯 Turn Quality Checklist

### High-Quality Human Turn

- [ ] Reviewed AI output thoroughly
- [ ] Tested functionality
- [ ] Committed working code
- [ ] Provided clear next direction
- [ ] Checked context usage
- [ ] Saved state if ending session

### High-Quality AI Turn

- [ ] Checked context at start
- [ ] Loaded only needed files
- [ ] Completed requested work
- [ ] Tested implementation
- [ ] Provided clear handoff instructions
- [ ] Reported context usage
- [ ] Recommended refresh if needed

---

## 🚨 Anti-Patterns

### ❌ Bad Practices

**Human:**
- ❌ Not testing AI output
- ❌ Vague feedback: "make it better"
- ❌ Not committing working code
- ❌ Letting context fill up
- ❌ Not saving state before exit

**AI:**
- ❌ Loading entire codebase
- ❌ Not checking context
- ❌ Unclear handoffs
- ❌ Not testing code
- ❌ Continuing when context > 80%

---

## ✅ Good Practices

### Human Excellence

```
Turn 8 - Human (High Quality):

Review: ✅ Tested login endpoint
Result: ✅ All 12 tests pass
Commit: ✅ git commit -m "Add login endpoint"
Context Check: 52k/200k (26%) - healthy
Next Direction: "Add password reset with SendGrid email"
Files to focus: src/api/auth.py, src/services/email.py
```

### AI Excellence

```
Turn 8 - AI (Backend Agent - High Quality):

Context Check: 52k/200k (26%) ✅
Focused Loading:
  - src/api/auth.py (needed)
  - src/services/email.py (needed)
  - NOT: entire codebase (avoided waste)

Implementation:
  - Password reset endpoint ✅
  - SendGrid integration ✅
  - Tests added (8 new) ✅
  - All tests passing ✅

Context Now: 78k/200k (39%) - still healthy

═══════════════════════════════════════
YOUR TURN:

Test password reset:
1. Request reset: curl -X POST ...
2. Check email (use test SendGrid account)
3. Complete reset: curl -X POST ...

If working:
  git add src/api/auth.py src/services/email.py tests/
  git commit -m "Add password reset with SendGrid"

Context is healthy. Ready for next feature.
═══════════════════════════════════════
```

---

## 📚 Resources

**Research & Standards**:
- [LangGraph Human-in-the-Loop](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/)
- [Agentic Workflows (2025)](https://www.vonage.com/resources/articles/agentic-workflows/)
- [Designing Agentic Loops](https://simonwillison.net/2025/Sep/30/designing-agentic-loops/)

**Framework Documentation**:
- [Context Optimization](./CONTEXT_OPTIMIZATION.md)
- [Workflow Guide](../.ai/WORKFLOW_GUIDE.md)
- [Configuration Architecture](./CONFIGURATION_ARCHITECTURE.md)

---

## 🎓 Summary

**Key Concepts**:
1. **Turn** = One complete input-process-output cycle
2. **Human Turn** = Human-generated direction/feedback
3. **AI Turn** = Autonomous agent execution
4. **Handoff** = Explicit transition between turns
5. **Context Management** = Strategic clearing between turns
6. **Input Source** = Track human vs AI-generated

**Turn Protocol**:
```
Human Turn:
  → Review → Test → Commit → Direct → Check Context

AI Turn:
  → Acknowledge → Check Context → Load Selectively
  → Execute → Test → Report → Handoff

Context > 60%:
  → Save State → Exit → Refresh → Continue

Context > 80%:
  → STOP → Save → Exit → Refresh → MUST restart
```

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Based On**: 2025 Research in Agentic AI Systems & Human-in-the-Loop Workflows