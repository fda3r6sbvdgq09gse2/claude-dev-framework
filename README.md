# Claude Code Development Framework
*AI-Assisted Multi-Agent Software Development*

## 🎯 What This Is

A production-ready framework for building software with Claude Code using specialized AI workers. Extracted from real-world development of the [book-cataloger](https://github.com/YOUR-USERNAME/book-cataloger) project (Sprint 1-6A).

## 🏀 Core Concept: The Championship Team

Like the 1990s Chicago Bulls, this framework orchestrates specialized roles:

- **CEO (Opus)**: Strategic vision and architecture (Michael Jordan)
- **CEO Lite (Sonnet)**: Tactical coordination (Scottie Pippen)
- **Backend Worker (Sonnet)**: API, data, services
- **Frontend Worker (Sonnet)**: UI, UX, interactions
- **Integration Worker (Sonnet)**: Business logic, workflows
- **Testing Worker (Sonnet)**: Quality assurance

## ✨ Key Innovations

1. **Model-Aware Architecture**: Optimal Claude model selection (Opus/Sonnet/Haiku)
2. **Persistent Worker Profiles**: Workers level up across sessions
3. **Git Worktrees for Parallelism**: Multiple workers code simultaneously
4. **Pattern Library**: Reusable solutions extracted from real development
5. **Slash Command System**: Quick role transformations

## 🚀 Quick Start

```bash
# Clone the framework
git clone https://github.com/YOUR-USERNAME/claude-dev-framework.git
cd claude-dev-framework

# Set up worker profiles
cp -r worker-profiles/.claude-workers ~/

# Copy slash commands to your project
cp -r .claude/commands your-project/.claude/

# Copy AI templates
cp -r templates your-project/.ai/templates/

# Start developing
cd your-project
claude
```

## 📚 Documentation

- [Super Brain Vision](docs/vision/SUPER_BRAIN_VISION_001.md) - The 10-year framework vision
- [Model-Aware Framework](docs/guides/MODEL_AWARE_FRAMEWORK.md) - Optimal model usage
- [Model Capabilities Registry](docs/MODEL_CAPABILITIES_REGISTRY.md) - Model comparison
- [Worker Architecture](docs/guides/PERSISTENT_WORKER_FRAMEWORK.md) - How workers operate
- [Pattern System](docs/guides/PATTERN_PROMOTION_SYSTEM.md) - Reusable patterns

## 🎮 Usage

### Activate a Worker Role

```bash
# In Claude Code
/role-ceo          # Strategic planning
/role-backend      # Backend development
/role-frontend     # UI development
/role-integration  # System integration
/role-testing      # Quality assurance
```

### Set Up Parallel Development

```bash
# Create worktrees for each worker
git worktree add ../project-backend -b feature/backend
git worktree add ../project-frontend -b feature/frontend
git worktree add ../project-integration -b feature/integration
git worktree add ../project-testing -b feature/testing
```

### Run Multiple Workers Simultaneously

Open 4 terminal windows, one for each worktree, and run Claude Code in each.

## 📊 Framework Metrics (from book-cataloger)

- **Sprints Completed**: 6A (8 weeks)
- **Patterns Extracted**: 23+
- **Worker Levels**: Backend L2, Frontend L2, Integration L2, Testing L1
- **Token Efficiency**: 80% savings vs single-model approach
- **Development Speed**: 4x with parallel workers

## 🏗️ Proven Use Cases

- ✅ Book cataloging application (8 sprints)
- ✅ Python/Tkinter desktop apps
- ✅ API integration systems
- ✅ Multi-agent development workflows

## 🤝 Contributing

This framework evolves with real-world use. Contributions welcome:

- New patterns discovered
- Worker role improvements
- Model capability updates
- Template enhancements

## 📝 License

MIT - Use freely in your projects

## 🙏 Credits

Built during the book-cataloger project by leveraging Claude Code's capabilities in a structured, scalable way.

---

*"We're not just building apps. We're building the framework that helps thousands of developers work with AI."*
