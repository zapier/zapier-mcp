# Zapier MCP Plugin Distribution

The official home of the [Zapier MCP](https://docs.zapier.com/mcp/home) plugin! ⚡

Zapier MCP is a hosted server that connects your AI to 9,000+ apps. Send messages, pull data, trigger workflows. All in plain English.

This plugin is the part that lives in your AI client. Install it from your client's marketplace and your assistant arrives knowing how to use Zapier well, with guided onboarding, a quick demo, and skills tailored to your role.

**Get started with the plugin** → [docs.zapier.com/mcp/clients](https://docs.zapier.com/mcp/clients)

https://github.com/user-attachments/assets/8304058f-67da-40b9-bc4f-5095b2817d61

## What's in this repo

- **[`plugins/zapier/`](./plugins/zapier/)**: the plugin that onboards you to Zapier MCP and supercharges your experience

## Where to install this plugin

This repo doesn't host its own marketplace — install the plugin through one of these:

- [`zapier/marketplace`](https://github.com/zapier/marketplace): Zapier's marketplace for coding agents, covering this plugin plus every other Zapier plugin (Notion, Google Sheets, the SDK, and more)
- [`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official): Anthropic's curated Claude Code marketplace
- [`anthropics/knowledge-work-plugins`](https://github.com/anthropics/knowledge-work-plugins): Anthropic's Claude Cowork marketplace
- [`kirodotdev/powers`](https://github.com/kirodotdev/powers): Kiro's Powers catalog, browsable at [kiro.dev/powers](https://kiro.dev/powers)
- [`cursor/mcp-servers`](https://github.com/cursor/mcp-servers/tree/main/servers/zapier): Cursor's MCP server registry, surfaced at [cursor.com/marketplace/zapier](https://cursor.com/marketplace/zapier)

All of these pull the plugin straight from [`plugins/zapier/`](./plugins/zapier/) in this repo, so they always stay in sync with it.

Gemini CLI is the one exception — it installs directly from this repo's root, not through an external marketplace:

```
gemini extensions install https://github.com/zapier/zapier-mcp
```

Authenticate inside Gemini with `/mcp auth zapier`. The catalog entry is [`gemini-extension.json`](./gemini-extension.json) at the repo root, auto-indexed into the [Gemini CLI Extensions gallery](https://geminicli.com/extensions).

## Third-party registries

Zapier MCP is also listed on:

- [Smithery](https://smithery.ai/servers/zapier)
- [PulseMCP](https://www.pulsemcp.com/servers/zapier)

## For contributors

- [AGENTS.md](./AGENTS.md): guide for AI agents working in this repo
- [CONTRIBUTING.md](./CONTRIBUTING.md): how to contribute
- **Per-client manifests**: [Claude Code](./plugins/zapier/.claude-plugin/plugin.json), [OpenAI Codex](./plugins/zapier/.codex-plugin/plugin.json), [Cursor](./plugins/zapier/.cursor-plugin/plugin.json), [GitHub Copilot CLI](./plugins/zapier/.github/plugin/plugin.json), and [Gemini CLI](./gemini-extension.json)
- [`llms.txt`](./llms.txt): LLM discovery index

---

*Zapier MCP is part of the [Model Context Protocol](https://modelcontextprotocol.io/) ecosystem.*
