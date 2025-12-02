# Zapier MCP Skills

Pre-built Skills that supercharge your Zapier MCP integration with Claude. These Skills turn raw tool access into reliable, optimized workflows—so Claude knows not just *what* it can do, but *how* to do it well.

## What are Skills?

**Zapier MCP** gives Claude access to 7,000+ apps through a universal API.  
**Skills** teach Claude the best workflows for common tasks.

Together, they let you accomplish complex multi-app workflows in seconds instead of minutes.

| Without Skills | With Skills |
|----------------|-------------|
| "Search HubSpot for... now create a task... wait, let me also check Gmail..." | "Update CRM with this meeting" → Done |
| You orchestrate each step | Claude handles the workflow |
| Inconsistent results | Reliable, repeatable patterns |

## Available Skills

| Skill | Description | Apps to Connect |
|-------|-------------|-----------|
| [ai-powered-crm-updates](./ai-powered-crm-updates/) | Transform meeting notes into CRM records with contacts, companies, and follow-up tasks | HubSpot/Salesforce, Gmail |
| [digital-ea](./digital-ea/) | Analyze your calendar, email, and Slack to align daily work with priorities | Google Calendar, Gmail, Slack |
| [code-review-context](./code-review-context/) | Assemble full context for MRs from tickets and design docs | GitLab/GitHub, Jira, Notion |

## Quick Start

### Prerequisites

1. **Claude Pro/Team account** with Skills enabled
2. **Zapier MCP** connected to Claude ([setup guide](https://zapier.com/mcp))
3. **App connections** in Zapier for the Skills you want to use

### Installation

**Claude.ai:**
1. Download the Skill folder (or clone this repo)
2. Zip the individual skill folder (e.g., `ai-powered-crm-updates/`)
3. Go to **Settings → Skills → Upload Skill**
4. Select the zipped folder

**Claude Code:**
1. Clone this repo or copy skill folders to your Claude Code skills directory
2. Skills are automatically available

### Verify It Works

After installing the CRM Updates skill, try:

```
Update CRM with this:

Met with Jane Smith from Acme Corp today. 
Discussed Q1 goals. She wants a proposal by Friday.
jane@acme.com
```

Claude should automatically search your CRM, create/update records, and set up follow-up tasks.

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
- **Handle errors gracefully**: What happens when a CRM search returns nothing?

## Troubleshooting

**Skill doesn't trigger automatically**  
Try invoking explicitly: "Use the ai-powered-crm-updates skill to..."

**MCP connection errors**  
Verify your Zapier MCP is connected: Claude.ai → Settings → Extensions → Zapier

**Wrong app being used**  
If you have multiple CRMs connected, specify which one: "Update HubSpot with this meeting"

## Resources

- [Zapier MCP Setup Guide](https://zapier.com/mcp)
- [Claude Skills Documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
- [Skills Best Practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
- [Anthropic Skills Repo](https://github.com/anthropics/skills)

## License

MIT License - see [LICENSE](./LICENSE) for details.

---

Built by [Zapier](https://zapier.com) ⚡