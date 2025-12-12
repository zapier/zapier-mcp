# Build System

This repository uses a Makefile-based build system to manage plugins. Skills and commands are maintained in the root directory, and plugins are built by copying the relevant files based on each plugin's manifest.

## Repository Structure

```
zapier-mcp/
├── skills/              # Source of truth for all skills
│   ├── work-on-ticket/
│   ├── git-commit/
│   ├── code-review/
│   ├── CLAUDE.md       # Shared skill configuration
│   └── LICENSE.md      # Shared license
├── commands/            # Source of truth for all commands
│   └── eng/
│       └── chore.md
├── plugins/             # Plugin distributions
│   └── zapier-eng-plugin/
│       ├── manifest.json    # Declares which skills/commands to include
│       ├── skills/          # Built by make (gitignored)
│       └── commands/        # Built by make (gitignored)
├── Makefile             # Build system
└── BUILD.md             # This file
```

## Quick Start

### Build a plugin

```bash
make build PLUGIN=zapier-eng-plugin
```

### Build all plugins

```bash
make build-all
```

### Clean a plugin

```bash
make clean PLUGIN=zapier-eng-plugin
```

### List available plugins

```bash
make list-plugins
```

## Plugin Manifest

Each plugin has a `manifest.json` that declares which skills and commands to include:

```json
{
  "name": "zapier-eng-plugin",
  "version": "1.0.0",
  "description": "Engineering workflow plugin with Jira integration",
  "skills": [
    "work-on-ticket",
    "git-commit",
    "code-review"
  ],
  "commands": [
    "eng/chore"
  ]
}
```

## Available Make Targets

Run `make help` to see all available targets:

```bash
make help
```

Targets include:
- `build` - Build a specific plugin
- `build-all` - Build all plugins
- `clean` - Clean a specific plugin
- `clean-all` - Clean all plugins
- `list-plugins` - List all available plugins
- `watch` - Watch for changes and auto-rebuild (requires fswatch)

## Creating a New Plugin

1. Create a new directory under `plugins/`:
   ```bash
   mkdir -p plugins/my-new-plugin/skills
   mkdir -p plugins/my-new-plugin/commands
   touch plugins/my-new-plugin/skills/.gitkeep
   touch plugins/my-new-plugin/commands/.gitkeep
   ```

2. Create a `manifest.json`:
   ```bash
   cat > plugins/my-new-plugin/manifest.json << 'EOF'
   {
     "name": "my-new-plugin",
     "version": "1.0.0",
     "description": "My custom plugin",
     "skills": [
       "work-on-ticket"
     ],
     "commands": [
       "eng/chore"
     ]
   }
   EOF
   ```

3. Build the plugin:
   ```bash
   make build PLUGIN=my-new-plugin
   ```

## Development Workflow

### Editing Skills/Commands

1. Edit files in `skills/` or `commands/` directories (the source of truth)
2. Rebuild affected plugins:
   ```bash
   make build-all
   ```

### Auto-rebuild on Changes (Optional)

Install fswatch and use the watch target:

```bash
brew install fswatch
make watch PLUGIN=zapier-eng-plugin
```

This will automatically rebuild the plugin when files change in `skills/` or `commands/`.

## CI/CD Integration

Add this to your CI pipeline to ensure plugins are always built:

```yaml
# .github/workflows/build.yml
name: Build Plugins
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install jq
        run: sudo apt-get install -y jq
      - name: Build all plugins
        run: make build-all
      - name: Upload plugin artifacts
        uses: actions/upload-artifact@v3
        with:
          name: plugins
          path: plugins/
```

## Why This Structure?

**Benefits:**
- ✅ Single source of truth for skills and commands
- ✅ Easy to maintain and update shared skills
- ✅ Plugins can cherry-pick which skills they need
- ✅ No code duplication
- ✅ Simple, standard tooling (Make)
- ✅ No additional dependencies (just jq, which is widely available)

**Alternative considered:**
- Symlinks: Would work but harder to distribute as packages
- Git submodules: Too complex for this use case
- npm/package manager: Overkill for file copying

## Troubleshooting

**`jq: command not found`**

Install jq:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# CentOS/RHEL
sudo yum install jq
```

**Plugin not building**

Check that your manifest.json is valid:
```bash
jq . plugins/my-plugin/manifest.json
```

**Changes not reflected**

Make sure you rebuild after editing skills/commands:
```bash
make build PLUGIN=your-plugin
```

