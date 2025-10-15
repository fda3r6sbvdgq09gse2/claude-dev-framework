#!/usr/bin/env python3
"""
Reorganize marketplace.json to use component-based plugin structure.

This script transforms the existing marketplace from individual agent plugins
into organized plugin groups that leverage Claude Code's native component types:
- agents, commands, hooks, mcpServers fields within plugins

Usage:
    cd claude-dev-framework
    python scripts/reorganize_marketplace.py
"""

import json
from pathlib import Path
import sys
from datetime import datetime

def read_marketplace(path: Path) -> dict:
    """Read and parse the marketplace.json file."""
    with open(path, 'r') as f:
        return json.load(f)


def convert_to_relative_path(absolute_path: str) -> str:
    """Convert absolute path to relative path."""
    if absolute_path.startswith('/'):
        path = Path(absolute_path)
        parts = path.parts
        if 'plugins' in parts:
            idx = parts.index('plugins')
            return './plugins/' + '/'.join(parts[idx+1:])
    return absolute_path


def create_organized_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create reorganized marketplace with component-based structure."""

    # Discover command files
    commands_dir = base_dir / '.claude' / 'commands'
    command_files = []
    if commands_dir.exists():
        command_files = sorted([f'./.claude/commands/{f.name}' for f in commands_dir.glob('*.md')])

    # Discover hook scripts
    hooks_dir = base_dir / 'config' / 'hooks'
    hook_scripts = []
    if hooks_dir.exists():
        hook_scripts = sorted([f'./config/hooks/{f.name}' for f in hooks_dir.glob('*.sh')])

    # Create organized plugins
    plugins = [
        {
            "name": "development-agents",
            "source": "./plugins/development-agents",
            "description": "Core development agents for backend, frontend, and integration work",
            "version": "2.0.0",
            "category": "development",
            "agents": [
                "./plugins/backend-agent/agents/backend.md",
                "./plugins/frontend-agent/agents/frontend.md",
                "./plugins/integration-agent/agents/integration.md",
                "./plugins/testing-agent/agents/testing.md"
            ],
            "keywords": ["backend", "frontend", "integration", "testing", "development"],
            "strict": False
        },
        {
            "name": "management-agents",
            "source": "./plugins/management-agents",
            "description": "Strategic and operational management agents including CEO and DevOps",
            "version": "2.0.0",
            "category": "management",
            "agents": [
                "./plugins/ceo-agent/agents/ceo.md",
                "./plugins/documentation-agent/agents/documentation.md",
                "./plugins/devops-agent/agents/devops.md"
            ],
            "keywords": ["management", "strategy", "devops", "documentation"],
            "strict": False
        },
        {
            "name": "quality-agents",
            "source": "./plugins/quality-agents",
            "description": "Quality assurance and user experience agents",
            "version": "2.0.0",
            "category": "quality",
            "agents": [
                "./plugins/qa-automation-agent/agents/qa-automation.md",
                "./plugins/ux-product-agent/agents/ux-product.md"
            ],
            "keywords": ["qa", "testing", "ux", "product", "quality"],
            "strict": False
        },
        {
            "name": "sprint-commands",
            "source": "./plugins/sprint-commands",
            "description": "Sprint management and workflow automation commands",
            "version": "2.0.0",
            "category": "productivity",
            "commands": command_files if command_files else [
                "./.claude/commands/role-ceo.md",
                "./.claude/commands/role-backend.md",
                "./.claude/commands/role-frontend.md",
                "./.claude/commands/role-testing.md",
                "./.claude/commands/supercharge-activate.md"
            ],
            "keywords": ["sprint", "workflow", "automation", "commands"],
            "strict": False
        },
        {
            "name": "workflow-hooks",
            "source": "./plugins/workflow-hooks",
            "description": "Automated validation, testing, and safety hooks",
            "version": "2.0.0",
            "category": "automation",
            "hooks": {
                "SessionStart": [
                    {
                        "matcher": "*",
                        "hooks": [
                            {"type": "command", "command": "./config/hooks/session-start.sh"}
                        ]
                    }
                ],
                "SessionEnd": [
                    {
                        "matcher": "*",
                        "hooks": [
                            {"type": "command", "command": "./config/hooks/session-end.sh"}
                        ]
                    }
                ],
                "PostToolUse": [
                    {
                        "matcher": "Bash(git commit:*)",
                        "hooks": [
                            {"type": "command", "command": "./config/hooks/safety-check.sh"}
                        ]
                    }
                ]
            },
            "keywords": ["hooks", "automation", "validation", "safety"],
            "strict": False
        },
        {
            "name": "context-utilities",
            "source": "./plugins/context-management-plugin",
            "description": "Context persistence and session management for graceful shutdown and easy resume",
            "version": "1.0.0",
            "category": "utilities",
            "keywords": ["context", "session", "resume", "persistence", "recovery"],
            "strict": False
        }
    ]

    # Create new marketplace structure
    return {
        "name": "ClaudeDevFramework-Marketplace",
        "version": source_marketplace['version'],
        "owner": source_marketplace['owner'],
        "description": "Organized multi-agent development framework with component-based plugin architecture",
        "plugins": plugins,
        "metadata": {
            **source_marketplace.get('metadata', {}),
            "reorganized": datetime.now().isoformat(),
            "structure": "component-based",
            "note": "Plugins organized by function with native Claude Code component types"
        }
    }


def backup_original(original_path: Path):
    """Create backup of original marketplace."""
    backup_path = original_path.parent / f'marketplace.json.backup.{datetime.now().strftime("%Y%m%d_%H%M%S")}'
    import shutil
    shutil.copy2(original_path, backup_path)
    print(f'📦 Backed up original to: {backup_path.name}')


def write_marketplace(marketplace: dict, output_path: Path):
    """Write marketplace to JSON file with pretty formatting."""
    with open(output_path, 'w') as f:
        json.dump(marketplace, f, indent=2)
    print(f'✅ Updated {output_path}')


def main():
    """Main execution function."""
    # Get paths
    script_dir = Path(__file__).parent
    base_dir = script_dir.parent
    marketplace_dir = base_dir / '.claude-plugin'
    marketplace_path = marketplace_dir / 'marketplace.json'

    # Read source marketplace
    if not marketplace_path.exists():
        print(f'❌ Error: {marketplace_path} not found')
        sys.exit(1)

    print()
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print('🔧 Reorganizing Marketplace to Component-Based Structure')
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print()

    source_marketplace = read_marketplace(marketplace_path)
    print(f'📖 Read source marketplace: {source_marketplace["name"]}')
    print(f'   Version: {source_marketplace["version"]}')
    print(f'   Total plugins: {len(source_marketplace["plugins"])}')
    print()

    # Backup original
    backup_original(marketplace_path)
    print()

    # Create reorganized marketplace
    print('🏗️  Creating component-based structure...')
    print()

    organized_marketplace = create_organized_marketplace(source_marketplace, base_dir)

    print('New structure:')
    for plugin in organized_marketplace['plugins']:
        print(f'  • {plugin["name"]} ({plugin["category"]})')
        if 'agents' in plugin:
            print(f'    └─ {len(plugin["agents"])} agents')
        if 'commands' in plugin:
            print(f'    └─ {len(plugin["commands"])} commands')
        if 'hooks' in plugin:
            print(f'    └─ {len(plugin["hooks"])} hook types')
    print()

    # Write new marketplace
    write_marketplace(organized_marketplace, marketplace_path)

    print()
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print('✅ Reorganization Complete!')
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print()
    print('Changes:')
    print(f'  • {len(source_marketplace["plugins"])} individual plugins')
    print(f'    → {len(organized_marketplace["plugins"])} organized plugin groups')
    print()
    print('Structure:')
    print('  ✓ development-agents (backend, frontend, integration, testing)')
    print('  ✓ management-agents (ceo, documentation, devops)')
    print('  ✓ quality-agents (qa-automation, ux-product)')
    print('  ✓ sprint-commands (workflow automation)')
    print('  ✓ workflow-hooks (safety and validation)')
    print('  ✓ context-utilities (session management)')
    print()
    print('Next steps:')
    print('  1. Review marketplace.json')
    print('  2. Test with: claude')
    print('  3. Commit changes')
    print()


if __name__ == '__main__':
    main()
