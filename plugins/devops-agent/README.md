# DevOps Agent Plugin
*Infrastructure, Monitoring, and Operational Excellence*

## 🎯 Overview

The DevOps agent is your infrastructure and operational excellence specialist. It handles monitoring, CI/CD, configuration management, cost optimization, and ensures the claude-multi-agent-framework runs smoothly across all environments.

---

## ✨ What This Agent Does

### Core Responsibilities

1. **Monitoring & Observability**
   - Set up OpenTelemetry, Prometheus, Grafana
   - Track token usage and costs
   - Monitor context window utilization
   - Create performance dashboards

2. **Infrastructure Management**
   - Manage development environments
   - Configure Docker & Docker Compose
   - Ensure system consistency
   - Handle dependencies

3. **CI/CD & Automation**
   - GitHub Actions workflows
   - Automated testing pipelines
   - Release automation
   - Version management

4. **Configuration Management**
   - Validate settings.json files
   - Maintain VARIABLES.yaml
   - Manage agent permissions
   - Check configuration integrity

5. **Operational Documentation**
   - Setup guides
   - Troubleshooting runbooks
   - Configuration references
   - System architecture docs

6. **Cost Optimization**
   - Monitor token consumption
   - Track API costs
   - Identify savings opportunities
   - Generate cost reports

7. **System Health & Reliability**
   - Framework health checks
   - Performance optimization
   - Error detection
   - Diagnostic tools

8. **Incident Response**
   - Debug framework issues
   - Root cause analysis
   - Service restoration
   - Post-mortem documentation

---

## 📦 Installation

### Option 1: Via Plugin Marketplace

```bash
# Install from marketplace
/plugin install devops-agent@claude-multi-agent-framework

# Activate when needed
/role-devops
```

### Option 2: Manual Installation

```bash
# Copy to your agents directory
cp plugins/devops-agent/agent.md ~/.claude/agents/devops.md

# Use in any project
claude
> "Act as DevOps agent and set up monitoring"
```

---

## 🚀 Quick Start

### Set Up Monitoring Stack

```bash
# Activate DevOps agent
/role-devops

# Ask to set up monitoring
> "Set up the monitoring stack with Prometheus and Grafana"

# Agent will:
1. Create docker-compose.yml
2. Configure Prometheus
3. Set up Grafana dashboards
4. Configure OpenTelemetry
5. Test the setup
```

### Validate Project Configuration

```bash
/role-devops

> "Validate the project configuration for the framework"

# Agent checks:
- settings.json validity
- VARIABLES.yaml consistency
- Agent permissions
- No hardcoded values
- Secrets not in git
```

### Optimize Context Usage

```bash
/role-devops

> "Analyze context usage and suggest optimizations"

# Agent provides:
- Current context utilization
- Recommendations for optimization
- Files to load selectively
- Pattern loading strategy
```

### Generate Cost Report

```bash
/role-devops

> "Generate a cost report for the last month"

# Agent produces:
- Total spend
- Breakdown by agent
- Breakdown by project
- Cost per feature
- Optimization suggestions
```

---

## 🛠️ Use Cases

### Scenario 1: New Project Setup

```bash
/role-devops

> "I'm starting a new project. Set up the framework configuration."

# Agent will:
1. Create .claude/settings.json
2. Create CLAUDE.md
3. Set up monitoring
4. Configure CI/CD
5. Create .gitignore
6. Validate setup
```

### Scenario 2: Budget Alert

```bash
/role-devops

> "We're approaching our monthly budget. Help optimize costs."

# Agent will:
1. Analyze token usage patterns
2. Identify inefficiencies
3. Suggest context optimizations
4. Recommend Opus vs Sonnet allocation
5. Implement monitoring alerts
```

### Scenario 3: Performance Issues

```bash
/role-devops

> "Claude is running slow. Diagnose the issue."

# Agent checks:
1. Context window utilization
2. API response times
3. Configuration issues
4. System resources
5. Provides fix recommendations
```

### Scenario 4: CI/CD Pipeline

```bash
/role-devops

> "Create a GitHub Actions pipeline for automated testing"

# Agent creates:
1. .github/workflows/test.yml
2. Automated pytest runs
3. Code coverage reporting
4. PR checks
5. Deployment workflow
```

---

## 📊 What Gets Monitored

### Token Usage Metrics
```
claude_tokens_input_total
claude_tokens_output_total
claude_tokens_total
claude_context_usage_percent
```

### Cost Metrics
```
claude_api_cost_usd_total
cost_per_agent
cost_per_project
cost_per_feature
```

### Performance Metrics
```
claude_session_duration_seconds
claude_agent_efficiency_score
claude_features_delivered_total
claude_bugs_introduced_total
```

### System Health
```
settings_validation_status
agent_configuration_valid
monitoring_stack_status
context_optimization_level
```

---

## 🔧 Configuration

### Agent Settings

Add to your `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "devops-agent@claude-multi-agent-framework": true
  },
  "devops": {
    "monitoring": {
      "enabled": true,
      "auto_start": false
    },
    "cost_tracking": {
      "enabled": true,
      "budget_alert_threshold": 0.8
    },
    "context_optimization": {
      "enable_warnings": true,
      "threshold": 0.8
    }
  }
}
```

---

## 📚 Documentation Maintained

The DevOps agent maintains these operational documents:

- `docs/CONFIGURATION_ARCHITECTURE.md` - Where settings go
- `docs/CONTEXT_OPTIMIZATION.md` - Context management strategies
- `docs/TROUBLESHOOTING.md` - Common issues and fixes
- `docs/INSTALLATION.md` - Setup procedures
- `monitoring/setup/README.md` - Monitoring stack guide
- `monitoring/MONITORING_SYSTEM.md` - Monitoring architecture
- `monitoring/PERFORMANCE_ACCOUNTABILITY.md` - Performance tracking

**Note**: Product documentation (README, API docs, user guides) is maintained by the Documentation agent.

---

## 🎯 When to Use This Agent

Use the DevOps agent when you need to:

- ✅ Set up monitoring and observability
- ✅ Configure development environment
- ✅ Create CI/CD pipelines
- ✅ Validate framework configuration
- ✅ Optimize context usage and costs
- ✅ Debug infrastructure issues
- ✅ Write operational documentation
- ✅ Generate performance reports
- ✅ Implement health checks
- ✅ Manage secrets and security

Don't use for:

- ❌ Writing application code (use Backend/Frontend agents)
- ❌ Creating user documentation (use Documentation agent)
- ❌ Writing tests (use Testing agent)
- ❌ Strategic planning (use CEO agent)

---

## 🤝 Agent Collaboration

### Works with CEO Agent
- Receives: Strategic infrastructure decisions
- Provides: Cost reports, performance metrics
- Coordinates: Resource allocation, budget planning

### Works with Backend Agent
- Receives: API monitoring requirements
- Provides: Performance metrics, error logs
- Coordinates: Database monitoring, API health

### Works with Testing Agent
- Receives: CI/CD test requirements
- Provides: Test automation infrastructure
- Coordinates: Test environments, coverage reporting

### Works with Documentation Agent
- Receives: Documentation structure needs
- Provides: Operational content
- Coordinates: Clear separation (ops vs product docs)

---

## 📈 Progression Path

### Level 1: Operations Assistant (0-99 XP)
- Set up basic monitoring
- Validate configurations
- Write simple runbooks

### Level 2: DevOps Engineer (100-249 XP)
- Full monitoring stack
- CI/CD pipelines
- Cost optimization
- Incident response

### Level 3: Site Reliability Engineer (250-499 XP)
- Advanced observability
- Automated remediation
- Performance optimization
- Capacity planning

### Level 4: Platform Engineer (500-999 XP)
- Infrastructure design
- Advanced automation
- Multi-environment orchestration
- System architecture

### Level 5: DevOps Architect (1000+ XP)
- Framework-wide optimization
- Strategic infrastructure planning
- Industry best practices
- Team mentorship

---

## 🏆 Attributes & Skills

The DevOps agent tracks these attributes (Football Manager style, 1-20 scale):

```yaml
Starting Attributes:
  Infrastructure_Management: 15/20
  Monitoring_Setup: 16/20
  CI_CD_Automation: 14/20
  Incident_Response: 15/20
  Documentation_Quality: 17/20
  Cost_Optimization: 16/20
  Security_Compliance: 14/20
  System_Reliability: 15/20
```

Attributes increase with successful completions of relevant tasks.

---

## 🔍 Troubleshooting

### Agent Not Available

```bash
# Check if plugin is installed
/plugin list

# Install if missing
/plugin install devops-agent@claude-multi-agent-framework
```

### Monitoring Stack Won't Start

```bash
/role-devops

> "Debug why monitoring stack won't start"

# Agent will check:
- Docker is running
- Ports are available
- Configuration is valid
- Dependencies are installed
```

### High Context Usage

```bash
/role-devops

> "Context usage is at 85%. Help optimize."

# Agent will:
1. Identify large loaded files
2. Suggest selective loading
3. Recommend pattern references
4. Clear unnecessary context
```

---

## 💰 Cost Impact

The DevOps agent helps **reduce** overall costs by:

1. **Context Optimization**: -20-30% token usage
2. **Opus Strategy**: -75% on strategic tasks (Plan Mode)
3. **Monitoring Alerts**: Prevent budget overruns
4. **Performance Tuning**: Faster execution = fewer tokens

**Typical cost**: $5-10/month
**Savings**: $40-60/month
**Net benefit**: $30-50/month saved

---

## 📖 Resources

### Official Documentation
- [Claude Code Settings](https://docs.claude.com/en/docs/claude-code/settings)
- [OpenTelemetry](https://opentelemetry.io/docs/)
- [Prometheus](https://prometheus.io/docs/)
- [Grafana](https://grafana.com/docs/)

### Framework Documentation
- [Configuration Architecture](../../docs/CONFIGURATION_ARCHITECTURE.md)
- [Context Optimization](../../docs/CONTEXT_OPTIMIZATION.md)
- [Monitoring System](../../monitoring/MONITORING_SYSTEM.md)

---

## 🤝 Contributing

Improvements to the DevOps agent are welcome!

Areas for contribution:
- Additional monitoring integrations
- More CI/CD templates
- Enhanced health checks
- Cost optimization algorithms
- Better diagnostic tools

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.

---

## 📄 License

MIT License - Part of claude-multi-agent-framework

---

**Version**: 1.0.0
**Last Updated**: 2025-01-15
**Maintainer**: Framework Team
**Model**: Sonnet 4.5
