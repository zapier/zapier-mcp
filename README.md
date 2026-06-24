# Zapier MCP Server Plugin

> Official plugin distribution for [Zapier MCP](https://docs.zapier.com/mcp/home). Install the plugin in your AI client and your agent gains access to 9,000+ apps and 40,000+ actions via Zapier's hosted Model Context Protocol server.

The hosted server lives at `mcp.zapier.com/api/v1/connect` and is closed source. This repo is the discovery and installation surface: plugin manifests, onboarding skills, and lifecycle rules that help your AI client use the server correctly from the first call.

## About Zapier MCP

[Zapier MCP](https://docs.zapier.com/mcp/home) is a hosted Model Context Protocol server that connects AI assistants to 9,000+ apps. Servers run in one of two modes:

- **Agentic** — Action discovery and execution are managed in chat through built-in meta-tools.
- **Classic** — Each enabled action is exposed as a dedicated tool named `app_action_name`.

The plugin in this repo detects which mode you're on and routes accordingly. For the full mode-specific built-in tool reference and product overview, see [docs.zapier.com/mcp/home](https://docs.zapier.com/mcp/home).

https://github.com/user-attachments/assets/8304058f-67da-40b9-bc4f-5095b2817d61

## What's in this repo

- **Per-client plugin manifests** for [Claude Code](./plugins/zapier/.claude-plugin/plugin.json), [Cursor](./plugins/zapier/.cursor-plugin/plugin.json), and [GitHub Copilot CLI](./plugins/zapier/.github/plugin/plugin.json), under `plugins/zapier/`. Installing the plugin also registers the hosted MCP server with your client — that's why `zapier` shows up under `/mcp` after install, via [`.mcp.json`](./plugins/zapier/.mcp.json).
- **A Gemini CLI extension manifest** at [`gemini-extension.json`](./gemini-extension.json) so users can install with `gemini extensions install`
- **A Kiro Power bundle** under [`zapier-power/`](./zapier-power/) — `POWER.md` manifest, scoped `mcp.json`, and `steering/` files for [Kiro.dev](https://kiro.dev) consumption
- **An MCP Registry manifest** at [`server.json`](./server.json) so the hosted server is discoverable in the [official MCP Registry](https://registry.modelcontextprotocol.io)
- **Onboarding skills** for auth, action selection, and health checks ([`skills/`](./plugins/zapier/skills/))
- **Lifecycle rules** covering server-mode detection and the read/write safety model ([`zapier-lifecycle.mdc`](./plugins/zapier/rules/zapier-lifecycle.mdc))
- **Brand assets** ([`assets/`](./plugins/zapier/assets/))

What's **not** here:

- The MCP server itself — hosted at `mcp.zapier.com` (closed source)
- The action catalog — managed at [mcp.zapier.com](https://mcp.zapier.com)
- Product documentation — at [docs.zapier.com/mcp/home](https://docs.zapier.com/mcp/home)

For a routing guide to specific skills, rules, and manifests, see [AGENTS.md](./AGENTS.md).

## Install

### Claude Code

If you've already added Anthropic's official Claude Code plugin marketplace ([`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official)), install directly:

```
/plugin install zapier@claude-plugins-official
```

Otherwise, add this repo as the marketplace first:

```
/plugin marketplace add zapier/zapier-mcp
/plugin install zapier@zapier-plugins
```

### Cursor

Open [cursor.com/marketplace/zapier](https://cursor.com/marketplace/zapier) and click **Install**.

### GitHub Copilot CLI

```
copilot plugin marketplace add zapier/zapier-mcp
copilot plugin install zapier@zapier-plugins
```

### Gemini CLI

```
gemini extensions install https://github.com/zapier/zapier-mcp
```

Authenticate inside Gemini with `/mcp auth zapier`. The catalog entry is `gemini-extension.json` at the repo root.

### Kiro

Browse to [kiro.dev/powers](https://kiro.dev/powers), find Zapier, and click **Add to Kiro**. Powers register through the IDE — no command-line setup. The catalog entry is mirrored at [`kirodotdev/powers`](https://github.com/kirodotdev/powers).

### Any other MCP-compatible client

Add to your client's MCP config:

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

Then sign in at [mcp.zapier.com](https://mcp.zapier.com) when prompted.

## After install

1. **Enable actions** at [mcp.zapier.com](https://mcp.zapier.com) — each enabled action becomes a tool your AI can call.
2. **Trust but verify writes.** The lifecycle rules require explicit user confirmation before any write action runs. Read actions don't need confirmation.
3. **Run a health check.** Ask your agent to "check Zapier status" to invoke the [`zapier-status` skill](./plugins/zapier/skills/zapier-status/SKILL.md) and see what's configured.

## Downstream marketplaces

This repo is the source of truth for the plugin. It's also vendored or mirrored into the following marketplaces:

- [`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official) — Anthropic's curated Claude Code marketplace (vendors `plugins/zapier/` via `git-subdir` pinned to `main`)
- [`anthropics/knowledge-work-plugins`](https://github.com/anthropics/knowledge-work-plugins) — Anthropic's Claude Cowork marketplace (vendors `plugins/zapier/` via `git-subdir` pinned to `main`)
- [`kirodotdev/powers`](https://github.com/kirodotdev/powers) — Kiro's Powers catalog, browsable at [kiro.dev/powers](https://kiro.dev/powers); mirrors `POWER.md` and the steering files
- [`cursor/mcp-servers`](https://github.com/cursor/mcp-servers/tree/main/servers/zapier) — Cursor's MCP server registry, surfaced at [cursor.com/marketplace/zapier](https://cursor.com/marketplace/zapier)

## Documentation & support

- **Product overview**: [zapier.com/mcp](https://zapier.com/mcp)
- **Documentation**: [docs.zapier.com/mcp/home](https://docs.zapier.com/mcp/home)
- **Support**: [help.zapier.com](https://help.zapier.com)
- **For AI agents working in this repo**: [AGENTS.md](./AGENTS.md)
- **For contributors**: [CONTRIBUTING.md](./CONTRIBUTING.md)

---

*Zapier MCP is part of the [Model Context Protocol](https://modelcontextprotocol.io/) ecosystem.*
