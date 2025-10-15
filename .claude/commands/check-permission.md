# Check Permission - Verify Authorization
**Command:** `/check-permission`

## VERIFY PERMISSION BEFORE ACTION

Check if current role has permission for a specific action.

## USAGE

```bash
/check-permission <action> <target>
```

## EXAMPLES

```bash
# Can CEO modify framework?
/check-permission write .ai/FRAMEWORK/architecture.md

# Can Brain assign tasks?
/check-permission write .ai/tasks/worker_assignments.md

# Can Backend Worker modify Frontend code?
/check-permission write src/frontend/components.py

# Can Worker access strategy documents?
/check-permission read .ai/STRATEGY/vision.md
```

## PERMISSION CHECK SCRIPT

```python
#!/usr/bin/env python3

import sys
import os

# Import the enforcer
sys.path.append('.ai/scripts')
from enforce_permissions import check_permission

# Get current role
try:
    with open('.ai/sessions/current_role.txt', 'r') as f:
        current_role = f.read().strip()
except:
    print("❌ No active role. Run /transform-role-* first")
    sys.exit(1)

# Get action and target from command
if len(sys.argv) < 3:
    print("Usage: /check-permission <action> <target>")
    print("Actions: read, write, delete")
    sys.exit(1)

action = sys.argv[1]
target = sys.argv[2]

# Check permission
if check_permission(current_role, action, target):
    print(f"✅ AUTHORIZED: {current_role} can {action} {target}")
else:
    print(f"❌ DENIED: {current_role} cannot {action} {target}")
    print(f"")
    print(f"Your rank may be insufficient or this may violate standing orders.")
    print(f"Check /show-rank for your permissions.")
```

## COMMON PERMISSION CHECKS

### For CEO
```bash
/check-permission write .ai/SPRINT_6B_PLAN.md  # ✅ Allowed
/check-permission write .ai/FRAMEWORK/arch.md  # ❌ Denied (needs 4-star)
/check-permission read .ai/STRATEGY/vision.md  # ✅ Allowed (read only)
```

### For Brain
```bash
/check-permission write .ai/daily/standup.md   # ✅ Allowed
/check-permission write .ai/FRAMEWORK/arch.md  # ❌ Denied
/check-permission write .ai/tasks/assign.md    # ❌ Denied (CEO only)
```

### For Workers
```bash
/check-permission write src/backend/api.py     # ✅ Allowed (if backend)
/check-permission write src/frontend/ui.py     # ❌ Denied (wrong domain)
/check-permission read .ai/STRATEGY/vision.md  # ❌ Denied (no access)
```

## PERMISSION MATRIX

| Role | Framework | Strategy | Sprint | Tasks | Own Domain | Other Domains |
|------|-----------|----------|--------|-------|------------|---------------|
| Creator | ✅ Write | ✅ Write | ✅ Write | ✅ Write | ✅ Write | ✅ Write |
| Superstar | ✅ Write | ✅ Write | ✅ Read | ✅ Read | ✅ Read | ✅ Read |
| CEO | ⚠️ Read | ⚠️ Read | ✅ Write | ✅ Write | ✅ Read | ✅ Read |
| Brain | ⚠️ Read | ⚠️ Read | ⚠️ Read | ⚠️ Read | ✅ Read | ✅ Read |
| Worker | ❌ None | ❌ None | ⚠️ Read | ⚠️ Read | ✅ Write | ❌ None |

---

*"Check twice, write once."*