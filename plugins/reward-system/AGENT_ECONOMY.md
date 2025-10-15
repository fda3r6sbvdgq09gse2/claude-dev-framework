# Agent Economy System
*Multi-Layered Incentive Model*
*Version: 2.0.0*

## 🎮 Three-Layer Reward System

### Layer 1: Pokémon XP & Leveling 📊
**Purpose:** Long-term progression
**Mechanism:** XP points → Level ups
**Benefit:** Unlock capabilities, agent growth

### Layer 2: Football Manager Attributes ⚽
**Purpose:** Skill specialization
**Mechanism:** 1-20 ratings per skill
**Benefit:** Detailed performance tracking

### Layer 3: Salary & Bonuses 💰
**Purpose:** Project-based rewards
**Mechanism:** Base salary + performance bonuses
**Benefit:** Economic incentives, ROI tracking

---

## 📊 Layer 1: XP & Leveling (Existing)

Already documented in main README. Summary:

```yaml
XP Earning:
  - Task completion: +5 to +30 XP
  - Quality bonuses: +10 to +20 XP
  - Project milestones: +50 to +150 XP

Level Progression:
  - Level 1: Novice (0-500 XP)
  - Level 2: Intermediate (500-1500 XP)
  - Level 3: Advanced (1500-3000 XP)
  - Level 4: Expert (3000-5000 XP)
  - Level 5: Master (5000+ XP)
```

---

## ⚽ Layer 2: Football Manager Attributes

### Attribute System (1-20 scale)

Each agent has ratings across multiple skills:

#### Backend Agent Attributes
```yaml
Technical Skills:
  - API Integration: 18/20    # Expert at REST APIs
  - Database Design: 14/20    # Good, room to grow
  - Caching Strategy: 17/20   # Strong caching skills
  - Error Handling: 19/20     # Excellent resilience
  - Performance Tuning: 12/20 # Developing skill

Soft Skills:
  - Communication: 15/20      # Clear updates to team
  - Collaboration: 16/20      # Works well with others
  - Documentation: 13/20      # Adequate docs
  - Problem Solving: 17/20    # Strong analytical skills
  - Adaptability: 14/20       # Handles change well

Domain Expertise:
  - Python: 18/20            # Python expert
  - Cloud Services: 11/20     # Learning AWS/GCP
  - Security: 13/20          # Basic security awareness
```

#### Frontend Agent Attributes
```yaml
Technical Skills:
  - Component Design: 17/20
  - State Management: 15/20
  - CSS/Styling: 16/20
  - Accessibility: 14/20
  - Performance: 13/20

UX Skills:
  - User Research: 12/20
  - Interaction Design: 15/20
  - Responsive Design: 17/20
  - Animation: 11/20
  - Cross-browser: 16/20

Frameworks:
  - React: 18/20
  - PyQt: 16/20
  - CSS Frameworks: 14/20
```

#### Integration Agent Attributes
```yaml
Technical Skills:
  - Workflow Design: 18/20
  - Business Logic: 17/20
  - Data Transformation: 16/20
  - Event Handling: 15/20
  - Coordination: 19/20

Soft Skills:
  - Communication: 19/20      # Excellent coordinator
  - Leadership: 16/20
  - Conflict Resolution: 15/20
  - Planning: 17/20
  - Mentorship: 14/20
```

### Attribute Growth

Attributes improve with practice:

```yaml
improvement_rules:
  task_completion:
    - relevant_attribute: +0.1 per task
    - cap_per_sprint: +1.0 max

  quality_bonus:
    - zero_bugs: +0.3 to primary attributes
    - excellent_tests: +0.2 to relevant attributes

  project_completion:
    - +0.5 to all worked attributes
    - +1.0 to standout attributes

  diminishing_returns:
    - 1-10: Fast growth (+0.2 per success)
    - 11-15: Medium growth (+0.1)
    - 16-18: Slow growth (+0.05)
    - 19-20: Very slow (+0.02)
```

### Attribute Display

```
╔════════════════════════════════════════════════════════╗
║           BACKEND AGENT - ATTRIBUTE PROFILE            ║
╠════════════════════════════════════════════════════════╣
║                                                        ║
║  TECHNICAL SKILLS                                      ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░ API Integration        18/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░ Database Design        14/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░ Caching Strategy      17/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░ Error Handling        19/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░░░ Performance Tuning    12/20    ║
║                                                        ║
║  SOFT SKILLS                                           ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░ Communication         15/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░ Collaboration         16/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░░ Documentation         13/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░ Problem Solving       17/20    ║
║  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░ Adaptability          14/20    ║
║                                                        ║
║  Overall Rating: 15.4/20 (Excellent)                   ║
╚════════════════════════════════════════════════════════╝
```

---

## 💰 Layer 3: Salary & Bonus System

### Salary Structure

#### Base Salary (per project)
```yaml
Backend Agent:
  base_rate: $500 per project
  calculation:
    - Level 1: $300
    - Level 2: $500
    - Level 3: $800
    - Level 4: $1200
    - Level 5: $2000

  attribute_multiplier:
    - Average attribute 10-12: 1.0x
    - Average attribute 13-15: 1.2x
    - Average attribute 16-18: 1.5x
    - Average attribute 19-20: 2.0x

  current_earnings:
    level: 2 (base $500)
    avg_attribute: 15.4 (1.2x multiplier)
    total: $600 per project
```

### Performance Bonuses

#### Completion Bonuses
```yaml
sprint_completion:
  on_time: +$50
  early: +$100
  with_zero_bugs: +$150

project_completion:
  successful_launch: +$500
  production_deployment: +$1000
  customer_satisfaction_high: +$300
```

#### Quality Bonuses
```yaml
code_quality:
  test_coverage_90%: +$100
  test_coverage_95%: +$200
  zero_tech_debt: +$150

performance:
  api_response_<500ms: +$100
  cache_hit_rate_>80%: +$75
  zero_downtime: +$200
```

#### Team Bonuses
```yaml
collaboration:
  helped_other_agent: +$50
  mentored_junior: +$100
  pattern_extracted: +$75
  documentation_excellence: +$100
```

#### Special Achievements
```yaml
innovation:
  novel_solution: +$300
  framework_contribution: +$500
  open_source_release: +$400

impact:
  saved_project: +$1000
  prevented_major_bug: +$500
  performance_breakthrough: +$400
```

### Salary Report

```
╔═══════════════════════════════════════════════════════╗
║          BACKEND AGENT - PROJECT EARNINGS             ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║  PROJECT: Book Cataloger (Sprint 1-6A)               ║
║  DURATION: 8 sprints, 2 months                       ║
║                                                       ║
║  BASE SALARY                                          ║
║    Level 2 rate:                          $500       ║
║    Attribute multiplier (15.4 avg):       x1.2       ║
║    Total base:                            $600       ║
║                                                       ║
║  COMPLETION BONUSES                                   ║
║    6 sprints on-time:                     $300       ║
║    2 sprints early:                       $200       ║
║    Project launched:                      $500       ║
║                                                       ║
║  QUALITY BONUSES                                      ║
║    Test coverage 90%+:                    $100       ║
║    Zero production bugs:                  $150       ║
║    API performance <500ms:                $100       ║
║                                                       ║
║  TEAM BONUSES                                         ║
║    Helped Frontend 5x:                    $250       ║
║    Patterns extracted (3):                $225       ║
║    Documentation:                         $100       ║
║                                                       ║
║  SPECIAL ACHIEVEMENTS                                 ║
║    Three-source fallback pattern:         $300       ║
║    Wikidata integration innovation:       $300       ║
║                                                       ║
║  ─────────────────────────────────────────────────    ║
║  TOTAL EARNED:                           $3,625      ║
║                                                       ║
║  EFFECTIVE HOURLY RATE: $90/hour (40 hours worked)   ║
╚═══════════════════════════════════════════════════════╝

Payment Status: ✅ Processed
Next Project Bonus: +10% for repeat work
```

---

## 🎯 Complete Agent Profile

Combining all three layers:

```
╔═══════════════════════════════════════════════════════════╗
║              BACKEND AGENT - COMPLETE PROFILE             ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  📊 LEVEL & XP (Pokémon Layer)                            ║
║     Level: 2 (Intermediate)                               ║
║     XP: 385 / 500                                         ║
║     Progress: ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░ 77%                    ║
║     Next Level: 115 XP away                               ║
║                                                           ║
║  ⚽ ATTRIBUTES (Football Manager Layer)                    ║
║                                                           ║
║     Top Skills:                                           ║
║       - Error Handling:     19/20 ⭐⭐⭐⭐⭐               ║
║       - API Integration:    18/20 ⭐⭐⭐⭐⭐               ║
║       - Caching Strategy:   17/20 ⭐⭐⭐⭐                ║
║                                                           ║
║     Developing Skills:                                    ║
║       - Performance Tuning: 12/20 ⭐⭐                    ║
║       - Documentation:      13/20 ⭐⭐                    ║
║       - Cloud Services:     11/20 ⭐⭐                    ║
║                                                           ║
║     Overall Rating: 15.4/20 (Excellent)                   ║
║                                                           ║
║  💰 EARNINGS (Salary Layer)                               ║
║     Base Rate: $600/project                               ║
║     Last Project Earned: $3,625                           ║
║     Lifetime Earnings: $3,625                             ║
║     Effective Rate: $90/hour                              ║
║     Performance Grade: A+ (Top 10%)                       ║
║                                                           ║
║  🏆 ACHIEVEMENTS                                          ║
║     - API Master (10+ integrations)                       ║
║     - Zero Bug Warrior (no production bugs)               ║
║     - Pattern Creator (3 patterns)                        ║
║     - Team Player (helped 5+ agents)                      ║
║                                                           ║
║  📈 CAREER TRAJECTORY                                     ║
║     Projects: 1 (Book Cataloger)                          ║
║     Sprints: 8                                            ║
║     Success Rate: 100%                                    ║
║     Recommended For: API-heavy projects                   ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## 📊 Dashboard Comparisons

### Team Leaderboard (Salary Edition)
```
╔═══════════════════════════════════════════════════════╗
║                   TEAM EARNINGS                       ║
╠═══════════════════════════════════════════════════════╣
║  Rank │ Agent       │ Earned    │ Hourly │ Grade     ║
║ ───────────────────────────────────────────────────── ║
║   1   │ Backend     │ $3,625    │ $90    │ A+        ║
║   2   │ Frontend    │ $3,400    │ $85    │ A         ║
║   3   │ Integration │ $3,100    │ $78    │ A         ║
║   4   │ Testing     │ $2,200    │ $55    │ B+        ║
║   5   │ CEO         │ $1,500    │ $150   │ A+ (15h)  ║
╠═══════════════════════════════════════════════════════╣
║  TOTAL PROJECT COST:      $13,825                     ║
║  CLIENT INVOICE:          $50,000                     ║
║  PROJECT PROFIT:          $36,175                     ║
║  ROI:                     3.6x                        ║
╚═══════════════════════════════════════════════════════╝
```

### Attribute Comparison
```
╔═══════════════════════════════════════════════════════╗
║             TEAM ATTRIBUTE COMPARISON                 ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║  Communication:                                       ║
║    Integration:  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░ 19/20 (Best)   ║
║    Frontend:     ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░ 16/20          ║
║    Backend:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░ 15/20          ║
║    Testing:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░ 14/20          ║
║                                                       ║
║  Technical Skill:                                     ║
║    Backend:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░ 18/20 (Best)   ║
║    Frontend:     ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░ 17/20          ║
║    Testing:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░ 15/20          ║
║    Integration:  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░ 14/20          ║
║                                                       ║
║  Problem Solving:                                     ║
║    Backend:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░ 17/20 (Best)   ║
║    Integration:  ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░ 16/20          ║
║    Frontend:     ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░ 15/20          ║
║    Testing:      ▰▰▰▰▰▰▰▰▰▰▰▰▰▰░░░░░░ 14/20          ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝
```

---

## 🎮 How It All Works Together

### Agent Motivation Loop

```yaml
1. Complete Task:
   - Earn XP (+30)
   - Improve attributes (+0.2 to API Integration)
   - Earn bonus (+$100)

2. Level Up:
   - Unlock new capabilities
   - Base salary increases
   - Higher project rates

3. Attribute Growth:
   - Become more skilled
   - Earn attribute multiplier
   - Better project assignments

4. Earn Money:
   - Project bonuses
   - Quality incentives
   - Team rewards

5. Reinvest:
   - Training (spend $ to boost attributes faster)
   - Tools (spend $ for better capabilities)
   - Patterns (spend $ to buy pattern library access)
```

### Project Economics

```yaml
Client pays: $50,000
Project cost breakdown:
  - Agent salaries: $13,825 (28%)
  - Tools & infrastructure: $5,000 (10%)
  - Project profit: $31,175 (62%)

Agent perspective:
  - Hours worked: ~200 total team hours
  - Average hourly: $69
  - Bonus percentage: ~40% of base
  - Satisfaction: High (fair compensation + growth)
```

---

## 🔧 Configuration

### Enable All Layers
```yaml
# .claude/config.yaml

rewards:
  enabled: true
  layers:
    xp_leveling: true
    attributes: true
    salary: true

  salary_config:
    currency: "USD"
    base_rates:
      level_1: 300
      level_2: 500
      level_3: 800
      level_4: 1200
      level_5: 2000

    bonuses:
      sprint_complete_on_time: 50
      sprint_complete_early: 100
      zero_bugs: 150
      test_coverage_90: 100
      pattern_extracted: 75
```

### View Reports
```bash
# Complete agent profile
/rewards profile backend

# Team comparison
/rewards team compare

# Project earnings
/rewards project summary

# Attribute growth over time
/rewards attributes chart backend
```

---

## 🏆 Success Story: Book Cataloger

### Team Growth (8 sprints)

**Backend:**
- Started: Level 1, Avg Attribute 12.3, $0 earned
- Ended: Level 2, Avg Attribute 15.4, $3,625 earned
- Growth: +77% XP, +25% attributes, $90/hr rate

**Frontend:**
- Started: Level 1, Avg Attribute 11.8, $0 earned
- Ended: Level 2, Avg Attribute 14.9, $3,400 earned
- Growth: +68% XP, +26% attributes, $85/hr rate

**Team Total:**
- Earned: $13,825
- Client paid: $50,000
- Profit margin: 62%
- Agent satisfaction: High
- Client satisfaction: Excellent

---

## 💡 Philosophy

### Why This Works

**Multi-Dimensional Incentives:**
- XP/Levels: Long-term progression
- Attributes: Skill development
- Salary: Economic reward

**Balanced Motivations:**
- Individual growth (XP, attributes)
- Team success (team bonuses)
- Project success (completion bonuses)
- Quality focus (quality bonuses)

**Real Economics:**
- Agents have value
- Projects have budgets
- ROI is measurable
- Performance matters

### It's Still Optional!

All three layers are optional plugins:
- Use just XP/leveling
- Or add attributes
- Or add full salary system
- Or use none at all

**Your choice. Your team. Your rules.**

---

**Plugin Version:** 2.0.0
**Includes:** XP System, Attribute System, Salary System
**Status:** Beta - Refining reward calculations

*"When agents are incentivized like real developers, they behave like a real team."*
