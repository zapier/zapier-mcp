<p align="center">
  <img src="./assets/mcp-logo.png" alt="Zapier MCP" width="480">
</p>

<h1 align="center">Zapier MCP Plugin Distribution</h1>

<p align="center">
  Governed access to 10,000+ apps for any MCP-compatible AI client.<br>
  Send messages, pull data, trigger workflows, all in plain English. ⚡
</p>

<div align="center">

[![MCP Registry](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fregistry.modelcontextprotocol.io%2Fv0.1%2Fservers%2Fcom.zapier%252Fmcp%2Fversions%2Flatest&query=%24.server.version&label=MCP%20Registry&logo=modelcontextprotocol)](https://registry.modelcontextprotocol.io/v0.1/servers/com.zapier%2Fmcp/versions/latest) [![MCP Server](https://badge.mcpx.dev?type=server&features=tools 'MCP Server')](https://modelcontextprotocol.io/) [![License](https://img.shields.io/github/license/zapier/zapier-mcp)](./LICENSE)

[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install_Server-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=zapier&config=%7B%22type%22%3A%22http%22%2C%22url%22%3A%22https%3A%2F%2Fmcp.zapier.com%2Fapi%2Fv1%2Fconnect%22%7D) [![Install MCP Server](https://cursor.com/deeplink/mcp-install-dark.svg)](https://cursor.com/install-mcp?name=zapier&config=eyJ1cmwiOiAiaHR0cHM6Ly9tY3AuemFwaWVyLmNvbS9hcGkvdjEvY29ubmVjdCJ9)

</div>

---

[Zapier MCP](https://docs.zapier.com/mcp/home) gives any MCP-compatible AI client governed access to 10,000+ apps. No code, no infrastructure, SOC 2 Type II certified.

This repo distributes the Zapier MCP plugin, the part that lives in your AI client. Install it from your client's marketplace and your assistant arrives knowing how to use Zapier well, with a guided first run and skills that spot repeated work.

## What's in this repo

- **[`plugins/zapier/`](./plugins/zapier/)**: the plugin that onboards you to Zapier MCP and supercharges your experience

## Getting started

Connecting Zapier MCP to your AI client only takes a server URL. See [docs.zapier.com/mcp/clients](https://docs.zapier.com/mcp/clients) for step-by-step instructions for every supported client.

A few clients also install the plugin distributed from this repo, which layers a guided first run and skills that spot repeated work on top of that base connection:

| Client | Install |
| --- | --- |
| **Claude Code** | Add [`zapier/marketplace`](https://github.com/zapier/marketplace) or [`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official) |
| **Cursor** | Use the badge above, or add [`cursor/mcp-servers`](https://github.com/cursor/mcp-servers/tree/main/servers/zapier) |
| **OpenAI Codex**, **GitHub Copilot CLI** | Add [`zapier/marketplace`](https://github.com/zapier/marketplace) |
| **Claude Cowork** | Add [`anthropics/knowledge-work-plugins`](https://github.com/anthropics/knowledge-work-plugins) |
| **Kiro** | Via [kiro.dev/powers](https://kiro.dev/powers) |
| **Gemini CLI** | `gemini extensions install https://github.com/zapier/zapier-mcp`, then `/mcp auth zapier` (see [`gemini-extension.json`](./gemini-extension.json)) |

VS Code connects directly to the hosted MCP server rather than through a plugin. Use the badge above, or add `https://mcp.zapier.com/api/v1/connect` (`type: http`) manually.

## Third-party registries

Zapier MCP is also listed on [Smithery](https://smithery.ai/servers/zapier) and [PulseMCP](https://www.pulsemcp.com/servers/zapier).

## For contributors

- [AGENTS.md](./AGENTS.md): guide for AI agents working in this repo
- [CONTRIBUTING.md](./CONTRIBUTING.md): how to contribute
- [llms.txt](./llms.txt): LLM discovery index
