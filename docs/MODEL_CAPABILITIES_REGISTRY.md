# Model Capabilities Registry
*Single Source of Truth for Model Characteristics*
*Last Updated: 2025-10-12*

## 🎯 Purpose

This registry is the SINGLE SOURCE OF TRUTH for model capabilities across the framework.
- When models change, update ONLY this file
- All profiles reference this registry
- No hardcoded model names in worker files
- Model-agnostic framework design

## 📊 Active Models

### Production Models (Book Cataloger v1.0)

#### MODEL_001: Claude Opus 4.1
```yaml
id: claude-opus-4-1-20250805
provider: Anthropic
tier: flagship
released: 2025-08-05
context_window: 200k
cost_tier: premium
availability: 24-40 hrs/week

capabilities:
  reasoning: ⭐⭐⭐⭐⭐
  creativity: ⭐⭐⭐⭐⭐
  speed: ⭐⭐⭐
  reliability: ⭐⭐⭐⭐
  pattern_extraction: ⭐⭐⭐⭐⭐

ideal_for:
  - Strategic architecture
  - Complex trade-offs
  - Pattern extraction
  - Framework design
  - Visionary planning

not_ideal_for:
  - High-volume tasks
  - Simple implementations
  - Repetitive work

worker_assignments:
  primary: [CEO, Brain]
  fallback: [Super Saiyan mode for any worker]

basketball_analogy: "Michael Jordan - The GOAT"
```

#### MODEL_002: Claude Sonnet 3.5
```yaml
id: claude-3-5-sonnet-20241022
provider: Anthropic
tier: performance
released: 2024-10-22
context_window: 200k
cost_tier: standard
availability: 240-480 hrs/week

capabilities:
  reasoning: ⭐⭐⭐⭐
  creativity: ⭐⭐⭐⭐
  speed: ⭐⭐⭐⭐⭐
  reliability: ⭐⭐⭐⭐⭐
  implementation: ⭐⭐⭐⭐⭐

ideal_for:
  - Implementation code
  - Bug fixes
  - Testing
  - Refactoring
  - Documentation

not_ideal_for:
  - Visionary architecture
  - Complex pattern extraction

worker_assignments:
  primary: [Backend, Frontend, Integration, Testing]
  fallback: [CEO_Lite, Brain_Lite]

basketball_analogy: "Scottie Pippen - Hall of Famer"
```

#### MODEL_003: Claude Haiku 3.5
```yaml
id: claude-3-5-haiku-20241022
provider: Anthropic
tier: efficiency
released: 2024-10-22
context_window: 200k
cost_tier: economy
availability: unlimited

capabilities:
  reasoning: ⭐⭐⭐
  creativity: ⭐⭐⭐
  speed: ⭐⭐⭐⭐⭐
  reliability: ⭐⭐⭐⭐
  simple_tasks: ⭐⭐⭐⭐⭐

ideal_for:
  - Simple refactoring
  - Code formatting
  - Basic tests
  - Documentation updates
  - Repetitive tasks

not_ideal_for:
  - Architecture decisions
  - Complex debugging
  - Pattern extraction

worker_assignments:
  primary: [None currently]
  fallback: [Testing for simple tests]

basketball_analogy: "Dennis Rodman - Specialist"
```

## 🚀 Future Models (Placeholder)

### MODEL_004: GPT-4o
```yaml
id: gpt-4o-2024-08-06
provider: OpenAI
tier: flagship
status: not_integrated
potential_use: Cross-validation of complex decisions
```

### MODEL_005: Gemini 2.0 Flash
```yaml
id: gemini-2.0-flash
provider: Google
tier: performance
status: not_integrated
potential_use: Alternative implementation approach
```

## 📈 Model Evolution History

### Version 1.0 (Book Cataloger)
```yaml
period: 2024-12 to 2025-01
models_used:
  - claude-opus-4-1: CEO, Brain roles
  - claude-3-5-sonnet: All workers
  - claude-3-5-haiku: Experimentation only

learnings:
  - Opus excels at architecture but limited availability
  - Sonnet perfect for implementation work
  - Haiku too limited for complex tasks
  - Model + Role combination is key
```

## 🔄 Dynamic Reference System

### How to Reference Models

**DON'T DO THIS:**
```python
model = "claude-opus-4-1"  # Hardcoded!
```

**DO THIS:**
```python
from ai.model_registry import get_model
model = get_model("flagship")  # or get_model_for_role("CEO")
```

### In Worker Profiles

**Reference by tier, not name:**
```markdown
## Model Configuration
Current: MODEL_001 (see MODEL_CAPABILITIES_REGISTRY.md)
Fallback: MODEL_002
```

## 🎯 Model Selection Matrix

| Role | Primary Model | Fallback Model | Minimum Model |
|------|--------------|----------------|---------------|
| CEO | MODEL_001 (Opus) | MODEL_002 (Sonnet) | MODEL_002 |
| Brain | MODEL_001 (Opus) | MODEL_002 (Sonnet) | MODEL_002 |
| Backend | MODEL_002 (Sonnet) | MODEL_003 (Haiku) | MODEL_003 |
| Frontend | MODEL_002 (Sonnet) | MODEL_003 (Haiku) | MODEL_003 |
| Integration | MODEL_002 (Sonnet) | MODEL_003 (Haiku) | MODEL_003 |
| Testing | MODEL_002 (Sonnet) | MODEL_003 (Haiku) | MODEL_003 |

## 🔬 Model Testing Protocol

Before adopting a new model:
1. Run standardized tests (see MODEL_HEALTH_CHECK.md)
2. Compare against current models
3. Document strengths/weaknesses
4. Update this registry
5. Test with one worker role first
6. Roll out if successful

## 📝 Model Capability Dimensions

When evaluating any model (Claude, GPT, Gemini, etc):

1. **Reasoning**: Complex problem solving
2. **Creativity**: Novel solutions
3. **Speed**: Response time
4. **Reliability**: Consistency
5. **Context**: Window size
6. **Cost**: Per token pricing
7. **Availability**: Usage limits
8. **Specialization**: Unique strengths

## 🚨 Update Protocol

When models change:
1. Update ONLY this file
2. Run: `./scripts/propagate_model_changes.sh`
3. This updates all references automatically
4. Commit with message: "MODEL_UPDATE: [description]"

## 🎭 Model Signatures in Output

Each model/role combination should identify itself:
```
[ROLE-MODEL]: Output here...

Examples:
[CEO-OPUS]: Strategic vision...
[BACKEND-SONNET]: Implementation code...
[TESTING-HAIKU]: Simple test...
```

## 🔮 Framework Vision

This registry enables:
- Model-agnostic worker profiles
- Easy model upgrades
- Cross-provider support (Claude → GPT → Gemini)
- Historical tracking
- Performance comparison
- Optimal model/role matching

---

**Remember:** This is the SINGLE SOURCE OF TRUTH for model capabilities.
All model-specific information lives here and here alone.