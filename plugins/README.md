# Zapier MCP Plugins

This directory contains plugin manifests that define which skills and commands to include in each plugin.

## What are Plugins?

Plugins are curated collections of skills and commands for specific use cases. Each plugin:

- Has a `manifest.json` in this directory declaring which skills/commands it includes
- Is built to `dist/plugins/plugin-name/` by running `make build PLUGIN=plugin-name`
- Built plugins include `.mcp.json` and `.claude-plugin/plugin.json` generated from the manifest

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

**Source (this directory):**
```
plugins/
└── plugin-name.json        # Declares what to include + metadata
```

**Built output (dist/plugins/):**
```
dist/plugins/plugin-name/
├── .mcp.json           # Generated from manifest.mcp_servers
├── .claude-plugin/     # Generated from manifest metadata
│   └── plugin.json
├── skills/             # Copied from /skills/ based on manifest
└── commands/           # Copied from /commands/ based on manifest
```

## Creating a New Plugin

1. **Create plugin directory and manifest:**
   ```bash
   mkdir -p plugins
   touch plugins/plugin-name.json
   ```

2. **Create plugin-name.json:**
   ```json
   {
     "name": "my-plugin",
     "version": "1.0.0",
     "description": "My custom plugin",
     "author": {
       "name": "Your Name",
       "email": "your@email.com"
     },
     "mcp_servers": {
       "zapier": {
         "type": "http",
         "url": "https://mcp.zapier.com/api/v1/connect"
       }
     },
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

4. **Find the built plugin:**
   ```bash
   ls dist/plugins/my-plugin/
   ```

See [BUILD.md](/BUILD.md) for complete documentation.

## Development Workflow

When editing skills or commands:

1. Edit files in the root `/skills/` or `/commands/` directories (source of truth)
2. Rebuild plugins: `make build-all`
3. Test your changes in `dist/plugins/plugin-name/`

When editing plugin configuration:

1. Edit the `manifest.json` in this directory
2. Rebuild the plugin: `make build PLUGIN=plugin-name`
3. Check the generated files in `dist/plugins/plugin-name/`

## Why This Structure?

**Benefits:**
- ✅ Single source of truth for skills and commands in root directories
- ✅ Plugin manifests are lightweight and tracked in git
- ✅ Built plugins are in `dist/` (gitignored) - clean separation
- ✅ `.mcp.json` and `.claude-plugin/` files auto-generated from manifest
- ✅ Easy to maintain and version plugins
- ✅ No code duplication across plugins

**Built plugins are gitignored** because they're generated artifacts. Only manifests are tracked in git.

