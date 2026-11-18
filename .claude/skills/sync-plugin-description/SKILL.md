---
name: sync-plugin-description
description: Keep the Zapier MCP one-line description identical across every plugin manifest in this repo, using the official MCP registry entry as the source of truth. Use when the user changes, rewords, or asks about the plugin description, the app count (e.g. "9,000+" → "10,000+"), pastes MCP registry JSON, edits any plugin.json / marketplace.json / gemini-extension.json / POWER.md description, or resolves a merge conflict on a description field.
---

# Sync the plugin description

Every client manifest carries the same one-line description. When one changes, all of them change. This stops the clients from drifting apart and keeps merge conflicts to one string.

## Source of truth

The latest (`isLatest: true`) `com.zapier/mcp` entry in the official MCP registry:

```
curl -s 'https://registry.modelcontextprotocol.io/v0/servers?search=com.zapier/mcp' \
  | python3 -c 'import json,sys; print(next(s["server"]["description"] for s in json.load(sys.stdin)["servers"] if s["_meta"]["io.modelcontextprotocol.registry/official"]["isLatest"]))'
```

If the user pastes registry JSON, use the `isLatest: true` entry from it. If the user gives new wording that isn't in the registry yet, use their wording, and tell them the registry entry needs publishing to match.

## Files that carry the description

| File | Field |
|---|---|
| `plugins/zapier/.claude-plugin/plugin.json` | `description` |
| `plugins/zapier/.codex-plugin/plugin.json` | `description` |
| `plugins/zapier/.cursor-plugin/plugin.json` | `description` |
| `plugins/zapier/.github/plugin/plugin.json` | `description` |
| `plugins/zapier/.antigravity-plugin/plugin.json` | `description` |
| `.cursor-plugin/marketplace.json` | `plugins[].description` (the Zapier entry, not the top-level marketplace description) |
| `gemini-extension.json` | `description` |
| `zapier-power/POWER.md` | frontmatter `description` |

If a new client manifest is added, add it to this table.

## Not synced (longer copy, edit on purpose)

These paragraphs describe the product in more words. Do not overwrite them with the one-liner. Do check that numbers like the app count still agree with the description:

- `README.md`, `plugins/zapier/README.md`, `AGENTS.md`, `llms.txt`
- `zapier-power/POWER.md` body
- Codex `interface.shortDescription` / `interface.longDescription`

## Steps

1. Get the target description from the source of truth.
2. Update the field in every file in the table.
3. Validate JSON: `for f in plugins/zapier/.*-plugin/plugin.json plugins/zapier/.github/plugin/plugin.json .cursor-plugin/marketplace.json gemini-extension.json; do python3 -m json.tool "$f" >/dev/null || echo "BAD $f"; done`
4. Confirm they match: `grep -rlF --exclude-dir=.git "<new description>" . | grep -v SKILL.md | wc -l` should print 8.
5. Grep for stale numbers in the long-form copy (e.g. `grep -rn --exclude-dir=.git '9,000+' .`). Report what's left to the user. Don't silently rewrite marketing prose.
6. Commit all of it as one change.

## Merge conflicts

If a conflict lands on a description field, resolve it to the current registry description in every file, not just the conflicted one.
