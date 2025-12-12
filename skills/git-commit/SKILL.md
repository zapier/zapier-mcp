---
name: Git Commit
description: Generates storytelling-focused Conventional Commits messages with Jira context integration, then commits and pushes changes. Use when the user says "commit", "git commit", or asks to commit changes, wants to create a commit, or when work is complete and ready to commit.
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git branch:*), Bash(git log:*), AskUserQuestion, mcp__zapier__jira_software_cloud_find_issue_by_key
license: MIT
metadata:
  author: Zapier
  version: 1.0.0
  mcp-server: zapier
---

# Git Commit

Generate Conventional Commits messages that tell a complete story for future code archeology, with Jira ticket context integration.

## When to Use This Skill

Activate this skill when:
- The user types "commit" or "git commit" (with or without slash command)
- The user says "commit this" or "let's commit"
- The user asks to create a commit message
- Work is complete and ready to commit
- The user mentions committing or pushing changes

## Critical Rules

**IMPORTANT: NEVER EVER ADD CO-AUTHOR TO THE GIT COMMIT MESSAGE**
**NEVER mention Claude Code in commit messages**

## Workflow

### 1. Gather Context

First, collect information about the current state:

```bash
# Current git status
git status

# Current git diff (staged changes)
git diff --staged

# Recent commits for context
git log --oneline -5

# Current branch
git branch --show-current
```

### 2. Extract Jira Ticket Context (if applicable)

Parse the current branch name to find Jira ticket IDs using these patterns:
- `PROJ-123-feature-name`
- `feature/PROJ-123-description`
- `PROJ-123`

If a Jira ticket ID is found:
- Use `mcp__zapier__jira_software_cloud_find_issue_by_key` to fetch ticket details
- Get title, description, acceptance criteria, comments
- Use this context to understand the broader purpose of the changes

### 3. Human-in-the-Loop - Ask for Context

**ALWAYS use the AskUserQuestion tool to ask WHY the change was made.**

Based on the diff and Jira context (if available), generate 3-4 plausible options for why the change was made. Present these as multiple choice options using AskUserQuestion.

**Example:**
```
Question: "Why did you make these changes?"
Options:
- "Fix bug where X was causing Y"
- "Add new feature for Z"
- "Refactor to improve maintainability"
- (User can always select "Other" to provide custom explanation)
```

The options should be specific to the actual changes observed in the diff, not generic. Analyze the code changes to infer likely motivations.

Wait for their response and incorporate their explanation into the commit message.

### 4. Analyze Technical Changes

Review the staged changes to understand WHAT changed technically:
- Files modified
- Functions added/updated
- Dependencies changed
- Configuration updates

### 5. Create Enhanced Commit Message

Generate a commit message that tells a complete story for future code archeology:

**Format:**
```
type(scope): concise subject line describing what changed

Why this change was needed:
[Incorporate the user's explanation and Jira ticket context]

What changed:
[Technical summary of the modifications]

Problem solved:
[Explain the business/technical problem this addresses]

[If Jira ticket found] Refs: PROJ-123
```

**Conventional Commits Types:**
- **feat**: new features
- **fix**: bug fixes
- **docs**: documentation changes
- **style**: formatting, missing semicolons, etc.
- **refactor**: code restructuring without changing functionality
- **test**: adding or updating tests
- **chore**: maintenance tasks, dependencies, build process
- **perf**: performance improvements
- **ci**: continuous integration changes

### 6. Execute Commit and Push (Requires Confirmation)

**IMPORTANT: Do not use `git add -A` or `git add .`**
Commit only the files that are already staged and understood.

**CRITICAL: The user MUST confirm before executing `git commit` or `git push`.**
These commands are intentionally NOT in the allowed-tools list, so the user will be prompted for approval.

After receiving the user's approval of the commit message:

1. **Commit with heredoc** (for multi-line messages):
```bash
git commit -m "$(cat <<'EOF'
type(scope): subject line

Why this change was needed:
[explanation]

What changed:
[technical summary]

Problem solved:
[problem description]

Refs: PROJ-123
EOF
)"
```

2. **Push**:
```bash
git push
```

## Storytelling Emphasis

Create commit messages that future developers will appreciate when doing code archeology months later. The message should answer:

- **What** changed? (technical summary)
- **Why** was this needed? (business context, user explanation)
- **What problem** does it solve? (from Jira ticket and user input)
- **How** does it relate to the larger feature/project? (Jira context)

## Examples

### Example 1: Feature with Jira Context

```
feat(mcp): add tool execution timeout handling

Why this change was needed:
Tools were hanging indefinitely when external APIs failed to respond,
blocking the entire MCP server. This was causing user-facing timeouts
in the chat interface.

What changed:
- Added configurable timeout wrapper around tool execution
- Implemented graceful timeout error messages
- Updated tool registry to support per-tool timeout configuration

Problem solved:
External API failures no longer block the MCP server. Users now receive
clear timeout errors instead of indefinite hanging.

Refs: AGP-582
```

### Example 2: Bug Fix

```
fix(auth): prevent token refresh race condition

Why this change was needed:
Multiple simultaneous requests were triggering concurrent token refresh
attempts, causing some requests to fail with stale tokens.

What changed:
- Added mutex lock around token refresh logic
- Implemented token refresh deduplication
- Added retry logic for failed requests during refresh

Problem solved:
Concurrent requests no longer cause authentication failures due to
token refresh race conditions.
```

### Example 3: Refactoring

```
refactor(api): extract validation logic to shared module

Why this change was needed:
Input validation was duplicated across 7 different API endpoints,
making it difficult to maintain consistent validation rules.

What changed:
- Created shared validation utilities in packages/validation
- Updated all API endpoints to use shared validators
- Removed 200+ lines of duplicated validation code

Problem solved:
Validation logic is now centralized and consistent across all endpoints.
Future validation changes only need to be made in one place.
```

## Important Notes

- **Never skip the "why" question** - User context is crucial
- **Use heredoc for multi-line commits** - Ensures proper formatting
- **Reference Jira tickets** when found in branch name
- **Be specific** in technical summaries
- **Think about the reader** - someone debugging this code in 6 months
- **No co-authors** - Never add "Co-Authored-By" or mention Claude Code
