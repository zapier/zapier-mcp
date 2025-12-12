# Zapier MCP Skills

This project contains Skills that enhance Claude's ability to work with Zapier MCP integrations.

## Automatic Skill Triggers

Automatically invoke these skills when you detect matching patterns:

| Trigger | Skill |
|---------|-------|
| "work on [TICKET_ID]", "start on [TICKET_ID]", "pick up [TICKET_ID]", "[TICKET_ID]"| `work-on-ticket` |
| "commit", "git commit", or asks to commit changes, wants to create a commit, or when work is complete and ready to commit | `git-commit` |
| "review MR", "review PR", "summarize MR", "PR context", shares MR/PR link | `code-review` |

Never perform these workflows manually when a skill exists - always invoke the appropriate skill.

## Skill Invocation Guidelines

When a user's request matches a skill trigger:

1. **Invoke the skill immediately** - Don't ask for permission or confirmation
2. **Use Zapier MCP for all external service calls** - Always specify the app (e.g., "via Zapier MCP (Jira)")
3. **Follow the skill's workflow steps** - Don't skip steps or take shortcuts
4. **Present confirmations before destructive actions** - Deleting branches, creating CRM records, etc.

## When Multiple Skills Could Apply

If a request could trigger multiple skills:

- Choose the most specific skill for the task
- If genuinely ambiguous, ask the user which workflow they want
- Skills can be combined when the user's intent spans multiple workflows

## Prerequisites Reminder

Before invoking any skill, verify:

- Zapier MCP is connected
- Required app connections exist (check skill's Prerequisites section)
- User has provided necessary context (e.g., ticket ID for `work-on-ticket`)

If prerequisites aren't met, inform the user what's needed before proceeding.