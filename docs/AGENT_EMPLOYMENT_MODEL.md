# Agent Employment Model
*Full-Time Company Agents vs Project Contractors*
*Version: 1.0.0*

## 🏢 The Startup Analogy

Think of your AI development team as a startup company:
- **Full-time employees** work on all projects, grow with experience
- **Project contractors** are brought in for specific expertise
- **Company culture** (patterns, standards) persists across projects
- **Institutional memory** accumulates over time

---

## 👥 Full-Time Company Agents

### Definition
Permanent team members who work on ALL your projects and accumulate expertise over time.

### Location
```bash
~/.claude/agents/           # Global agent directory
├── backend.md             # Full-time backend specialist
├── frontend.md            # Full-time frontend specialist
├── integration.md         # Full-time integration specialist
├── testing.md             # Full-time testing specialist
└── ceo.md                 # Full-time strategic architect
```

### Installation
```bash
# Install from marketplace (one-time setup)
/plugin marketplace add fda3r6sbvdgq09gse2/claude-dev-framework
/plugin install backend-agent@claude-multi-agent-framework
/plugin install frontend-agent@claude-multi-agent-framework
/plugin install integration-agent@claude-multi-agent-framework
/plugin install testing-agent@claude-multi-agent-framework
/plugin install ceo-agent@claude-multi-agent-framework
```

### Characteristics

#### 1. Cross-Project Memory
```yaml
projects_worked:
  - book-cataloger: "API integration, export formats"
  - web-scraper: "Async fetching, rate limiting"
  - data-pipeline: "ETL workflows, validation"
```

Each project adds to their experience.

#### 2. Leveling System
```yaml
Backend Agent:
  level: 2
  xp: 320/500
  xp_sources:
    book-cataloger: +150 XP
    web-scraper: +120 XP
    data-pipeline: +50 XP
```

Agents get stronger with every project.

#### 3. Pattern Library
```yaml
patterns_mastered:
  - three-source-api-fallback (book-cataloger Sprint 3)
  - rate-limiting-queue (web-scraper Sprint 1)
  - database-migration-strategy (data-pipeline Sprint 2)
```

Reusable solutions grow over time.

#### 4. Company Culture
```yaml
standards:
  - test_coverage: 85%
  - error_handling: mandatory
  - documentation: comprehensive
  - code_style: black + mypy
```

Consistent quality across all projects.

### Benefits
✅ **Compound Learning**: Each project makes them smarter
✅ **Instant Context**: They know your coding style
✅ **Pattern Reuse**: Solutions from Project A work in Project B
✅ **Quality Consistency**: Same standards everywhere
✅ **Cost Efficiency**: Sonnet-powered with Opus escalation

---

## 🔧 Project-Specific Contractor Agents

### Definition
Temporary specialists brought in for project-specific needs.

### Location
```bash
your-project/
└── .claude/agents/         # Project-local agents
    ├── payment-processor.md    # Stripe/payment specialist
    ├── ml-pipeline.md         # ML model training
    └── pdf-generator.md       # Document generation
```

### Creation
```bash
# Create project-specific agent
cat > .claude/agents/payment-processor.md << 'EOF'
---
name: payment-processor
description: Specialist in payment gateway integration and PCI compliance
tools: Read, Write, Edit, Bash
model: sonnet
---

You are a payment processing specialist...
EOF
```

### Characteristics

#### 1. Domain Expertise
Focused on narrow, project-specific needs:
- Payment processing
- ML model training
- PDF generation
- Video transcoding
- Blockchain integration

#### 2. No Persistence
Don't carry over to other projects:
```
Project A: payment-processor.md
Project B: [payment-processor doesn't exist here]
```

#### 3. Complementary to Full-Timers
Work alongside company agents:
```yaml
task: "Add Stripe payment to checkout"
agents:
  - frontend (company): Build payment UI
  - payment-processor (contractor): Integrate Stripe API
  - testing (company): Validate transactions
```

### When to Use Contractors

✅ **Use Contractor When:**
- Specialized domain knowledge needed
- One-off integration
- Project-specific regulations
- Temporary spike in complexity

❌ **Don't Use Contractor When:**
- Standard CRUD operations
- UI/UX work
- Testing
- API integration (unless highly specialized)

These are what full-time agents do!

---

## 🎯 Agent Priority System

When Claude Code needs to select an agent:

### Priority Order
1. **Project contractors** (`.claude/agents/`) - Highest priority
2. **Company agents** (`~/.claude/agents/`) - Second priority
3. **Marketplace agents** (remote) - Lowest priority

### Example Scenario
```yaml
Task: "Implement payment processing with Stripe"

Available Agents:
  - .claude/agents/payment-processor.md (Project contractor)
  - ~/.claude/agents/backend.md (Company agent)

Selected: payment-processor (Project-specific expertise wins)
```

```yaml
Task: "Add API error handling"

Available Agents:
  - ~/.claude/agents/backend.md (Company agent)

Selected: backend (Standard backend work)
```

---

## 📊 The Full Workflow

### Project Start
1. **Company agents** assess project
2. **CEO agent** creates architecture
3. **Team identifies** if contractors needed

### During Development
```yaml
Sprint 1:
  - Backend (company): Core API
  - Frontend (company): Basic UI
  - payment-processor (contractor): Stripe integration

Sprint 2:
  - Integration (company): Workflow coordination
  - Testing (company): End-to-end tests
  - pdf-generator (contractor): Invoice PDFs
```

### Project End
```yaml
Company agents:
  - XP earned: +150 each
  - Patterns extracted: 5 new patterns
  - Level ups: Backend → Level 3

Contractors:
  - Completed work
  - No persistence
  - Can be archived for future reference
```

---

## 💰 Economic Model

### Cost Structure
```yaml
Full-Time Agents:
  - One-time install: Free (from marketplace)
  - Usage cost: Sonnet tokens (~$10/hour equivalent)
  - Opus escalation: When needed (~$50/hour)
  - ROI: 4-10x due to reuse

Project Contractors:
  - Creation cost: 15 minutes
  - Usage cost: Sonnet tokens
  - Disposal: Delete when done
  - ROI: 2-3x for specialized tasks
```

### When to Invest in Full-Timer
Create a new full-time agent when:
- Used in 3+ projects
- Clear reusable patterns emerge
- Expertise valuable long-term
- Maintenance cost justified

---

## 🏆 Success Stories

### Book Cataloger (Sprint 1-6A)
```yaml
Full-Time Team:
  - Backend: API integration, 3-source fallback
  - Frontend: PyQt6 UI, multilingual support
  - Integration: ISBN workflow coordination
  - Testing: 87% coverage, validation

Contractors:
  - None needed (general-purpose project)

Result:
  - 6 sprints completed
  - 23 patterns extracted
  - All agents leveled up
```

### Future Project: E-commerce Platform
```yaml
Full-Time Team:
  - Backend: Product API, inventory
  - Frontend: Shopping UI, checkout
  - Integration: Order workflow
  - Testing: Payment validation

Contractors:
  - payment-processor: Stripe integration
  - email-marketing: Mailchimp integration
  - analytics: Google Analytics setup

Result:
  - Company agents reuse patterns
  - Contractors handle specialized tasks
  - Fast development with quality
```

---

## 📝 Best Practices

### For Full-Time Agents
1. **Hire Early**: Install core team before first project
2. **Track Growth**: Monitor XP and patterns
3. **Review Regularly**: Update skills quarterly
4. **Extract Patterns**: Document learnings
5. **Maintain Standards**: Consistent quality

### For Contractors
1. **Hire Strategically**: Only when needed
2. **Clear Scope**: Define exact responsibilities
3. **Time-Bound**: Set expected duration
4. **Knowledge Transfer**: Extract patterns before departure
5. **Archive**: Keep for reference

### Company Culture
1. **Weekly Standups**: Review agent progress
2. **Pattern Reviews**: Extract reusable solutions
3. **Performance Metrics**: Track XP, coverage, speed
4. **Continuous Learning**: Agents evolve with usage
5. **Team Coordination**: Clear boundaries and communication

---

## 🚀 Getting Started

### Step 1: Hire Your Core Team
```bash
# Install marketplace
/plugin marketplace add fda3r6sbvdgq09gse2/claude-dev-framework

# Hire full-time agents
/plugin install backend-agent@claude-multi-agent-framework
/plugin install frontend-agent@claude-multi-agent-framework
/plugin install integration-agent@claude-multi-agent-framework
/plugin install testing-agent@claude-multi-agent-framework
/plugin install ceo-agent@claude-multi-agent-framework
```

### Step 2: Start Your First Project
```bash
cd your-project
claude

# CEO plans the architecture
/role-ceo
```

### Step 3: Add Contractors If Needed
```bash
# Create project-specific agent
echo "---
name: domain-specialist
description: Expert in X domain
---
Your specialized instructions..." > .claude/agents/domain-specialist.md
```

### Step 4: Develop in Parallel
```bash
# Backend worker
cd ~/dev/your-project-worktrees/backend
claude

# Frontend worker
cd ~/dev/your-project-worktrees/frontend
claude
```

---

## 🎯 The Vision

**Year 1:**
- Core team installed
- 5 projects completed
- 50+ patterns extracted
- All agents at Level 3+

**Year 2:**
- Advanced patterns library
- Specialized full-time agents (DevOps, Security)
- 20+ projects completed
- Framework becomes self-improving

**The Goal:**
> Build a permanent AI development team that gets smarter with every project, accumulating expertise and patterns that make each new project faster and better than the last.

---

**Remember:**
- Full-time agents = Long-term investment, compound growth
- Contractors = Short-term specialists, task-focused
- Together = Complete, flexible development team

*"The best teams aren't assembled for each project. They grow together across projects."*
