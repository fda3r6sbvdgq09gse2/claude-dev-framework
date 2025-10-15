# Production Monitoring Setup
*OpenTelemetry Integration for Claude Code Multi-Agent Framework*
*Version: 1.0.0*

## 🎯 Overview

This monitoring system provides enterprise-grade observability for your AI development team using OpenTelemetry (OTEL), the industry standard for metrics, logs, and traces.

### Architecture

```
Claude Code Agents
       ↓
OpenTelemetry SDK
       ↓
  ┌────────────┬───────────┬──────────────┐
  ↓            ↓           ↓              ↓
Console    Prometheus   Grafana      Custom DB
(debug)    (metrics)   (dashboards)  (analytics)
```

---

## 🚀 Quick Start (5 minutes)

### Option 1: Local Development (Console)
```bash
cd ~/dev/claude-dev-framework

# Enable telemetry
export CLAUDE_CODE_ENABLE_TELEMETRY=1

# Console output (for debugging)
export OTEL_METRICS_EXPORTER=console
export OTEL_LOGS_EXPORTER=console

# Start working
cd ~/dev/your-project
claude
```

### Option 2: Production (Prometheus + Grafana)
```bash
# Start monitoring stack
docker-compose -f monitoring/setup/docker-compose.yml up -d

# Configure Claude Code
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317

# Verify
curl http://localhost:9090  # Prometheus
curl http://localhost:3000  # Grafana
```

---

## 📊 What Gets Monitored

### Automatic (Claude Code Built-in)
```yaml
sessions:
  - session_id: Unique identifier
  - account_uuid: Your account
  - terminal_type: Where running
  - app_version: Claude Code version
  - start_time: When started
  - end_time: When ended
  - duration: Total time

code_metrics:
  - lines_added: New code
  - lines_deleted: Removed code
  - files_modified: Changed files
  - files_read: Accessed files

git_activity:
  - commits_created: Auto commits
  - pull_requests: PRs opened
  - branches: Feature branches

api_usage:
  - tokens_input: Tokens sent
  - tokens_output: Tokens received
  - tokens_total: Sum
  - api_calls: Number of requests
  - cost_usd: Estimated cost

tool_usage:
  - bash_calls: Shell commands
  - read_operations: File reads
  - write_operations: File writes
  - edit_operations: File edits
```

### Custom (Our Framework)
```yaml
agent_metrics:
  - agent_id: Which agent (backend, frontend, etc.)
  - agent_level: Current level
  - agent_xp: Experience points
  - task_type: What working on
  - task_complexity: Story points

performance:
  - efficiency_score: Output per token
  - quality_score: Tests, bugs
  - collaboration_score: Teamwork

business:
  - feature_completed: Boolean
  - story_points_delivered: Velocity
  - bugs_introduced: Quality
  - patterns_extracted: Learning
```

---

## 🏗️ Installation

### Prerequisites
```bash
# Required
- Docker & Docker Compose (for prod stack)
- Python 3.11+
- Claude Code CLI

# Optional but recommended
- Grafana Cloud account (for managed monitoring)
```

### Step 1: Clone Monitoring Setup
```bash
cd ~/dev/claude-dev-framework/monitoring
ls -la setup/

# You should see:
# - docker-compose.yml
# - prometheus.yml
# - grafana-dashboards/
# - otel-collector-config.yml
```

### Step 2: Start Monitoring Stack
```bash
cd monitoring/setup
docker-compose up -d

# Verify services
docker-compose ps

# Expected output:
# prometheus    Up    0.0.0.0:9090->9090/tcp
# grafana       Up    0.0.0.0:3000->3000/tcp
# otel-collector Up   0.0.0.0:4317->4317/tcp
```

### Step 3: Configure Claude Code
```bash
# Add to your ~/.zshrc or ~/.bashrc
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_SERVICE_NAME="claude-multi-agent-framework"

# Reload
source ~/.zshrc
```

### Step 4: Install Framework Monitoring Extension
```bash
# Install monitoring utilities
pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-otlp

# Install framework monitoring
cd ~/dev/claude-dev-framework
pip install -e monitoring/python-sdk/
```

### Step 5: Verify
```bash
# Run a test session
claude
# (do some work, then exit)

# Check metrics
curl http://localhost:9090/api/v1/query?query=claude_sessions_total

# Check Grafana dashboards
open http://localhost:3000
# Username: admin
# Password: admin (change on first login)
```

---

## 📈 Dashboards

### Grafana Dashboards (Pre-built)

#### 1. Executive Dashboard
- Total cost (daily, weekly, monthly)
- Agent utilization
- Feature delivery rate
- Quality metrics

#### 2. Agent Performance Dashboard
- Per-agent metrics
- Efficiency scores
- Cost breakdown
- Time tracking

#### 3. Technical Dashboard
- Token usage trends
- API call patterns
- Context window usage
- Tool usage breakdown

#### 4. Quality Dashboard
- Test coverage trends
- Bug introduction rate
- PR metrics
- Code review times

### Import Dashboards
```bash
# Import to Grafana
cd monitoring/setup/grafana-dashboards

# Via UI
Grafana → Dashboards → Import → Upload JSON

# Or via API
for dashboard in *.json; do
  curl -X POST http://localhost:3000/api/dashboards/db \
    -H "Content-Type: application/json" \
    -d @$dashboard
done
```

---

## 🔧 Configuration Files

### docker-compose.yml
```yaml
version: '3.8'

services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus-data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/usr/share/prometheus/console_libraries'
      - '--web.console.templates=/usr/share/prometheus/consoles'

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    volumes:
      - grafana-data:/var/lib/grafana
      - ./grafana-dashboards:/etc/grafana/provisioning/dashboards
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_USERS_ALLOW_SIGN_UP=false

  otel-collector:
    image: otel/opentelemetry-collector:latest
    ports:
      - "4317:4317"  # OTLP gRPC
      - "4318:4318"  # OTLP HTTP
      - "8889:8889"  # Prometheus exporter
    volumes:
      - ./otel-collector-config.yml:/etc/otel/config.yaml
    command: ["--config=/etc/otel/config.yaml"]

volumes:
  prometheus-data:
  grafana-data:
```

### prometheus.yml
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'claude-agents'
    static_configs:
      - targets: ['otel-collector:8889']
    relabel_configs:
      - source_labels: [agent_id]
        target_label: agent
      - source_labels: [project_name]
        target_label: project
```

### otel-collector-config.yml
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:
    timeout: 10s
    send_batch_size: 1024

  resourcedetection:
    detectors: [env, system]

  attributes:
    actions:
      - key: service.name
        value: ${OTEL_SERVICE_NAME}
        action: upsert

exporters:
  prometheus:
    endpoint: "0.0.0.0:8889"
    namespace: "claude"

  logging:
    loglevel: info

  otlp:
    endpoint: "your-vendor-endpoint:4317"
    headers:
      api-key: "${VENDOR_API_KEY}"

service:
  pipelines:
    metrics:
      receivers: [otlp]
      processors: [batch, resourcedetection, attributes]
      exporters: [prometheus, logging]

    logs:
      receivers: [otlp]
      processors: [batch, resourcedetection]
      exporters: [logging]

    traces:
      receivers: [otlp]
      processors: [batch, resourcedetection]
      exporters: [logging]
```

---

## 🐍 Python SDK Usage

### Basic Usage
```python
from claude_monitoring import AgentMonitor, track_task

# Initialize monitor
monitor = AgentMonitor(
    agent_id="backend",
    project_name="book-cataloger"
)

# Track a task
with monitor.track_task("Add API rate limiting", complexity=5):
    # Your implementation
    result = implement_rate_limiting()

# Manual tracking
monitor.record_metric("api_calls", 1)
monitor.record_metric("tokens_used", 45230)
monitor.record_cost(0.87)
```

### Advanced Usage
```python
from claude_monitoring import (
    AgentMonitor,
    track_task,
    track_performance,
    track_quality
)

# Initialize with full configuration
monitor = AgentMonitor(
    agent_id="backend",
    agent_level=2,
    project_name="book-cataloger",
    sprint="6B",
    export_to_grafana=True
)

# Track task with context
@track_task(
    monitor=monitor,
    task_type="feature",
    complexity=5
)
def add_api_feature():
    # Implementation
    pass

# Track performance metrics
@track_performance(monitor=monitor)
def process_items(items):
    # Tracks time, throughput, efficiency
    for item in items:
        process(item)

# Track quality metrics
@track_quality(
    monitor=monitor,
    test_coverage_required=0.90
)
def implement_with_tests():
    # Implementation + tests
    # Auto-checks test coverage
    pass
```

---

## 📊 Metrics Reference

### Standard Metrics (OTEL)
```
# Sessions
claude_sessions_total{agent, project}
claude_session_duration_seconds{agent, project}

# Code Activity
claude_lines_added_total{agent, project, file_type}
claude_lines_deleted_total{agent, project, file_type}
claude_files_modified_total{agent, project}

# API Usage
claude_tokens_input_total{agent, project, model}
claude_tokens_output_total{agent, project, model}
claude_api_cost_usd_total{agent, project, model}

# Tool Usage
claude_tool_calls_total{agent, tool, project}
```

### Custom Metrics (Framework)
```
# Agent Performance
claude_agent_efficiency_score{agent, project}
claude_agent_quality_score{agent, project}
claude_agent_xp{agent}
claude_agent_level{agent}

# Business Metrics
claude_features_delivered_total{agent, project}
claude_story_points_delivered_total{agent, project}
claude_bugs_introduced_total{agent, project}

# Context Management
claude_context_usage_percent{agent}
claude_pattern_loads_total{agent, pattern}
```

---

## 🎯 Best Practices

### 1. Label Consistently
```python
# Good - consistent labels
monitor.record_metric("api_calls", 1,
    labels={
        "agent": "backend",
        "project": "book-cataloger",
        "sprint": "6B"
    })

# Bad - inconsistent labels
monitor.record_metric("api_calls", 1,
    labels={"agent": "Backend"})  # Inconsistent capitalization
```

### 2. Use Appropriate Metric Types
```python
# Counter (always increases)
monitor.increment("features_completed")

# Gauge (can go up or down)
monitor.gauge("context_usage_percent", 45.3)

# Histogram (distribution)
monitor.histogram("task_duration_seconds", 3600)
```

### 3. Add Context
```python
# Better - with context
with monitor.span("api_integration"):
    with monitor.span("fetch_data"):
        data = fetch()
    with monitor.span("transform_data"):
        result = transform(data)
```

### 4. Handle Errors
```python
try:
    with monitor.track_task("risky_operation"):
        result = do_something()
except Exception as e:
    monitor.record_error(e)
    raise
```

---

## 🔍 Troubleshooting

### Metrics Not Showing Up
```bash
# Check telemetry enabled
echo $CLAUDE_CODE_ENABLE_TELEMETRY
# Should show: 1

# Check OTEL endpoint
echo $OTEL_EXPORTER_OTLP_ENDPOINT
# Should show: http://localhost:4317

# Check OTEL collector
docker logs otel-collector
# Look for "Serving" messages

# Check Prometheus targets
open http://localhost:9090/targets
# All should be "UP"
```

### High Cardinality Warnings
```
# Too many unique label combinations
# Bad:
labels={"file_path": "/absolute/path/to/file.py"}  # Unbounded

# Good:
labels={"file_type": "python"}  # Bounded
```

### Missing Data
```bash
# Check data pipeline
OTEL Collector logs → Prometheus → Grafana

# Verify each step
1. Collector receiving data?
   docker logs otel-collector | grep "received"

2. Prometheus scraping?
   curl http://localhost:9090/api/v1/targets

3. Grafana querying?
   Check dashboard queries
```

---

## 🚀 Advanced Topics

### Custom Exporters
```python
# Export to custom database
from claude_monitoring.exporters import CustomExporter

class PostgreSQLExporter(CustomExporter):
    def export_metric(self, metric):
        # Write to PostgreSQL
        self.db.execute(
            "INSERT INTO metrics VALUES (%s, %s, %s)",
            (metric.name, metric.value, metric.timestamp)
        )
```

### Alerting
```yaml
# Prometheus alerting rules
groups:
  - name: claude_alerts
    rules:
      - alert: HighCost
        expr: rate(claude_api_cost_usd_total[1h]) > 10
        annotations:
          summary: "High API cost rate"

      - alert: LowEfficiency
        expr: claude_agent_efficiency_score < 0.0001
        annotations:
          summary: "Agent efficiency below threshold"
```

### Multi-Project Setup
```bash
# Separate metrics per project
export OTEL_RESOURCE_ATTRIBUTES="project.name=book-cataloger,team=backend"
```

---

## 📚 Resources

- [OpenTelemetry Docs](https://opentelemetry.io/docs/)
- [Prometheus Docs](https://prometheus.io/docs/)
- [Grafana Docs](https://grafana.com/docs/)
- [Claude Code Monitoring](https://docs.claude.com/en/docs/claude-code/monitoring-usage)

---

## ✅ Production Checklist

Before going to production:

- [ ] Monitoring stack deployed
- [ ] All agents configured with OTEL
- [ ] Dashboards imported to Grafana
- [ ] Alerts configured
- [ ] Backup/retention policies set
- [ ] Team trained on dashboards
- [ ] Runbook documented
- [ ] On-call rotation established

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Maintainer:** Framework Team
**Support:** See monitoring/SUPPORT.md
