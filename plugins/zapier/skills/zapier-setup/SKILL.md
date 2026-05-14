---
name: zapier-setup
description: Set up Zapier MCP and add tools to your AI assistant. Introduces what Zapier can do, walks through authentication, detects your server mode, then branches into the right flow — summary for healthy setups, reconnect for broken auth, onboarding for fresh installs, or config help when the server is missing. Use when getting started, troubleshooting connection issues, adding new tools, or when the user asks "what can I do now", "what can I do with Zapier", "show me how the Zapier plugin works", "what is Zapier MCP", "how does Zapier work", or "tell me about Zapier".
---

# Zapier setup

Introduce Zapier MCP, get the user authenticated, detect their server mode, then guide them through the appropriate setup flow.

## Step 1: Introduction

Start by describing what Zapier MCP can do for the user, then get them authenticated.

### Pitch

"Zapier MCP connects your AI assistant to 9,000+ apps — Slack, Gmail, Google Calendar, Jira, Notion, HubSpot, and more. You pick the apps and actions, then search, take actions, and automate workflows through natural conversation."

### Check connection

Check if any Zapier MCP tools are available:

- **Tools are available** (either Agentic meta-tools or Classic action tools): The user is already authenticated. Give a shorter version of the pitch — "You've got Zapier MCP installed and connected. Let me check what you have set up." — then proceed to Step 2.

- **No Zapier tools available at all**: The server is installed but needs authentication. First, attempt to authenticate directly in the chat by calling `mcp_auth` on the Zapier MCP server. If that succeeds, re-check available tools and proceed to Step 2.

  If `mcp_auth` fails or is unavailable, fall back to manual instructions based on their client:

  - **In Cursor:** "Let's get you connected. Go to **Settings > Cursor Settings > Tools & MCP** and click **Connect** next to the Zapier MCP server. You can also press **Cmd+Shift+P** and search for 'MCP' to get there quickly."
  - **In Claude Desktop:** "Let's get you connected. Go to **Customize > Connectors > Zapier** and click **Connect**."
  - **In other clients:** "Let's get you connected. Find the Zapier MCP server in your client's MCP settings and click Connect. This will redirect you to mcp.zapier.com to sign in."

  Detect which client is in use from the environment or conversation context. If unclear, give the generic instructions.

  Wait for the user to confirm ("done"), then re-check available tools and proceed to Step 2.

## Step 2: Detect mode

Check which tools are available to determine the server mode:

- **Agentic mode**: `list_enabled_zapier_actions` is available as a tool. Call `get_zapier_skill` with name `"zapier-mcp-onboarding"` on the Zapier MCP server and follow its instructions. If authentication is needed, help the user through it, then retry the call. **Do not continue with the steps below** — the Zapier-hosted onboarding skill handles the entire Agentic setup flow.

- **Classic mode**: `get_configuration_url` and/or individual `app_action_name` tools are present, but `list_enabled_zapier_actions` is not. Continue to Step 3.

## Step 3: Diagnose

This step applies only to **Classic mode**.

Try calling `get_configuration_url` or any Zapier tool. The result determines which branch to follow:

| Result                                                        | Branch              |
| ------------------------------------------------------------- | ------------------- |
| Zapier action tools are available (e.g., `gmail_send_email`)  | **Healthy**         |
| Only `get_configuration_url` is available (no action tools)   | **Fresh install**   |
| Fails with auth/401 error                                     | **Auth broken**     |
| No Zapier tools available at all (server not connected)       | **Not connected**   |

## Branch: Healthy

The server is connected and has action tools configured. Show a summary and offer next steps.

1. Look at the available Zapier MCP tools. Each action tool follows the naming pattern `app_action_name` (e.g., `slack_send_channel_message`, `gmail_find_email`). Identify the app from the tool description (e.g., "Send a **Slack** channel message" → Slack).
2. Group tools by app and show a clean summary:

"Your Zapier MCP is connected with [N] tools across [app list]:

- **Slack**: `slack_send_channel_message`, `slack_find_message`, `slack_get_message`
- **Gmail**: `gmail_find_email`, `gmail_send_email`
- **Google Calendar**: `google_calendar_find_events`, `google_calendar_create_event`

Everything's working. What would you like to do?"

3. Offer options:
   - "Add more tools" → call `get_configuration_url` and direct the user there
   - "Run a health check" → trigger the **zapier-status** skill
   - "Create my tools profile" → trigger the **create-my-tools-profile** skill
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
5. If it still fails: suggest deleting and recreating the server config. Offer to help update the MCP config file with a fresh token (see [CLIENT_REFERENCE.md](CLIENT_REFERENCE.md)).

## Branch: Not connected

The Zapier MCP server is installed via the plugin but hasn't been authenticated yet.

1. Tell the user the Zapier plugin is installed but needs to be connected first.
2. Follow the authentication flow from **Step 1 > Check connection** (attempt `mcp_auth` first, fall back to client-specific manual instructions). If `mcp_auth` succeeds, skip to step 4.
3. Wait for the user to confirm ("done").
4. Re-diagnose by checking available Zapier MCP tools. Proceed to the appropriate branch — most likely **Fresh install** (server connected, no action tools yet).

## Branch: Fresh install

The server is connected but has no action tools. The user needs to add actions through the web UI.

### Step 1: Workflow-first discovery

Don't ask "what apps do you use?" Start with what they're trying to accomplish.

"You're connected but don't have any tools set up yet. Let's add some."

Call `get_configuration_url` and share the returned URL so the user can go directly to their server's tool config page.

Then help them pick what to add based on their workflow. Refer to [STARTER_KITS.md](STARTER_KITS.md) for workflow-based starter kits and per-app action recommendations.

"Pick a starter kit, or tell me what you're working on and I'll suggest the right tools."

### Step 2: Guide configuration

Recommend specific actions the user should add for each app in the web UI using the per-app recommendations from [STARTER_KITS.md](STARTER_KITS.md). Tell the user which actions to add for their chosen apps, then wait for them to configure and authenticate everything in the web UI.

"Add those actions and connect your app accounts in the Zapier dashboard. Come back and say **done** when you're finished."

### Step 3: Verify

After the user confirms, check the available Zapier MCP tools to see what was added. If new action tools appeared, show a summary. If nothing changed, the user may need to reload their client (see [CLIENT_REFERENCE.md](CLIENT_REFERENCE.md)).

### Step 4: Generate profile

Once everything is connected:

1. Show a final summary of the setup.
2. Offer to generate personalized instructions:

"Want me to create a tools profile? It teaches your AI exactly when and how to use each of these tools in future conversations."

If yes, follow the **create-my-tools-profile** skill.

## Client reference

See [CLIENT_REFERENCE.md](CLIENT_REFERENCE.md) for MCP config file paths and reload instructions per client.

## Tone

Casual and efficient. Don't explain MCP or protocol details. Just get them to the right place fast. If something breaks, be direct: "That didn't work. Let's try..."
