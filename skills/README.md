# Zapier MCP Skills

Pre-built Skills that supercharge your Zapier MCP integration with Claude. These Skills turn raw tool access into reliable, optimized workflows—so Claude knows not just *what* it can do, but *how* to do it well.

## What are Skills?

**Zapier MCP** gives Claude access to 7,000+ apps through a universal API.  
**Skills** teach Claude the best workflows for common tasks.

Together, they let you accomplish complex multi-app workflows in seconds instead of minutes.

| Without Skills | With Skills |
|----------------|-------------|
| "Fetch the Jira ticket... now create a branch... what should I name it?" | "work on PROJ-123" → Done |
| You orchestrate each step | Claude handles the workflow |
| Inconsistent results | Reliable, repeatable patterns |

## Available Skills

| Skill | Description | Apps to Connect |
|-------|-------------|-----------|
| [work-on-ticket](./work-on-ticket/) | Fetches Jira ticket details, creates an appropriately named branch, and initiates task planning | Jira |
| [git-commit](./git-commit/) | Generates storytelling-focused Conventional Commits messages with Jira context integration | Jira |
| [code-review](./code-review/) | Performs comprehensive code reviews of git branches, analyzing code quality, security, performance, and best practices | Jira |

## Quick Start

### Prerequisites

1. **Claude Pro/Team account** with Skills enabled
2. **Zapier MCP** connected to Claude ([setup guide](https://zapier.com/mcp))
3. **App connections** in Zapier for the Skills you want to use

### Installation

**Claude.ai:**
1. Download the Skill folder (or clone this repo)
2. Zip the individual skill folder (e.g., `work-on-ticket/`)
3. Go to **Settings → Skills → Upload Skill**
4. Select the zipped folder

**Claude Code:**
1. Clone this repo or copy skill folders to your Claude Code skills directory
2. Skills are automatically available

### Verify It Works

After installing a skill, try one of these:

**work-on-ticket:**
```
work on PROJ-123
```

Claude should automatically fetch the Jira ticket, create an appropriately named branch, and initiate task planning.

**git-commit:**
```
commit
```

Claude should analyze your staged changes, ask for context, and generate a comprehensive commit message.

**code-review:**
```
review AGP-123
```

Claude should find the branch for that ticket and perform a comprehensive code review.

## Skill Structure

Each skill follows the standard format:

```
skill-name/
├── SKILL.md          # Main instructions (required)
├── references/       # Additional docs Claude can access
└── scripts/          # Executable code (if needed)
```

## Contributing

Currently we are not accepting contributions but feel free to create your own!

### Skill Guidelines

- **Description must include triggers**: What phrases should activate this Skill?
- **Always specify "via Zapier MCP"**: Make it clear which app is being called
- **Include examples**: Show real input → output scenarios
- **Handle errors gracefully**: What happens when a ticket isn't found or a git operation fails?

## Troubleshooting

**Skill doesn't trigger automatically**  
Try invoking explicitly: "Use the work-on-ticket skill to..." or "Use the git-commit skill to..."

**MCP connection errors**  
Verify your Zapier MCP is connected: Claude.ai → Settings → Extensions → Zapier

**Jira not responding**  
Verify your Jira connection in Zapier and ensure you have the proper permissions

## Resources

- [Zapier MCP Setup Guide](https://zapier.com/mcp)
- [Claude Skills Documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
- [Skills Best Practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
- [Anthropic Skills Repo](https://github.com/anthropics/skills)

## License

MIT License - see [LICENSE](./LICENSE) for details.

---

Built by [Zapier](https://zapier.com) ⚡