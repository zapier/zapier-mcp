# Zapier MCP Plugins

This directory contains plugin distributions built from the skills and commands in the root directory.

## What are Plugins?

Plugins are curated collections of skills and commands for specific use cases. Each plugin:

- Has a `manifest.json` declaring which skills/commands it includes
- Is built by running `make build PLUGIN=plugin-name`
- Contains copies of the relevant skills and commands (gitignored)

## Available Plugins

### zapier-eng-plugin

Engineering workflow plugin with Jira integration.

**Includes:**
- `work-on-ticket` - Start work on Jira tickets with automatic branch creation
- `git-commit` - Generate storytelling commit messages with Jira context
- `code-review` - Comprehensive code reviews with Jira ticket integration

**Apps to connect:** Jira

**Build:** `make build PLUGIN=zapier-eng-plugin`

## Plugin Structure

Each plugin has the following structure:

```
plugin-name/
├── manifest.json        # Declares which skills/commands to include
├── .mcp.json           # MCP server configuration
├── .claude-plugin/     # Claude plugin metadata
│   └── plugin.json
├── skills/             # Built by make (gitignored)
└── commands/           # Built by make (gitignored)
```

## Creating a New Plugin

1. **Create plugin directory:**
   ```bash
   mkdir -p plugins/my-plugin/skills
   mkdir -p plugins/my-plugin/commands
   ```

2. **Create manifest.json:**
   ```json
   {
     "name": "my-plugin",
     "version": "1.0.0",
     "description": "My custom plugin",
     "skills": [
       "work-on-ticket"
     ],
     "commands": [
       "eng/chore"
     ]
   }
   ```

3. **Build the plugin:**
   ```bash
   make build PLUGIN=my-plugin
   ```

See [BUILD.md](/BUILD.md) for complete documentation.

## Development Workflow

When editing skills or commands:

1. Edit files in the root `/skills/` or `/commands/` directories (source of truth)
2. Rebuild plugins: `make build-all`
3. Test your changes

## Why This Structure?

**Benefits:**
- ✅ Single source of truth for all skills and commands
- ✅ Easy to maintain shared skills across plugins
- ✅ Plugins can cherry-pick only what they need
- ✅ No code duplication
- ✅ Simple versioning and distribution

**Plugin files are gitignored** because they're generated from the source files. This prevents conflicts and ensures consistency.

