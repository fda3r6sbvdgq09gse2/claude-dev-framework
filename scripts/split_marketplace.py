#!/usr/bin/env python3
"""
Split monolithic marketplace into component-based marketplaces.

This script takes the existing marketplace.json and creates 5 component-specific
marketplace files aligned with Claude Code's native architecture:
- agents-marketplace.json (agents component)
- commands-marketplace.json (commands component)
- hooks-marketplace.json (hooks component)
- mcp-marketplace.json (mcpServers component)
- utilities-marketplace.json (utility plugins)

Usage:
    cd claude-dev-framework
    python scripts/split_marketplace.py
"""

import json
from pathlib import Path
import sys

# Define component types and their plugin mappings
AGENT_PLUGINS = [
    'backend-agent',
    'frontend-agent',
    'integration-agent',
    'testing-agent',
    'ceo-agent',
    'documentation-agent',
    'devops-agent',
    'qa-automation-agent',
    'ux-product-agent'
]

# Commands will be discovered from .claude/commands/
COMMAND_PLUGINS = [
    'sprint-commands',
    'role-commands',
    'supercharge-commands'
]

# Hooks will be discovered from config/hooks/
HOOK_PLUGINS = [
    'framework-hooks'
]

# MCP servers (future)
MCP_PLUGINS = [
    'playwright-mcp',
    'github-mcp'
]

# Utility plugins (non-agent components)
UTILITY_PLUGINS = [
    'context-management'
]


def read_marketplace(path: Path) -> dict:
    """Read and parse the marketplace.json file."""
    with open(path, 'r') as f:
        return json.load(f)


def convert_to_relative_path(absolute_path: str, base_dir: Path) -> str:
    """Convert absolute path to relative path from base_dir."""
    if absolute_path.startswith('/'):
        # It's an absolute path
        path = Path(absolute_path)
        try:
            # Try to make it relative to base_dir
            return './' + str(path.relative_to(base_dir))
        except ValueError:
            # If it can't be made relative, extract just the plugin name
            parts = Path(absolute_path).parts
            if 'plugins' in parts:
                idx = parts.index('plugins')
                return './plugins/' + '/'.join(parts[idx+1:])
            return absolute_path
    return absolute_path


def create_agents_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create the agents-marketplace.json file."""
    # Filter agent plugins
    agent_plugins = [
        p for p in source_marketplace['plugins']
        if p['name'] in AGENT_PLUGINS
    ]

    # Convert absolute paths to relative
    for plugin in agent_plugins:
        if 'source' in plugin and isinstance(plugin['source'], dict) and 'path' in plugin['source']:
            plugin['source']['path'] = convert_to_relative_path(
                plugin['source']['path'], base_dir
            )

    return {
        'name': 'ClaudeDevFramework-Agents',
        'version': source_marketplace['version'],
        'owner': source_marketplace['owner'],
        'description': 'Specialized AI agent workers for parallel software development',
        'plugins': agent_plugins,
        'metadata': {
            **source_marketplace.get('metadata', {}),
            'component_type': 'agents',
            'category': 'development'
        }
    }


def create_commands_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create the commands-marketplace.json file."""
    # Create command plugins from .claude/commands/ directory
    commands_dir = base_dir / '.claude' / 'commands'

    command_plugins = []

    if commands_dir.exists():
        # Group commands into logical plugins
        command_files = list(commands_dir.glob('*.md'))

        # Group by prefix
        groups = {}
        for cmd_file in command_files:
            name = cmd_file.stem
            prefix = name.split('-')[0] if '-' in name else 'misc'
            if prefix not in groups:
                groups[prefix] = []
            groups[prefix].append(name)

        # Create plugin entries
        for group_name, commands in groups.items():
            plugin = {
                'name': f'{group_name}-commands',
                'source': {
                    'source': 'file',
                    'path': f'./plugins/{group_name}-commands'
                },
                'description': f'{group_name.title()} workflow commands',
                'category': 'productivity',
                'commands': [f'./.claude/commands/{cmd}.md' for cmd in commands],
                'version': source_marketplace['version']
            }
            command_plugins.append(plugin)

    return {
        'name': 'ClaudeDevFramework-Commands',
        'version': source_marketplace['version'],
        'owner': source_marketplace['owner'],
        'description': 'Sprint management and workflow automation slash commands',
        'plugins': command_plugins,
        'metadata': {
            **source_marketplace.get('metadata', {}),
            'component_type': 'commands',
            'category': 'productivity'
        }
    }


def create_hooks_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create the hooks-marketplace.json file."""
    hooks_dir = base_dir / 'config' / 'hooks'

    hook_plugins = []

    if hooks_dir.exists():
        hook_scripts = list(hooks_dir.glob('*.sh'))

        # Create a single hooks plugin with all scripts
        if hook_scripts:
            plugin = {
                'name': 'framework-hooks',
                'source': {
                    'source': 'file',
                    'path': './plugins/framework-hooks'
                },
                'description': 'Automated validation, testing, and workflow hooks',
                'category': 'automation',
                'hooks': {
                    'SessionStart': [
                        {
                            'matcher': '*',
                            'hooks': [
                                {'type': 'command', 'command': './config/hooks/session-start.sh'}
                            ]
                        }
                    ],
                    'SessionEnd': [
                        {
                            'matcher': '*',
                            'hooks': [
                                {'type': 'command', 'command': './config/hooks/session-end.sh'}
                            ]
                        }
                    ],
                    'PostToolUse': [
                        {
                            'matcher': 'Bash(git commit:*)',
                            'hooks': [
                                {'type': 'command', 'command': './config/hooks/safety-check.sh'}
                            ]
                        }
                    ]
                },
                'version': source_marketplace['version']
            }
            hook_plugins.append(plugin)

    return {
        'name': 'ClaudeDevFramework-Hooks',
        'version': source_marketplace['version'],
        'owner': source_marketplace['owner'],
        'description': 'Automated validation, testing, and workflow hooks',
        'plugins': hook_plugins,
        'metadata': {
            **source_marketplace.get('metadata', {}),
            'component_type': 'hooks',
            'category': 'automation'
        }
    }


def create_mcp_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create the mcp-marketplace.json file."""
    # For now, create an empty marketplace for future MCP servers
    mcp_plugins = []

    return {
        'name': 'ClaudeDevFramework-MCP',
        'version': source_marketplace['version'],
        'owner': source_marketplace['owner'],
        'description': 'Model Context Protocol servers for external tool integration',
        'plugins': mcp_plugins,
        'metadata': {
            **source_marketplace.get('metadata', {}),
            'component_type': 'mcpServers',
            'category': 'integration'
        }
    }


def create_utilities_marketplace(source_marketplace: dict, base_dir: Path) -> dict:
    """Create the utilities-marketplace.json file."""
    # Filter utility plugins (non-agent, non-command plugins)
    utility_plugins = [
        p for p in source_marketplace['plugins']
        if p['name'] in UTILITY_PLUGINS
    ]

    # Convert absolute paths to relative
    for plugin in utility_plugins:
        if 'source' in plugin and isinstance(plugin['source'], dict) and 'path' in plugin['source']:
            plugin['source']['path'] = convert_to_relative_path(
                plugin['source']['path'], base_dir
            )

    return {
        'name': 'ClaudeDevFramework-Utilities',
        'version': source_marketplace['version'],
        'owner': source_marketplace['owner'],
        'description': 'Development utilities and helper plugins for enhanced productivity',
        'plugins': utility_plugins,
        'metadata': {
            **source_marketplace.get('metadata', {}),
            'component_type': 'utilities',
            'category': 'utilities'
        }
    }


def write_marketplace(marketplace: dict, output_path: Path):
    """Write marketplace to JSON file with pretty formatting."""
    with open(output_path, 'w') as f:
        json.dump(marketplace, f, indent=2)
    print(f'✅ Created {output_path} with {len(marketplace["plugins"])} plugins')


def main():
    """Main execution function."""
    # Get paths
    script_dir = Path(__file__).parent
    base_dir = script_dir.parent
    marketplace_dir = base_dir / '.claude-plugin'

    # Read source marketplace
    source_path = marketplace_dir / 'marketplace.json'
    if not source_path.exists():
        print(f'❌ Error: {source_path} not found')
        sys.exit(1)

    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print('🔧 Splitting Monolithic Marketplace into Component Types')
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print()

    source_marketplace = read_marketplace(source_path)
    print(f'📖 Read source marketplace: {source_marketplace["name"]}')
    print(f'   Version: {source_marketplace["version"]}')
    print(f'   Total plugins: {len(source_marketplace["plugins"])}')
    print()

    # Create component-based marketplaces
    print('🏗️  Creating component-based marketplaces...')
    print()

    agents_marketplace = create_agents_marketplace(source_marketplace, base_dir)
    write_marketplace(agents_marketplace, marketplace_dir / 'agents-marketplace.json')

    commands_marketplace = create_commands_marketplace(source_marketplace, base_dir)
    write_marketplace(commands_marketplace, marketplace_dir / 'commands-marketplace.json')

    hooks_marketplace = create_hooks_marketplace(source_marketplace, base_dir)
    write_marketplace(hooks_marketplace, marketplace_dir / 'hooks-marketplace.json')

    mcp_marketplace = create_mcp_marketplace(source_marketplace, base_dir)
    write_marketplace(mcp_marketplace, marketplace_dir / 'mcp-marketplace.json')

    print()
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print('✅ Split Complete!')
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    print()
    print('Created marketplaces:')
    print('  • agents-marketplace.json (agents component)')
    print('  • commands-marketplace.json (commands component)')
    print('  • hooks-marketplace.json (hooks component)')
    print('  • mcp-marketplace.json (mcpServers component)')
    print()
    print('📝 Note: Original marketplace.json preserved for backward compatibility')
    print()
    print('Next steps:')
    print('  1. Review generated marketplace files')
    print('  2. Validate with: python scripts/validate_marketplaces.py')
    print('  3. Test with a project')
    print('  4. Commit changes')
    print()


if __name__ == '__main__':
    main()
