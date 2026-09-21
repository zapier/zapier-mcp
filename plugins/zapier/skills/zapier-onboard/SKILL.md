---
name: zapier-onboard
description: Onboard a new user to Zapier MCP — introduce what it can do, walk through authentication, and route into the right flow based on the state of their setup. Use when getting started, troubleshooting connection issues, or when the user asks "what is Zapier MCP", "how do I get started with Zapier", "set me up", "what can I do with Zapier", or "tell me about Zapier".
---

# Zapier onboard

Introduce Zapier MCP, get the user authenticated, then guide them through the appropriate setup flow.

For how the Zapier MCP server itself works, see [docs.zapier.com/mcp](https://docs.zapier.com/mcp/home).

## Step 1: Introduction

Start by describing what Zapier MCP can do for the user, then get them authenticated.

### Pitch

"Zapier MCP connects your AI assistant to 9,000+ apps — Slack, Gmail, Google Calendar, Jira, Notion, HubSpot, and thousands more. Once set up, you can search across your tools, take actions, and automate workflows, all through natural conversation. It's personalized to your workflow — you pick the apps and actions that matter to you, and your AI learns to use them."

### Check connection

Check if any Zapier MCP tools are available:

- **Tools are available**: The user is already authenticated. Give a shorter version of the pitch — "You've got Zapier MCP installed and connected. Let me check what you have set up." — then proceed to Step 2.

- **No Zapier tools available at all**: The server is installed but needs authentication. First, attempt to authenticate directly in the chat by calling `mcp_auth` on the Zapier MCP server. If that succeeds, re-check available tools and proceed to Step 2.

  If `mcp_auth` fails or is unavailable, fall back to manual instructions based on their client:

  - **In Grok Bot:** "Let's get you connected. Select **Plugins**, open Zapier, and follow the authentication prompt."
  - **In Claude Desktop:** "Let's get you connected. Go to **Customize > Connectors > Zapier** and click **Connect**."
  - **In other clients:** "Let's get you connected. Find the Zapier MCP server in your client's MCP settings and click Connect. This will redirect you to mcp.zapier.com to sign in."

  Detect which client is in use from the environment or conversation context. If unclear, give the generic instructions.

  Wait for the user to confirm ("done"), then re-check available tools and proceed to Step 2.

## Step 2: Diagnose

Inspect the available Zapier MCP tools. The result determines which branch to follow:

| Result                                                       | Branch              |
| ------------------------------------------------------------ | ------------------- |
| Zapier action tools are available (beyond the configuration tools) | **Healthy**         |
| Only configuration tools available (no actions yet)          | **Fresh install**   |
| Calls fail with auth/401 errors                              | **Auth broken**     |
| No Zapier tools available at all                             | **Not connected**   |

## Branch: Healthy

The server is connected and has actions configured. Show a summary and offer next steps.

1. Look at the available Zapier MCP tools and group them by app.
2. Show a clean summary:

"Your Zapier MCP is connected with [N] tools across [app list]:

- **Slack**: ...
- **Gmail**: ...
- **Google Calendar**: ...

Everything's working. What would you like to do?"

3. Offer options:
   - "Try one live" → trigger the **zapier-demo** skill for a first-action walkthrough
   - "Add more tools" → trigger the **zapier-explore** skill to build out a role-tailored toolkit
   - "Run a health check" → trigger the **zapier-status** skill
   - Or just start using the tools

## Branch: Auth broken

The server exists in the config but authentication has expired or is invalid.

1. Tell the user:

"Your Zapier MCP server is configured but the connection is broken (authentication expired).

**[Click here to reconnect](https://mcp.zapier.com)**

Sign in, find your server, and re-authenticate. Come back and say **done** when you're finished."

2. Wait for the user to confirm.
3. Try calling a Zapier tool again to verify.
4. If it works: show the Healthy summary.
5. If it still fails: suggest deleting and recreating the server config. Offer to help update the MCP config file with a fresh token (see "MCP config by client" below).

## Branch: Not connected

The Zapier MCP server is installed via the plugin but hasn't been authenticated yet. This is the most common state on a fresh install — zero Zapier tools are visible because the server hasn't been connected.

1. Tell the user the Zapier plugin is installed but needs to be connected first.

2. Attempt to authenticate directly in the chat by calling `mcp_auth` on the Zapier MCP server. If that succeeds, skip to step 5.

3. If `mcp_auth` fails or is unavailable, fall back to manual instructions based on their client:

   - **In Grok Bot:** "Select **Plugins**, open Zapier, and follow the authentication prompt."
   - **In Claude Desktop:** "Go to **Customize > Connectors > Zapier** and click **Connect**."
   - **In other clients:** "Find the Zapier MCP server in your client's MCP settings and connect it. This will redirect you to mcp.zapier.com to sign in."

   Detect which client is in use from the environment or conversation context. If unclear, give the generic instructions.

4. Wait for the user to confirm ("done").

5. Re-diagnose by checking available Zapier MCP tools. Proceed to the appropriate branch — most likely **Fresh install** (server connected, no actions yet).

## Branch: Fresh install

The server is connected but has no actions configured. The user needs to add actions through Zapier.

### Step 1: Workflow-first discovery

Don't ask "what apps do you use?" Start with what they're trying to accomplish.

"You're connected but don't have any tools set up yet. Let's add some."

Direct the user to [mcp.zapier.com](https://mcp.zapier.com) (or call the server's configuration-URL tool if available) so they can go directly to their server's tool config page.

Then help them pick what to add based on their workflow:

**Starter kits by workflow:**

| Workflow                 | Apps                                                          | Why these                                              |
| ------------------------ | ------------------------------------------------------------- | ------------------------------------------------------ |
| **Dev workflow**         | Jira + GitLab + Slack + Google Docs                           | Issue tracking, code review, team comms, documentation |
| **PM workflow**          | Jira + Slack + Google Docs + Google Calendar + Notion         | Planning, updates, writing, scheduling, knowledge base |
| **Sales workflow**       | HubSpot + Gmail + Google Calendar + Slack                     | CRM, outreach, scheduling, team updates                |
| **Marketing workflow**   | Google Sheets + Slack + Notion + Gmail                        | Data, coordination, content, campaigns                 |
| **General productivity** | Gmail + Google Calendar + Slack + Google Docs + Google Sheets | The essentials for anyone                              |

"Pick a starter kit, or tell me what you're working on and I'll suggest the right tools."

### Step 2: Guide configuration

Recommend specific actions the user should add for each app. Aim for 2-4 actions per app: one or two search actions and one or two write actions.

**Recommended starters by app:**

| App             | Search actions                         | Write actions            |
| --------------- | -------------------------------------- | ------------------------ |
| Slack           | Find Message, Get Message              | Send Channel Message     |
| Gmail           | Find Email                             | Send Email, Create Draft |
| Google Calendar | Find Events                            | Create Detailed Event    |
| Google Docs     | Get Document Content                   | Create Document          |
| Google Sheets   | Get Data Range, Lookup Row             | Add Row                  |
| Jira            | Find Issue by Key, Find Issues via JQL | Create Issue             |
| Linear          | Find Issue                             | Create Issue             |
| GitLab          | Find Merge Requests                    | (read-heavy by nature)   |
| GitHub          | Find Issue, Find Pull Request          | Create Issue             |
| HubSpot         | Find Contact, Find Company             | Create Contact           |
| Notion          | Find Page, Find Database Item          | Create Page              |
| Zoom            | Find Meeting                           | (read-heavy)             |
| Coda            | Find Row                               | Create Row               |
| Airtable        | Find Record                            | Create Record            |

Tell the user which actions to add for their chosen apps, then wait for them to configure and authenticate everything.

"Add those actions and connect your app accounts in the Zapier dashboard. Come back and say **done** when you're finished."

### Step 3: Verify

After the user confirms, check the available Zapier MCP tools to see what was added. If new tools appeared, show a summary. If nothing changed, the user may need to reload their client (see "Reload instructions by client" below).

### Step 4: Wrap up

Once everything is connected:

1. Show a final summary of the setup.
2. Hand off to the natural next step:

"You're set up. Want to try one live? Run **/zapier-demo** to see one action work, or **/zapier-explore** if you want to keep building out the toolkit."

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

## Tone

Casual and efficient. Don't explain MCP or protocol details. Just get them to the right place fast. If something breaks, be direct: "That didn't work. Let's try..."
