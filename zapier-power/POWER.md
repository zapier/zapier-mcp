---
name: "zapier"
displayName: "Zapier"
description: "Connect 9,000+ apps to your AI workflow — discover, enable, and execute Zapier actions directly from your AI assistant."
keywords: ["zapier", "automation", "integrations", "workflow", "ai-actions", "mcp", "no-code", "productivity", "slack", "gmail", "jira", "notion", "hubspot"]
author: "Zapier"
---

# Zapier Power

## Overview

Connect your AI assistant to 9,000+ apps — Slack, Gmail, Google Calendar, Jira, Notion, HubSpot, and thousands more. Once set up, you can search across your tools, take actions, and automate workflows through natural conversation. Zapier MCP is personalized to your workflow: you pick the apps and actions that matter to you, and your AI learns to use them.

**Key capabilities:**

- **Cross-app workflows**: Chain reads and writes across Slack, Gmail, Jira, Notion, HubSpot, and 9,000+ other apps through natural conversation
- **Built-in safety model**: Read actions run without confirmation; write actions require explicit user approval
- **Personalized tool profiles**: Generate persistent AI instructions tailored to the specific set of actions you have enabled
- **OAuth authentication**: No API keys required — authenticate once via mcp.zapier.com and per-app OAuth flows

For how the Zapier MCP server itself works — tool surface, configuration, action management — see [docs.zapier.com/mcp](https://docs.zapier.com/mcp/home).

## When to Use This Power

Activate this Power when the user:

- Wants to send messages, create records, or trigger workflows in another app (Slack, Gmail, Jira, Notion, HubSpot, etc.)
- Asks "what can I do with Zapier", "set up Zapier", or "show me my Zapier tools"
- Mentions a specific app they want to read from or act in
- Wants to enable, disable, or audit the actions exposed by their Zapier MCP server
- Wants to generate a personalized tools profile from their enabled actions

## Onboarding

### Step 1: Connect the Zapier MCP server

After installing this power, connect the Zapier MCP server:

- **Connection:** HTTPS endpoint at `https://mcp.zapier.com/api/v1/connect`
- **Authorization:** OAuth via mcp.zapier.com (no API key required)

### Step 2: Get started

- **If Zapier tools are available**: Ask to get started with Zapier to inspect what's configured and see a first result
- **If not connected**: Attempt `mcp_auth` on the Zapier MCP server, or follow the manual connection steps above

## Available Steering Files

| File | Purpose |
|---|---|
| [`steering/zapier-connect.md`](./steering/zapier-connect.md) | Connect or reconnect the server, diagnose authentication, and reload the client |
| [`steering/zapier-quickstart.md`](./steering/zapier-quickstart.md) | First-use walkthrough — find something worth handling, show it working, offer to keep it running |
| [`steering/zapier-detect-workflows.md`](./steering/zapier-detect-workflows.md) | Notice repeated work and suggest a Zap workflow |
| [`steering/zapier-status.md`](./steering/zapier-status.md) | Health check, audit, and diagnose modes for monitoring the setup |

## When to Load Steering Files

- Connecting, reconnecting, or troubleshooting the connection → `zapier-connect.md`
- New to Zapier or wants a first result → `zapier-quickstart.md`
- Repeating a task or describing a habit worth automating → `zapier-detect-workflows.md`
- Checking tool health, auditing setup, or diagnosing broken tools → `zapier-status.md`

## Available MCP Servers

### zapier

- **Connection:** `https://mcp.zapier.com/api/v1/connect`
- **Authorization:** OAuth via mcp.zapier.com (no API key required)

For the tool surface exposed by the server, see [docs.zapier.com/mcp](https://docs.zapier.com/mcp/home).

## MCP Configuration

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

## License and support

This power integrates with [Zapier MCP](https://docs.zapier.com/mcp/home). The plugin distribution is MIT-licensed.

- [Privacy Policy](https://zapier.com/privacy)
- [Support](https://zapier.com/support)
