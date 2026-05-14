# Client reference

MCP configuration paths and reload instructions per client. Referenced by the zapier-setup skill.

## MCP config by client

| Client         | Config file location                                                      | Scope          |
| -------------- | ------------------------------------------------------------------------- | -------------- |
| Cursor         | `.cursor/mcp.json` (project) or `~/.cursor/mcp.json` (global)             | Project/Global |
| Claude Desktop | `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) | Global         |
| Claude Code    | `.mcp.json` (project) or `~/.claude/mcp.json` (global)                    | Project/Global |
| Windsurf       | `~/.codeium/windsurf/mcp_config.json`                                     | Global         |

Detect which client is in use from the environment or conversation context. If unclear, ask.

## Reload instructions by client

| Client         | How to reload                                 |
| -------------- | --------------------------------------------- |
| Cursor         | Cmd+Shift+P → "Reload Window"                 |
| Claude Desktop | Quit and reopen the app                       |
| Claude Code    | Run `/mcp` to check status, restart if needed |
| Windsurf       | Cmd+Shift+P → "Reload Window"                 |
