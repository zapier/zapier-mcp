# Contributing to Zapier MCP Skills, Commands, and Plugins

Thank you for your interest in contributing! This guide will help you understand the repository structure and development workflow.

## Repository Structure

```
zapier-mcp/
├── skills/              ⭐ Source of truth for all skills
│   ├── work-on-ticket/
│   ├── git-commit/
│   ├── code-review/
│   ├── CLAUDE.md       # Skill triggers and guidelines
│   └── LICENSE.md
├── commands/            ⭐ Source of truth for all commands
│   └── eng/
│       └── chore.md
├── plugins/             ⭐ Plugin manifests (edit these)
│   ├── zapier-eng-plugin.json
│   └── README.md
├── dist/                # Built distributions (gitignored, DO NOT EDIT)
│   ├── skills/          # Individual skill zips
│   └── plugins/         # Built plugin directories
├── Makefile             # Build system
├── BUILD.md             # Build system docs
└── README.md
```

## Development Workflow

### Adding or Editing Skills

1. **Edit the source files** in `/skills/`:
   ```bash
   # Edit an existing skill
   vim skills/work-on-ticket/SKILL.md
   
   # Or create a new skill
   mkdir skills/my-new-skill
   vim skills/my-new-skill/SKILL.md
   ```

2. **Update plugin manifests** to include your skill:
   ```bash
   vim plugins/zapier-eng-plugin/manifest.json
   ```
   
   Add your skill to the `skills` array:
   ```json
   {
     "skills": [
       "work-on-ticket",
       "my-new-skill"
     ]
   }
   ```

3. **Rebuild plugins**:
   ```bash
   make build-all
   ```

4. **Test your changes** with Claude or your MCP client

### Adding or Editing Commands

1. **Edit the source files** in `/commands/`:
   ```bash
   # Edit an existing command
   vim commands/eng/chore.md
   
   # Or create a new command
   mkdir -p commands/product
   vim commands/product/roadmap.md
   ```

2. **Update plugin manifests** to include your command:
   ```bash
   vim plugins/zapier-eng-plugin/manifest.json
   ```
   
   Add your command to the `commands` array:
   ```json
   {
     "commands": [
       "eng/chore",
       "product/roadmap"
     ]
   }
   ```

3. **Rebuild plugins**:
   ```bash
   make build-all
   ```

### Creating a New Plugin

1. **Create a plugin manifest JSON file**:
   ```bash
   cat > plugins/my-plugin.json << 'EOF'
   {
     "name": "my-plugin",
     "version": "1.0.0",
     "description": "Description of what this plugin does",
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
   EOF
   ```

2. **Build the plugin**:
   ```bash
   make build PLUGIN=my-plugin
   ```

3. **Find the built plugin**:
   ```bash
   ls dist/plugins/my-plugin/
   ```

4. **Test the plugin** with your MCP client

## Important Rules

### ⚠️ DO NOT Edit Built Files Directly

**Never edit files in `dist/plugins/`** - these are generated and gitignored.

❌ **Wrong:**
```bash
vim dist/plugins/zapier-eng-plugin/skills/work-on-ticket/SKILL.md
```

✅ **Correct:**
```bash
# Edit the source
vim skills/work-on-ticket/SKILL.md
# Rebuild
make build-all
```

### ✅ Edit Manifests for Plugin Configuration

Plugin manifest JSON files in `plugins/` are tracked in git and should be edited:

✅ **Correct:**
```bash
vim plugins/zapier-eng-plugin.json
make build PLUGIN=zapier-eng-plugin
```

### ✅ Always Rebuild After Changes

After editing any skill or command:

```bash
make build-all
```

Or for a specific plugin:

```bash
make build PLUGIN=zapier-eng-plugin
```

### 📝 Update Documentation

When adding new skills or plugins:

1. Update `skills/README.md` if adding a new skill
2. Update `plugins/README.md` if adding a new plugin
3. Update `skills/CLAUDE.md` if adding new trigger patterns

## Skill Development Guidelines

### Skill Structure

Each skill should have:

```
skill-name/
├── SKILL.md          # Main skill instructions (required)
├── references/       # Additional docs (optional)
└── scripts/          # Executable code (optional)
```

### SKILL.md Format

Use YAML frontmatter:

```yaml
---
name: Skill Name
description: Brief description that includes trigger phrases
allowed-tools: Tool1, Tool2
license: MIT
metadata:
  author: Your Name
  version: 1.0.0
  mcp-server: zapier
---

# Skill Name

Full skill documentation...
```

### Trigger Patterns

Add trigger patterns to `skills/CLAUDE.md`:

```markdown
| Trigger | Skill |
|---------|-------|
| "your trigger phrase", "alternative phrase" | `your-skill-name` |
```

## Testing

### Manual Testing

1. Build the plugin: `make build PLUGIN=zapier-eng-plugin`
2. Install the plugin in Claude/your MCP client
3. Test the trigger phrases
4. Verify the workflow executes correctly

### Automated Testing

(Coming soon)

## Useful Make Commands

```bash
# Show all available commands
make help

# Build a specific plugin
make build PLUGIN=zapier-eng-plugin

# Build all plugins
make build-all

# Clean a specific plugin
make clean PLUGIN=zapier-eng-plugin

# Clean all plugins
make clean-all

# List all plugins
make list-plugins

# Watch for changes and auto-rebuild (requires fswatch)
make watch PLUGIN=zapier-eng-plugin

# Create distribution zips
make zip-skills          # Zip all individual skills
```

## Questions?

- Check [BUILD.md](BUILD.md) for build system details
- Check [skills/README.md](skills/README.md) for skill documentation
- Open an issue for bugs or feature requests

## License

MIT License - see [LICENSE](skills/LICENSE.md) for details.

