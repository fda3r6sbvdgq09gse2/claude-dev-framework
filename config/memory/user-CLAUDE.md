# Personal Claude Instructions
*Template for ~/.claude/CLAUDE.md*

---

## 🎯 About Me

**Developer**: [Your Name]
**Organization**: [Your Org or "Solo Developer"]
**Primary Stack**: [Your tech stack, e.g., "Python, React, PostgreSQL"]
**Editor**: [VS Code / Cursor / Other]

---

## 🤖 Framework

Using **claude-multi-agent-framework** with persistent AI agents.

**Active Agents**:
- 🤖 Backend (APIs, data, services)
- 🎨 Frontend (UI/UX, interactions)
- 🔗 Integration (Business logic, coordination)
- ✅ Testing (Quality assurance)
- 👑 CEO (Strategic planning, architecture)
- 📚 Documentation (Docs, guides, READMEs)
- ⚙️  DevOps (Infrastructure, monitoring, CI/CD)
- 🧪 QA Automation (Playwright, UI testing)
- 👤 UX/Product (User feedback, research)

---

## 💻 Code Style Preferences

### General
- **Language**: [Preferred language for new files]
- **Formatting**: [Black / Prettier / Your formatter]
- **Line Length**: [80 / 100 / 120 characters]
- **Imports**: [Absolute / Relative preference]

### Python Specific
```python
# Your preferences:
- Type hints: Always / Optional / Rarely
- Docstrings: Google / NumPy / reStructuredText style
- Testing: pytest / unittest
- Async: Use where appropriate / Avoid unless necessary
```

### JavaScript/TypeScript Specific
```javascript
// Your preferences:
- TypeScript for all new files: Yes / No
- Component style: Functional / Class
- State management: [Redux / Zustand / Context / Other]
- Import style: Named exports preferred
```

---

## 🔧 Workflow Preferences

### Before Starting Work
- [ ] Check `/context` - context usage status
- [ ] Review `.ai/context/current_task.md`
- [ ] Load only essential patterns

### During Work
- [ ] Update progress in real-time
- [ ] Check `/context` every 30 minutes
- [ ] Document decisions as you go

### Before Finishing
- [ ] Update `.ai/context/current_task.md`
- [ ] Run tests
- [ ] Commit with descriptive message
- [ ] Clear context if > 60%

---

## 🎯 Context Management

**My Strategy**:
- Load patterns **selectively** (one at a time)
- Use `@imports` instead of reading full files
- Clear context at **60%** utilization
- Shutdown and restart at **80%**

**Memory Optimization**:
- Keep CLAUDE.md **under 10,000 tokens**
- Use imports for large docs
- Reference, don't paste

---

## 💰 Cost Management

**My Budget**: $[amount]/month

**Strategy**:
- **90% Sonnet** for implementation
- **10% Opus** for strategic planning (Plan Mode only)
- Monitor costs via status line
- Alert at 80% of budget

**Opus Usage**:
```bash
# Use Plan Mode for strategy
claude --permission-mode plan --model opus-4

# Never use Opus for implementation
```

---

## 🚨 Important Rules

### Always
- ✅ Ask before destructive operations (delete, force push)
- ✅ Explain complex code changes
- ✅ Run tests before committing
- ✅ Use descriptive commit messages
- ✅ Document architectural decisions
- ✅ Check for hardcoded values (use VARIABLES.yaml)

### Never
- ❌ Commit secrets or API keys
- ❌ Skip tests
- ❌ Use hardcoded values
- ❌ Force push to main/master
- ❌ Delete files without asking
- ❌ Ignore context warnings

---

## 🎨 Communication Style

**I prefer**:
- [Concise / Detailed] explanations
- [Yes / No] to code comments in responses
- [Yes / No] to implementation summaries
- [Ask first / Just do it] for file operations

---

## 🛠️ Tools & Environment

**Terminal**: [iTerm2 / Terminal / Other]
**Shell**: [zsh / bash / fish]
**Package Manager**: [Homebrew / apt / Other]

**Commonly Used Commands**:
```bash
# Add your frequent commands here
pytest -v
npm run dev
docker-compose up -d
```

---

## 📚 Import Framework Docs

**Essential References** (loaded on-demand):
```
@~/.claude/agents/backend.md
@~/.claude/agents/frontend.md
@~/.claude/agents/ceo.md
```

**Framework Docs** (reference when needed):
```
@~/dev/claude-dev-framework/docs/CONFIGURATION_ARCHITECTURE.md
@~/dev/claude-dev-framework/docs/CONTEXT_OPTIMIZATION.md
@~/dev/claude-dev-framework/docs/SINGLE_SOURCE_OF_TRUTH.md
```

---

## 🔗 Links & Resources

**Framework Repository**: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework

**Documentation**:
- Configuration: `~/dev/claude-dev-framework/docs/`
- Templates: `~/dev/claude-dev-framework/config/templates/`

---

## 📝 Notes

[Add any personal notes, preferences, or reminders here]

---

**Version**: 1.0.0
**Last Updated**: [Date]
**Review**: Update quarterly or when preferences change
