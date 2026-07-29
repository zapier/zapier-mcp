![Zapier MCP](./assets/mcp-logo.png)

[![MCP Registry](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fregistry.modelcontextprotocol.io%2Fv0.1%2Fservers%2Fcom.zapier%252Fmcp%2Fversions%2Flatest&query=%24.server.version&label=MCP%20Registry&logo=modelcontextprotocol)](https://registry.modelcontextprotocol.io/v0.1/servers/com.zapier%2Fmcp/versions/latest)
[![MCP Server](https://badge.mcpx.dev?type=server&features=tools 'MCP Server')](https://modelcontextprotocol.io/)
[![License](https://img.shields.io/github/license/zapier/zapier-mcp)](./LICENSE)
[![Install in Claude Code](https://img.shields.io/badge/Claude_Code-Install_Server-D97757?style=flat-square&logo=claude&logoColor=white)](claude://code/new?q=Install%20Zapier%20MCP%20for%20me%20globally.%0A%0ARun%20this%20command%3A%0A%20%20claude%20mcp%20add%20--transport%20http%20%22Zapier-MCP%22%20https%3A//mcp.zapier.com/api/v1/connect%0A%0AThen%20give%20me%20step-by-step%20instructions%20for%20how%20to%20restart%20Claude%20Code.%20After%20restarting%2C%20use%20get_zapier_skill%20with%20name%20%22zapier%3Aonboarding%22%20and%20follow%20its%20instructions%20to%20set%20me%20up.)
[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install_Server-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](vscode:mcp/install?%7B%22name%22%3A%22zapier%22%2C%22url%22%3A%22https%3A%2F%2Fmcp.zapier.com%2Fapi%2Fv1%2Fconnect%22%2C%22type%22%3A%22http%22%2C%22icons%22%3A%7B%22src%22%3A%22https%3A%2F%2Fmcp.zapier.com%2Ficon-mcp.png%22%7D%7D)

# Zapier MCP Plugin Distribution

The official home of the [Zapier MCP](https://docs.zapier.com/mcp/home) plugin — the safest way to give an agent access to your apps. ⚡

Zapier MCP is a hosted server that gives your AI governed, credential-safe access to 9,000+ apps. Send messages, pull data, trigger workflows. All in plain English.

This plugin is the part that lives in your AI client. Install it from your client's marketplace and your assistant arrives knowing how to use Zapier well, with guided onboarding, a quick demo, and skills tailored to your role.

**Get started with the plugin** → [docs.zapier.com/mcp/clients](https://docs.zapier.com/mcp/clients)

![AI connects to Zapier MCP, which connects to Gmail, Slack, Google Sheets, Notion, HubSpot, Salesforce, Linear, Asana, and 9,000 more apps](./assets/mcp-apps-diagram.png)

## What's in this repo

- **[`plugins/zapier/`](./plugins/zapier/)**: the plugin that onboards you to Zapier MCP and supercharges your experience

## Where to install this plugin

- **Claude Code**: add [`zapier/marketplace`](https://github.com/zapier/marketplace) or [`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official) manually
- **Cursor**: [cursor.com/marketplace/zapier](https://cursor.com/marketplace/zapier), via [`cursor/mcp-servers`](https://github.com/cursor/mcp-servers/tree/main/servers/zapier)
- **VS Code**: connects directly to the hosted MCP server — use the badge above, or add `https://mcp.zapier.com/api/v1/connect` (`type: http`) manually
- **OpenAI Codex**: via [`zapier/marketplace`](https://github.com/zapier/marketplace)
- **GitHub Copilot CLI**: via [`zapier/marketplace`](https://github.com/zapier/marketplace)
- **Claude Cowork**: via [`anthropics/knowledge-work-plugins`](https://github.com/anthropics/knowledge-work-plugins)
- **Kiro**: [kiro.dev/powers](https://kiro.dev/powers)
- **Gemini CLI**: `gemini extensions install https://github.com/zapier/zapier-mcp`, then `/mcp auth zapier` — see [`gemini-extension.json`](./gemini-extension.json)

## Third-party registries

Zapier MCP is also listed on:

- [Smithery](https://smithery.ai/servers/zapier)
- [PulseMCP](https://www.pulsemcp.com/servers/zapier)

## For contributors

- [AGENTS.md](./AGENTS.md): guide for AI agents working in this repo
- [CONTRIBUTING.md](./CONTRIBUTING.md): how to contribute
- [`llms.txt`](./llms.txt): LLM discovery index
