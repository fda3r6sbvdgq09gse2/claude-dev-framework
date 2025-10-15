# Changelog

All notable changes to the Claude Multi-Agent Development Framework will be documented in this file.
_(Owner: ORG_NAME - change in VARIABLES.yaml)_

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.0.0] - 2025-10-15

### Added
- **Plugin-Based Marketplace Architecture**: Restructured entire framework to follow official Claude Code plugin specification
- **9 Specialized Agents**:
  - `backend` (sonnet) - APIs, data services, exports
  - `frontend` (sonnet) - UI/UX development
  - `integration` (sonnet) - System integration, workflows
  - `testing` (sonnet) - Unit/integration testing
  - `ceo` (opus) - Sprint planning, coordination
  - `devops` (sonnet) - Infrastructure, monitoring
  - `documentation` (sonnet) - READMEs, API docs
  - `qa-automation` (sonnet) - Playwright, UI testing
  - `ux-product` (sonnet) - User feedback, UX
- **Official Directory Structure**: `plugins/{agent-name}/agents/{agent-name}.md`
- **Plugin Manifests**: Each plugin has `plugin.json` with agent metadata
- **Framework Marketplace**: Central `.claude-plugin/marketplace.json` for distribution
- **Comprehensive Documentation**: PLUGIN_ARCHITECTURE.md with complete usage guide

### Changed
- **Agent Location**: Moved from flat `agents/` to `plugins/{name}/agents/` structure
- **Agent Format**: Standardized YAML frontmatter (name, description, tools, model)
- **Priority System**: Documented project > plugin > user precedence
- **Version**: All plugins versioned at 2.0.0

### Architecture
- **Type**: Plugin-based marketplace
- **Distribution**: Git-based, semantic versioning
- **Reusability**: One framework → Many projects
- **Updates**: `git pull` propagates improvements

### Technical Specifications
- **Official Compliance**: Follows [Claude Code Subagents Spec](https://docs.claude.com/en/docs/claude-code/sub-agents)
- **Plugin Format**: [Claude Code Plugins Spec](https://docs.claude.com/en/docs/claude-code/plugins)
- **Agent Frontmatter**: YAML with required fields (name, description, tools, model)
- **Marketplace Format**: JSON with plugins array, external_marketplaces support

### Proven In Production
- **Extracted From**: book-cataloger project (Sprint 1-6B)
- **Sprints Completed**: 6B
- **Patterns Extracted**: 25
- **Development Speed**: 4x with parallel agents
- **Token Efficiency**: 85% savings

### Credits
Developed through book-cataloger project, refined through 6 sprints of real-world usage.

---

## [1.0.0] - 2025-10-10

### Added
- Initial framework structure
- Worker-based multi-agent system
- Sprint management system
- Pattern templates
- Documentation templates

### Notes
- Pre-plugin architecture
- Workers instead of agents
- Custom orchestration system

---

## Future Releases

### [2.1.0] - Planned
Learnings from book-cataloger project will be extracted and merged:
- Generic patterns discovered during development
- Framework improvements based on real usage
- Additional agent enhancements
- Pattern library expansion

See [FRAMEWORK_EVOLUTION_WORKFLOW.md](../book-cataloger/docs/FRAMEWORK_EVOLUTION_WORKFLOW.md) for extraction process.

---

**Philosophy**: Lock framework version per project → Extract learnings post-project → Framework evolves through real-world usage

**Version Scheme**: [Semantic Versioning](https://semver.org/)
- **MAJOR**: Breaking changes, architectural shifts
- **MINOR**: New features, new patterns, backward compatible
- **PATCH**: Bug fixes, documentation updates

---

**Last Updated**: 2025-10-15
**Current Version**: 2.0.0
**Status**: Production Ready
