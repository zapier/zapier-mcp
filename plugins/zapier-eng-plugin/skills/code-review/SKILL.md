---
name: Code Review
description: Performs comprehensive code reviews of git branches, analyzing code quality, security, performance, and best practices. Use when the user says "review" or "code review" or asks to review pull requests, merge requests, or analyze branch changes before merging.
allowed-tools: mcp__zapier__jira_software_cloud_find_issue_by_key, Bash(git log:*), Bash(git diff:*), Bash(git show:*), Bash(git branch:*), Bash(git rev-parse:*), Bash(git status:*), Bash(git checkout:*), Bash(git fetch:*), Bash(git worktree:*), Bash(rm -rf:*), Bash(cat:*), Bash(pwd), Bash(cd *), Bash(pnpm:*), Bash(ls:*), Grep, Glob, Read, Write
license: MIT
metadata:
  author: Zapier
  version: 1.0.0
  mcp-server: zapier
---

# Code Review

Perform comprehensive code reviews of a branch against the base branch, providing actionable feedback on code quality, security, performance, and best practices.

## When to Use This Skill

Activate this skill when:
- The user types "review" or "code review" (with or without slash command)
- The user types "review BRANCH-NAME" to review a specific branch
- The user types "review TICKET-ID" (e.g., "review AGP-123" or "review AICC-456") to review the branch associated with a Jira ticket
- The user asks to review a branch, pull request, or merge request
- Analyzing code changes before merging
- Performing code quality assessments
- Checking for security vulnerabilities or performance issues
- Reviewing branch diffs

## Branch Selection

### Jira Ticket ID Detection

**If a Jira ticket ID is provided** (e.g., "review AGP-123" or "review AICC-456"):

A Jira ticket ID matches the pattern: uppercase letters followed by a hyphen and numbers (e.g., `AGP-123`, `AICC-456`).

1. Fetch latest from origin: `git fetch origin`
2. Find the branch containing the ticket ID:
   ```bash
   git branch -r | grep -i "<TICKET-ID>" | head -1
   ```
3. If a matching branch is found, extract the branch name (remove `origin/` prefix)
4. Set up a git worktree for isolated review (see Worktree Setup below)
5. Proceed with the review in the worktree
6. Clean up the worktree after review is complete

### Worktree Setup for Non-Disruptive Reviews

When reviewing a branch that isn't the current branch (either from a ticket ID or explicit branch name), use a git worktree to avoid disturbing the current working state:

1. Create a worktree directory at `<repo-root>/.worktrees/<branch-name>`:
   ```bash
   git worktree add .worktrees/<branch-name> origin/<branch-name>
   ```
2. Perform all review operations within the worktree directory
3. After the review is complete, remove the worktree:
   ```bash
   git worktree remove .worktrees/<branch-name>
   ```

**Important**: Always use the worktree path when reading files or running git commands during the review. This ensures the user's current work remains untouched.

### Dependency Installation in Worktrees

When setting up a worktree, install dependencies if you need to run checks (tests, type checking, linting):

1. **Detect package manager**: Check for `pnpm-lock.yaml` in the worktree
2. **Install dependencies**:
   ```bash
   cd <worktree-path> && pnpm install
   ```
3. **Run checks** (optional, if needed for thorough review):
   ```bash
   cd <worktree-path> && pnpm check
   ```

**When to install dependencies:**
- When you need to run tests, type checking, or linting
- When reviewing changes that affect build or compilation
- When the review requires verifying the code actually works

**When to skip dependency installation:**
- Simple reviews that only need to examine diffs
- Quick reviews of documentation or config changes
- When the user only wants a high-level code review

### Branch Name Provided

**If a branch name is provided** (e.g., "review AGP-738-show-manage-admins-button"):
1. Fetch latest from origin: `git fetch origin`
2. Set up a git worktree for the branch (see Worktree Setup above)
3. Proceed with the review in the worktree
4. Clean up the worktree after review

### No Branch Specified

**If no branch name is provided** (e.g., just "review"):
1. Review the current branch as-is in the current directory
2. Do not create a worktree or switch branches

### Worktree Error Handling

**If the worktree already exists:**
```bash
# Remove existing worktree first
git worktree remove .worktrees/<branch-name> --force 2>/dev/null || true
git worktree add .worktrees/<branch-name> origin/<branch-name>
```

**If no matching branch is found for a ticket ID:**
- Inform the user that no branch containing the ticket ID was found
- List available branches that might be related (partial matches)
- Ask the user to provide the exact branch name

**Always clean up worktrees:**
- Even if the review encounters errors, attempt to clean up the worktree
- Use `git worktree list` to verify cleanup was successful

### .gitignore Recommendation

The `.worktrees` directory should be added to `.gitignore` if not already present. Check and suggest adding it if missing:
```
# Code review worktrees
.worktrees/
```

## Analyze Branch Context

First, gather essential information about the branch to review:

- Identify the current branch name
- Determine the appropriate base branch (staging, main, or master)
- Check for any uncommitted changes that should be reviewed
- **Find the merge-base** to isolate only commits made in this branch
- Get the list of commits and changed files

### Finding Branch-Specific Changes (CRITICAL)

**You MUST use `git merge-base` to find the common ancestor.** This ensures you only review commits that were made in THIS branch, not commits from other branches that happened to be merged into main.

```bash
# 1. Find the merge-base (common ancestor)
MERGE_BASE=$(git merge-base origin/main HEAD)

# 2. List only commits IN THIS BRANCH (not in main)
git log --oneline $MERGE_BASE..HEAD

# 3. Show files changed ONLY BY THIS BRANCH
git diff --name-status $MERGE_BASE..HEAD

# 4. Show the actual diff ONLY FOR THIS BRANCH
git diff $MERGE_BASE..HEAD
```

**Why this matters:**
- `git diff origin/main..HEAD` shows ALL differences between main and HEAD, which includes changes from OTHER branches that were merged into main after this branch was created
- `git diff $(git merge-base origin/main HEAD)..HEAD` shows ONLY the changes introduced in THIS branch

**Example:**
```
main:    A---B---C---D---E  (where D and E are from other merged branches)
              \
feature:       X---Y---Z  (this is what we want to review)

# WRONG: git diff origin/main..HEAD
# Shows: differences from E to Z (includes D and E changes we don't care about)

# CORRECT: git diff $(git merge-base origin/main HEAD)..HEAD
# Shows: only X, Y, Z changes (merge-base is B)
```

**Always use the merge-base approach for:**
- `git log` - to list commits
- `git diff` - to see changes
- `git diff --stat` - for change statistics
- `git diff --name-status` - for file list

## Perform Comprehensive Code Review

Conduct a thorough review of **only the changes introduced in this branch** (using merge-base as described above).

### 1. Change Analysis

- Use `git diff $(git merge-base origin/main HEAD)..HEAD -- <file>` to review each modified file
- Examine commits using `git show <commit-hash>` for individual commits in the branch
- Identify patterns across changes
- Check for consistency with existing codebase
- **Only comment on code that was changed in THIS branch's commits**

### 2. Code Quality Assessment

- Code style and formatting consistency
- Variable and function naming conventions
- Code organization and structure
- Adherence to DRY (Don't Repeat Yourself) principles
- Proper abstraction levels

### 3. Technical Review

- Logic correctness and edge cases
- Error handling and validation
- Performance implications
- Security considerations (input validation, SQL injection, XSS, etc.)
- Resource management (memory leaks, connection handling)
- Concurrency issues if applicable

### 4. Best Practices Check

- Design patterns usage
- SOLID principles adherence
- Testing coverage implications
- Documentation completeness
- API consistency
- Backwards compatibility

### 5. Dependencies and Integration

- New dependencies added
- Breaking changes to existing interfaces
- Impact on other parts of the system
- Database migration requirements

### 6. Fetch Jira Ticket Details

Use the MCP Zapier tool to fetch the ticket:

```typescript
mcp__zapier-frontend__jira_software_cloud_find_issue_by_key({
  instructions: "Get details for ticket [TICKET_ID]",
  key: "[TICKET_ID]",
  fields: "summary,description,issuetype,priority,status"
})
```

**Extract from response:**
- Summary (title)
- Description
- Issue type
- Status
- Any other relevant context

## Generate Review Report

Create a structured code review report with:

1. **Executive Summary**: High-level overview of changes and overall assessment
2. **Statistics**:
   - Files changed, lines added/removed
   - Commits reviewed
   - Critical issues found
3. **Strengths**: What was done well
4. **Issues by Priority**:
   - 🔴 **Critical**: Must fix before merging (bugs, security issues)
   - 🟡 **Important**: Should address (performance, maintainability)
   - 🟢 **Suggestions**: Nice to have improvements
5. **Detailed Findings**: For each issue include:
   - File and line reference
   - A question framing the concern (e.g., "Could this cause X?" or "Would it help to Y?")
   - Context explaining why you're asking
   - Code example if helpful
6. **Security Review**: Specific security considerations
7. **Performance Review**: Performance implications
8. **Testing Recommendations**: What tests should be added
9. **Documentation Needs**: What documentation should be updated

## User Interaction

After completing the review:

1. Display the complete review report in markdown format
2. Provide actionable next steps based on findings
3. If critical issues found, highlight them prominently

## Feedback Style: Questions, Not Directives

**Frame all feedback as questions, not commands.** This encourages dialogue and respects the author's context.

### Examples

❌ **Don't write:**
- "You should use early returns here"
- "This needs error handling"
- "Extract this into a separate function"
- "Add a null check"

✅ **Do write:**
- "Could this be simplified with an early return?"
- "What happens if this API call fails? Would error handling help here?"
- "Would it make sense to extract this into its own function for reusability?"
- "Is there a scenario where this could be null? If so, how should we handle it?"

### Why Questions Work Better

- The author may have context you don't have
- Questions invite explanation rather than defensiveness
- They acknowledge uncertainty in the reviewer's understanding
- They create a conversation rather than a checklist

## Important Notes

- **CRITICAL: Only review changes from THIS branch's commits** - use `git merge-base` to isolate branch-specific changes. Never comment on code that was changed in other branches.
- Frame feedback as questions to encourage dialogue
- Be constructive and specific in feedback
- Provide code examples for suggested improvements
- Acknowledge good practices and improvements
- Prioritize issues clearly
- Consider the context and purpose of changes
- Review not just code but also architectural decisions
- Check for potential impacts on other systems
- Ensure review is actionable and helpful
- Verify code review is within the acceptance criteria of the Jira Ticket