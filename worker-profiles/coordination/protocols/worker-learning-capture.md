# 🎓 Worker Learning Capture Protocol

**Purpose:** Ensure workers accumulate knowledge, context, and expertise over time
**When:** After EVERY sprint completion
**Goal:** Workers get smarter with each project (Pokemon evolution!)

---

## 🔄 The Learning Loop

```
Sprint Start → Load Profile & Patterns → Work → Capture Learning → Update Profile → Next Sprint
     ↑                                                                                    ↓
     └────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📖 Phase 1: Sprint Start (Load Context)

### Worker Startup Template

Every worker session should start with this:

```
I'm the [ROLE] Worker - Sprint [X].

1. Loading my profile:
   @~/.claude-workers/[role]/profile.md

2. Loading relevant patterns:
   @~/.claude-workers/[role]/patterns/

3. Reading my sprint tasks:
   @.ai/SPRINT_X_TASKS.md

Current stats:
- Level: [X]
- XP: [current]/[next]
- Top skills: [list]
- Projects completed: [X]

Ready to work with accumulated expertise!
```

**Example:**
```
I'm the Frontend Worker - Sprint 3.

Loading my profile:
@~/.claude-workers/frontend/profile.md

I see I'm Level 2 with 220 XP, PyQt6 ⭐⭐⭐⭐⭐
I've mastered: Language Selector, Catalog View, Modal Dialogs

Loading patterns:
@~/.claude-workers/frontend/patterns/language-selector-pyqt6.md

Reading tasks:
@.ai/SPRINT_3_TASKS.md

Perfect! I'll use my catalog view pattern from Sprint 2 for the translation columns.

Starting work...
```

---

## 💾 Phase 2: Sprint End (Capture Learning)

### After Completing Sprint

Worker creates: `.ai/SPRINT_X_LEARNING_CAPTURE.md`

**Template:**

```markdown
# Sprint [X] Learning Capture - [Worker Role]

**Completed:** [Date/Time]
**Duration:** [Actual time]
**XP Earned:** [Calculate from tasks]

---

## 🎯 What I Built

### Tasks Completed
- [ ] Task 1: [Name] - [Time taken]
- [ ] Task 2: [Name] - [Time taken]
...

### Files Created/Modified
- `path/to/file.py` ([X] lines)
- `path/to/test.py` ([X] tests)

### Tests Written
- Unit: [X]/[X] passing
- Integration: [X]/[X] passing

---

## 📚 New Skills Learned

### Skills Improved
- [Skill Name]: ⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐ (+1 level)
- [New Skill]: NEW → ⭐⭐⭐⭐

### New Patterns Discovered
- [Pattern Name]: [Brief description]
- [Pattern Name]: [Brief description]

---

## 💡 Key Insights

### What Worked Well
- [Insight 1]
- [Insight 2]

### What Was Challenging
- [Challenge 1]: Solved by [solution]
- [Challenge 2]: Solved by [solution]

### Reusable Pattern Identified
**Pattern Name:** [Name]
**Use Case:** [When to use]
**Key Code/Approach:** [Brief summary]
**Save to:** ~/.claude-workers/[role]/patterns/[name].md

---

## 🔗 Dependencies

### Used From Other Workers
- Backend: [What I needed]
- Integration: [What I needed]

### Provided To Other Workers
- [What others can use]

---

## 🎮 XP Breakdown

- Sprint completion: +20
- Tasks completed: [X] × 25 = +[X]
- New skills learned: [X] × 10 = +[X]
- Pattern mastered: +10
- Integration success: +15
- Bonus: [reason] +[X]

**Total XP:** +[X]
**New Total:** [old] + [X] = [new]

---

## 📝 Notes for Next Sprint

### What to Remember
- [Important insight]
- [Gotcha to avoid]

### Suggested Improvements
- [Idea for next time]

---

**Ready for profile update!**
```

---

## 🔄 Phase 3: Update Worker Profile

### Automated Profile Update Script

**Create:** `~/.claude-workers/scripts/update_profile.py`

```python
#!/usr/bin/env python3
"""Update worker profile after sprint completion."""

import re
from pathlib import Path
from datetime import datetime

def update_profile(role: str, learning_capture_file: str):
    """Update worker profile with new XP and skills."""

    # Read learning capture
    capture = Path(learning_capture_file).read_text()

    # Parse XP earned
    xp_match = re.search(r'Total XP: \+(\d+)', capture)
    xp_earned = int(xp_match.group(1)) if xp_match else 0

    # Parse skills improved
    skills = re.findall(r'- (.+): (.+) → (.+)', capture)

    # Read current profile
    profile_path = Path.home() / '.claude-workers' / role / 'profile.md'
    profile = profile_path.read_text()

    # Update XP
    current_xp = re.search(r'XP: (\d+) / (\d+)', profile)
    if current_xp:
        old_xp = int(current_xp.group(1))
        max_xp = int(current_xp.group(2))
        new_xp = old_xp + xp_earned

        profile = profile.replace(
            f'XP: {old_xp} / {max_xp}',
            f'XP: {new_xp} / {max_xp}'
        )

    # Update skills table
    for skill_name, old_level, new_level in skills:
        # Update skill level in profile
        profile = re.sub(
            f'\\| {skill_name} \\| {old_level} \\|',
            f'| {skill_name} | {new_level} |',
            profile
        )

    # Add sprint to history
    sprint_num = re.search(r'Sprint (\d+)', capture)
    if sprint_num:
        history_section = f"\n**Sprint {sprint_num.group(1)}:** [Summary from capture]"
        # Insert into project history section

    # Write updated profile
    profile_path.write_text(profile)

    print(f"✅ Updated {role} worker profile")
    print(f"   +{xp_earned} XP")
    print(f"   {len(skills)} skills improved")

if __name__ == '__main__':
    import sys
    update_profile(sys.argv[1], sys.argv[2])
```

---

## 🎯 Phase 4: Save Patterns

### When to Save a Pattern

Save when you:
- ✅ Solved a problem that will recur
- ✅ Built a reusable component
- ✅ Discovered an efficient approach
- ✅ Overcame a significant challenge

### Pattern Template

**File:** `~/.claude-workers/[role]/patterns/[pattern-name].md`

```markdown
# [Pattern Name]

**Origin:** [Project] - Sprint [X]
**Date:** [Date]
**Type:** [UI Component / API / Algorithm / Workflow]

---

## Context
[When/why this pattern is needed]

## Problem
[What problem does this solve?]

## Solution
[The pattern/approach]

## Code Example
```[language]
[Key code snippet]
```

## Usage
[How to use in future projects]

## Testing
[How to test implementations]

## Lessons
- [Key lesson 1]
- [Key lesson 2]

## Reusable For
- [Use case 1]
- [Use case 2]

---

**Used in:** [List of projects]
**Effectiveness:** [Rating / feedback]
```

---

## 🚀 Full Workflow Example

### GUI Worker - Sprint 3

**1. Start Session:**
```
I'm the Frontend Worker - Sprint 3.

Loading profile: @~/.claude-workers/frontend/profile.md
Current: Level 2, 220 XP, PyQt6 ⭐⭐⭐⭐⭐

Loading patterns:
- Language Selector (Sprint 1)
- Catalog View (Sprint 2)
- Modal Dialogs (Sprint 2)

Reading tasks: @.ai/SPRINT_3_TASKS.md

Great! I'll reuse Catalog View pattern for translation columns.
```

**2. Work on Sprint**
[Worker completes tasks...]

**3. Capture Learning:**
Worker creates `.ai/SPRINT_3_LEARNING_CAPTURE.md`:
```markdown
# Sprint 3 Learning Capture - Frontend Worker

## What I Built
- Enhanced CatalogView with translation columns
- CJK font support (孙子兵法 displays correctly!)
- Translation badges (visual indicators)

## New Skills
- CJK Text Display: NEW → ⭐⭐⭐⭐
- Font Management: ⭐⭐⭐ → ⭐⭐⭐⭐

## Pattern: CJK Font Support
Discovered: System fonts for CJK display
Reusable: Any app with multilingual text
Save to: ~/.claude-workers/frontend/patterns/cjk-font-support.md

## XP Earned: +100
```

**4. Save Pattern:**
```markdown
# CJK Font Support Pattern

**Problem:** Chinese/Japanese/Korean characters show as boxes (□□□)

**Solution:** Detect and use CJK-capable fonts
```python
def setup_cjk_fonts():
    cjk_fonts = [
        "Arial Unicode MS",   # macOS
        "Noto Sans CJK SC",   # Google Noto
        "PingFang SC"         # macOS
    ]
    for font_name in cjk_fonts:
        if QFont(font_name).exactMatch():
            return QFont(font_name, 10)
```

**Reusable:** Any PyQt6 app with CJK text
```

**5. Update Profile:**
```bash
python ~/.claude-workers/scripts/update_profile.py frontend .ai/SPRINT_3_LEARNING_CAPTURE.md
```

Profile now shows:
- XP: 220 → 320
- CJK Text Display: ⭐⭐⭐⭐
- Patterns: 21 (was 18)

---

## 📊 Benefits Over Time

### Sprint 1
- Worker: Blank slate
- Time: 3 hours
- XP gained: +100

### Sprint 5
- Worker: Level 2, 5 patterns
- Time: 2 hours (1.5x faster with patterns!)
- XP gained: +120

### Sprint 10
- Worker: Level 3, 12 patterns
- Time: 1 hour (3x faster!)
- XP gained: +150

---

## 🎯 Integration with Worker Startup

### Standard Worker Initialization

Every worker should:

**1. Load Profile**
```
@~/.claude-workers/[role]/profile.md
```
Sees: Level, XP, skills, projects completed

**2. Load Patterns**
```
@~/.claude-workers/[role]/patterns/*.md
```
Reviews: Available patterns for this sprint

**3. Read Sprint Tasks**
```
@.ai/SPRINT_X_TASKS.md
```
Understands: What to build

**4. Identify Pattern Reuse**
```
"I see this sprint needs a modal dialog - I have that pattern from Sprint 2!"
```

**5. Work with Context**
Worker now has full context and can work faster!

---

## 🔧 Making It Automatic

### Brain's Post-Sprint Checklist

After each sprint, Brain runs:

```bash
# 1. Check all workers completed
find ../book-cataloger-worktrees -name "COMPLETE.txt"

# 2. Remind workers to capture learning
echo "Workers: Create SPRINT_X_LEARNING_CAPTURE.md now!"

# 3. Update profiles
for worker in frontend backend integration quality; do
  if [ -f "../book-cataloger-worktrees/book-cataloger-$worker/.ai/SPRINT_X_LEARNING_CAPTURE.md" ]; then
    python ~/.claude-workers/scripts/update_profile.py $worker \
      ../book-cataloger-worktrees/book-cataloger-$worker/.ai/SPRINT_X_LEARNING_CAPTURE.md
  fi
done

# 4. Capture patterns
# (Worker identifies patterns in learning capture, Brain saves them)

# 5. Update team synergy stats
```

---

## 🎮 Expected Evolution

### Project 1 (Book Cataloger)
- Workers: Level 1-2
- Patterns: 20
- Speed: 1x (baseline)

### Project 3
- Workers: Level 2-3
- Patterns: 40
- Speed: 1.8x

### Project 10
- Workers: Level 4-5
- Patterns: 80
- Speed: 4x

**Workers become experts through accumulated learning!**

---

**This protocol ensures workers never lose knowledge between sprints!** 🧠💾
