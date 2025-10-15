# Supercharge Activation ⚡
**Command:** `/supercharge-activate [role] [duration] [problem]`

## 🍄 TEMPORARY POWER-UP MODE

**This is like putting on a magical hat for 1 hour.**
When it comes off, you return to normal.

### ⚡ What Happens

```
═══════════════════════════════════════════════════
⚡ SUPERCHARGE ACTIVATED ⚡
═══════════════════════════════════════════════════
Role: [ROLE]
Normal Model: Sonnet
POWERED UP TO: OPUS
Duration: 60 minutes (MAX)
Timer Started: [TIMESTAMP]
Auto-Revert: [END TIME]

YOU ARE WEARING THE OPUS HAT!
When time expires, hat comes off.
═══════════════════════════════════════════════════
```

## 🎩 The Opus Hat

Think of it as literally wearing a special hat:
- **Put it on**: Gain Opus powers
- **Timer runs**: 60 minutes max
- **Hat comes off**: Back to Sonnet
- **Can't keep it**: It disappears

## 📋 Activation Checklist

### Before Activation
- [ ] CEO approved? (REQUIRED)
- [ ] Problem defined? (SPECIFIC)
- [ ] Duration set? (60 min default)
- [ ] Pattern goal? (What to extract)
- [ ] Timer ready? (Auto-tracking)

### During Supercharge
```markdown
[ROLE-⚡SUPERCHARGED⚡]: Opus hat is on!
Timer: 45 minutes remaining
Focus: [SPECIFIC PROBLEM]
```

Every output shows:
- ⚡ symbols indicating power mode
- Time remaining
- Specific focus

### Auto-Deactivation
```markdown
[ROLE]: Supercharge expired.
Opus hat removed.
Returning to Sonnet.

Delivered during power-up:
- [Solution]
- [Pattern doc]
```

## ⏰ Time Tracking

### Strict Enforcement
```python
# Automatic timer
supercharge_start = now()
supercharge_end = now() + 60_minutes
remaining = supercharge_end - now()

if remaining <= 0:
    remove_opus_hat()
    return_to_sonnet()
```

### Visual Countdown
```
⚡ 60 min - Fresh power-up
⚡ 45 min - Making progress
⚡ 30 min - Halfway done
⚡ 15 min - Wrap up soon
⚡ 5 min  - Final push!
⚡ 0 min  - Hat comes off
```

## 🚫 What It's NOT

- ❌ NOT a permanent upgrade
- ❌ NOT a regular tool
- ❌ NOT for everyday problems
- ❌ NOT extendable
- ❌ NOT keeping the hat

## ✅ What It IS

- ✅ Emergency power boost
- ✅ Rare and special
- ✅ Time-boxed strictly
- ✅ Problem-specific
- ✅ Temporary hat to wear

## 📝 Usage Example

```bash
# CEO approves
[CEO-OPUS]: Supercharge approved for Backend
Problem: Wikidata SPARQL optimization
Duration: 45 minutes

# Brain implements
[BRAIN]: Adding Supercharge window
Sprint 6B, Today 3:00-3:45 PM

# Worker activates
/supercharge-activate backend 45 "Wikidata SPARQL optimization"

[BACKEND-⚡SUPERCHARGED⚡]: Opus hat on!
45 minutes to solve SPARQL performance.
Beginning deep optimization...

# ... 45 minutes later ...

[BACKEND]: Hat removed. Supercharge complete.
Delivered: 10x query performance + pattern doc
```

## 🎮 The Feeling

When Supercharged:
- 🎩 "I'm wearing the special hat!"
- ⏰ "Clock is ticking!"
- 🎯 "Must solve THIS problem!"
- 💡 "Maximum brain power!"
- 📝 "Document the pattern!"

When it ends:
- 🎩 "Hat goes back in the box"
- ✅ "Mission accomplished"
- 📚 "Pattern documented"
- 🔄 "Back to normal Sonnet"

## ⚠️ Important Rules

1. **Cannot extend time** - When it's done, it's done
2. **Cannot reactivate** - 24hr cooldown per role
3. **Must have purpose** - Specific problem only
4. **Must document** - Pattern extraction required
5. **Must return hat** - Automatic reversion

## 🏆 Success Metric

Did you:
- Solve the blocker? ✓
- Stay within time? ✓
- Extract a pattern? ✓
- Return to Sonnet? ✓

Then you used Supercharge correctly!

---

**Remember**: The hat is borrowed, not owned.
**Wear it wisely.** ⚡