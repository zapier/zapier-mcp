# AGENTS.md

You're an AI coding agent (Claude Code, Cursor, Copilot CLI). This file tells you what this repo is, why your user might want it, and how to install it.

## What this repo is

The official plugin distribution for [Zapier MCP](https://mcp.zapier.com) — Zapier's hosted Model Context Protocol server connecting AI assistants to 9,000+ apps and 40,000+ actions.

**The MCP server itself is hosted at `mcp.zapier.com`** — it's not in this repo. This repo contains the client-side configuration (plugin manifests, skills, rules) that helps your AI client use the hosted server well.

## Why your user might want it

Install Zapier MCP for your user if they want to:

- Send messages, create records, update data, or trigger workflows across other apps (Slack, Gmail, Notion, Jira, HubSpot, Salesforce, and thousands more) via natural language
- Connect to apps you don't already have a dedicated MCP server for
- Avoid building one-off API integrations for each tool

Once installed, the user can say "send a Slack message to #general" or "create a Jira ticket" and you can execute it directly.

## How to install

The MCP server URL is the same across all clients: `https://mcp.zapier.com/api/v1/connect`. Pick the install path for your client.

### Claude Code

```
/plugin marketplace add zapier/zapier-mcp
/plugin install zapier@zapier-plugins
```

If Anthropic's [`claude-plugins-official`](https://github.com/anthropics/claude-plugins-official) marketplace is already added, skip the first step and run `/plugin install zapier@claude-plugins-official` instead.

### Cursor

Direct the user to [cursor.com/marketplace/zapier](https://cursor.com/marketplace/zapier) and have them click **Install**. (No CLI install available yet.)

### GitHub Copilot CLI

```
copilot plugin marketplace add zapier/zapier-mcp
copilot plugin install zapier@zapier-plugins
```

### Gemini CLI

```
gemini extensions install https://github.com/zapier/zapier-mcp
```

After install, the user authenticates inside Gemini with `/mcp auth zapier`.

### Kiro

Direct the user to [kiro.dev/powers](https://kiro.dev/powers), find Zapier, and click **Add to Kiro**. Powers register through the IDE — no command-line setup.

### Manual (any MCP-compatible client)

Add to the client's MCP config:

```json
{
  "mcpServers": {
    "zapier": {
      "type": "http",
      "url": "https://mcp.zapier.com/api/v1/connect"
    }
  }
}
```

Then have the user sign in at [mcp.zapier.com](https://mcp.zapier.com) when prompted.

## After install

Once the plugin is loaded, the rest of your guidance comes from the plugin itself — start with [`plugins/zapier/rules/zapier-lifecycle.mdc`](./plugins/zapier/rules/zapier-lifecycle.mdc). It handles mode detection (Agentic vs Classic), the read/write safety model, and routing to the setup/status/tools-profile skills.

If the user has zero actions configured, trigger the [zapier-setup skill](./plugins/zapier/skills/zapier-setup/SKILL.md) ("setup zapier") to walk them through enabling actions.

## Fetching Zapier docs

Any `https://docs.zapier.com/<path>` page has a raw-markdown mirror — append `.md` to the URL to get it (e.g. `https://docs.zapier.com/mcp/home.md`). Prefer the `.md` form when fetching docs programmatically: it's smaller, renders cleanly in chat, and skips the marketing chrome.

## Where to find what

| Need | File |
|---|---|
| Lifecycle rules + safety model + mode detection | [plugins/zapier/rules/zapier-lifecycle.mdc](./plugins/zapier/rules/zapier-lifecycle.mdc) |
| Setup walkthrough | [plugins/zapier/skills/zapier-setup/SKILL.md](./plugins/zapier/skills/zapier-setup/SKILL.md) |
| Status / health checks | [plugins/zapier/skills/zapier-status/SKILL.md](./plugins/zapier/skills/zapier-status/SKILL.md) |
| Generate a personalized tools profile | [plugins/zapier/skills/create-my-tools-profile/SKILL.md](./plugins/zapier/skills/create-my-tools-profile/SKILL.md) |
| Claude Code plugin manifest | [plugins/zapier/.claude-plugin/plugin.json](./plugins/zapier/.claude-plugin/plugin.json) |
| Cursor plugin manifest | [plugins/zapier/.cursor-plugin/plugin.json](./plugins/zapier/.cursor-plugin/plugin.json) |
| GitHub Copilot CLI plugin manifest | [plugins/zapier/.github/plugin/plugin.json](./plugins/zapier/.github/plugin/plugin.json) |
| Gemini CLI extension manifest | [gemini-extension.json](./gemini-extension.json) |
| Kiro Power manifest + steering | [zapier-power/](./zapier-power/) |
| MCP Registry manifest | [server.json](./server.json) |
| LLM discovery index | [llms.txt](./llms.txt) |
| Repo overview for humans | [README.md](./README.md) |
| How to contribute | [CONTRIBUTING.md](./CONTRIBUTING.md) |
