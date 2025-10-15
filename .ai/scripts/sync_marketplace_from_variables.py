#!/usr/bin/env python3
"""
Sync marketplace.json from VARIABLES.yaml
Single source of truth: VARIABLES.yaml
Generated output: marketplace.json
"""

import json
import yaml
import sys
from pathlib import Path
from datetime import datetime

def load_variables(variables_path):
    """Load VARIABLES.yaml from either project or framework directory"""
    with open(variables_path, 'r') as f:
        return yaml.safe_load(f)

def sync_marketplace(variables_path, marketplace_path, framework_path):
    """Generate marketplace.json from VARIABLES.yaml"""

    print("=" * 60)
    print("Marketplace Sync from VARIABLES.yaml")
    print("=" * 60)
    print(f"Reading: {variables_path}")
    print(f"Output:  {marketplace_path}")
    print()

    # Load variables
    variables = load_variables(variables_path)

    # Extract marketplace config
    marketplace_config = variables['marketplaces']['framework']
    plugins_config = marketplace_config['plugins']
    owner_config = variables['owner']

    # Build marketplace.json structure
    marketplace = {
        "name": marketplace_config['name'],
        "version": marketplace_config['version'],
        "owner": {
            "name": owner_config['name'],
            "github": owner_config['github'],
            "repository": marketplace_config['github_repo'].replace('fda3r6sbvdgq09gse2/', f"https://github.com/{owner_config['github']}/"),
            "_note": "⚠️ Change owner.name in VARIABLES.yaml - single source of truth"
        },
        "description": marketplace_config['description'],
        "plugins": []
    }

    # Add plugins
    for plugin in plugins_config:
        plugin_entry = {
            "name": plugin['name'],
            "source": f"./plugins/{plugin['name']}",
            "description": plugin['description'],
            "version": marketplace_config['version'],
            "category": plugin['category'],
            "keywords": [plugin['type'], plugin['category']],
            "strict": False
        }
        marketplace['plugins'].append(plugin_entry)

    # Add metadata
    marketplace['metadata'] = {
        "homepage": f"https://github.com/{owner_config['github']}/claude-dev-framework",
        "documentation": f"https://github.com/{owner_config['github']}/claude-dev-framework/blob/main/README.md",
        "license": "MIT",
        "keywords": [
            "multi-agent",
            "ai-development",
            "claude-code",
            "parallel-development",
            "git-worktrees",
            "specialized-agents"
        ],
        "reorganized": datetime.now().isoformat(),
        "structure": "individual-plugins",
        "note": "Each agent plugin is independently loadable with its own configuration",
        "generated_from": "VARIABLES.yaml - DO NOT EDIT marketplace.json DIRECTLY"
    }

    # Write marketplace.json
    with open(marketplace_path, 'w') as f:
        json.dump(marketplace, f, indent=2)

    print(f"✅ Generated marketplace.json with {len(marketplace['plugins'])} plugins")
    print()
    print("Plugins synced:")
    for plugin in marketplace['plugins']:
        print(f"  • {plugin['name']} ({plugin['category']})")
    print()
    print("⚠️  Changes were made based on VARIABLES.yaml")
    print("    To make changes, edit VARIABLES.yaml and re-run this script")
    print()

if __name__ == "__main__":
    # Determine paths
    script_dir = Path(__file__).parent
    framework_dir = script_dir.parent.parent

    # Try project VARIABLES.yaml first, fall back to framework
    project_variables = framework_dir.parent / "book-cataloger" / ".ai" / "VARIABLES.yaml"
    framework_variables = framework_dir / ".ai" / "VARIABLES.yaml"

    if project_variables.exists():
        variables_path = project_variables
    elif framework_variables.exists():
        variables_path = framework_variables
    else:
        print("❌ Error: VARIABLES.yaml not found")
        print(f"   Looked in:")
        print(f"   - {project_variables}")
        print(f"   - {framework_variables}")
        sys.exit(1)

    marketplace_path = framework_dir / ".claude-plugin" / "marketplace.json"

    sync_marketplace(variables_path, marketplace_path, framework_dir)
