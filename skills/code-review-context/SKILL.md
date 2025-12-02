---
name: code-review-context
description: Assembles complete context for code reviews by fetching GitLab/GitHub merge requests, linked Jira tickets, and related design docs from Notion or Coda. Use when user asks to "review MR", "review PR", "summarize MR !1234", "give me context for this merge request", "pull request context", "what's this MR about", or shares an MR/PR link.
license: MIT
metadata:
  author: Zapier
  version: 1.0.0
  mcp-server: zapier
---

# Code Review Context

## Overview

Automatically assemble the full story behind a merge request—requirements, design decisions, acceptance criteria—so you can review code with complete context instead of spending 15 minutes hunting through Jira and Notion before looking at a single line.

## When to Use This Skill

- User asks to "review MR" or "review PR"
- User says "summarize MR !1234" or "PR #567"
- User asks "give me context for this merge request"
- User shares a GitLab/GitHub MR/PR link
- User asks "what's this MR about?"
- User wants to understand a change before reviewing

## Prerequisites

- Zapier MCP must be connected
- GitLab OR GitHub connected to Zapier account
- Jira connected to Zapier account (recommended)
- Notion OR Coda connected to Zapier account (optional, for design docs)

## Workflow

### Step 1: Identify the Merge Request

Parse user input to find the MR/PR:

**Supported formats:**
- MR number: `!1234`, `MR !1234`, `MR 1234`
- PR number: `#567`, `PR #567`, `PR 567`
- Full URL: `https://gitlab.com/org/repo/-/merge_requests/1234`
- Full URL: `https://github.com/org/repo/pull/567`

If user doesn't specify:
- Ask which MR/PR they want to review
- Or offer to list their assigned/open reviews

### Step 2: Fetch MR/PR Details

Query GitLab/GitHub via Zapier MCP (GitLab/GitHub):

**Retrieve:**
- Title and description
- Author and assignees
- Source branch → target branch
- File changes summary (files changed, additions, deletions)
- Labels/tags
- Current status (open, draft, approved, merged)
- Comments and review threads
- CI/CD pipeline status

**Extract from description/branch:**
- Linked ticket IDs (PROJ-123 pattern)
- Related MR/PR references
- Links to external docs

### Step 3: Fetch Linked Jira Ticket

If ticket ID found, query Jira via Zapier MCP (Jira):

**Retrieve:**
- Ticket title and description
- Acceptance criteria (often in description or custom field)
- Story points / estimate
- Priority and labels
- Current status
- Sprint information
- Comments (especially from product/design)
- Linked tickets (parent epic, blocked by, etc.)

**Look for key context:**
- Original requirements
- Product decisions in comments
- Design review notes
- QA test cases
- Edge cases called out

### Step 4: Search for Design Documentation (optional)

Query Notion/Coda via Zapier MCP (Notion/Coda):

**Search strategies:**
1. Keywords from ticket title: "User Preferences System"
2. Ticket ID in doc: "PROJ-123" or "BACKEND-2301"
3. Feature name from branch: "checkout-flow" → "Checkout Flow"
4. Links embedded in Jira ticket

**Retrieve if found:**
- Design doc title and link
- Key sections: Goals, Approach, Technical Design
- Open questions or decisions
- Diagrams or architecture notes

If no doc found, note this—not all changes have design docs.

### Step 5: Synthesize Review Brief

Combine all context into a structured summary:

```
📋 MR Review Brief: !1234

OVERVIEW
────────────────────────────────────
Title: Add user preferences API endpoints
Author: @sarah | Assigned to: @you
Branch: feature/PROJ-123-user-prefs → main
Status: Ready for review | CI: ✅ Passing

CHANGES
────────────────────────────────────
23 files changed (+847 / -102)

Key files:
├── src/api/preferences/* (new)
├── src/models/UserPreference.ts (new)
├── src/services/PreferenceService.ts (new)
├── tests/api/preferences.test.ts (new)
└── src/middleware/auth.ts (modified)

CONTEXT
────────────────────────────────────
Jira: PROJ-123 "User Preferences System"
Epic: PROJ-100 "Personalization Initiative"
Priority: High | Points: 8

Requirements:
• Users can set notification preferences
• Users can set display preferences (theme, density)
• Preferences sync across devices
• Must support preference inheritance (user > org > default)

Acceptance Criteria:
☐ GET /api/preferences returns current user prefs
☐ PATCH /api/preferences updates preferences
☐ Preferences persisted to database
☐ Unauthorized users get 401
☐ Invalid preferences return 400 with validation errors

DESIGN DOC
────────────────────────────────────
📄 "User Preferences System Design" (Notion)
Link: [notion.so/...]

Key decisions:
• Using JSON column for flexibility vs. structured columns
• Preference inheritance: user overrides org overrides default
• Cache layer with 5-minute TTL

Open questions from doc:
• Should preferences be versioned? (No decision yet)

WHAT TO LOOK FOR
────────────────────────────────────
Based on requirements and design:

1. INHERITANCE LOGIC
   Does the code implement user > org > default correctly?
   Check: PreferenceService.ts

2. VALIDATION
   Are invalid preferences rejected per AC?
   Check: tests/api/preferences.test.ts

3. AUTH CHANGES
   auth.ts was modified - verify no regression
   
4. CACHE IMPLEMENTATION
   Design doc mentions 5-min TTL cache
   Verify: Is caching implemented? Correct TTL?

5. OPEN QUESTION
   Versioning not decided - is it being implemented anyway?
   Could be scope creep or premature optimization
```

### Step 6: Offer Follow-up Analysis

After presenting the brief, offer deeper analysis:

```
Ready to review with full context. Want me to:

• Compare implementation to design doc?
• List edge cases from Jira that need test coverage?
• Check if all acceptance criteria are testable?
• Summarize the discussion thread from the MR?
```

## Important Notes

- This Skill gathers context; it doesn't review the code itself
- Design docs may be outdated—note the last modified date
- Not all MRs have Jira tickets or design docs; work with what's available
- If MR description is thorough, it may have all needed context
- Acceptance criteria location varies by team (Jira description, custom field, linked Confluence)

## Error Handling

### MR/PR Not Found
If the MR number doesn't exist:
1. Verify the number is correct
2. Check if user has access to the repo
3. Offer to search by title or author instead

### Jira Ticket Not Found
If extracted ticket ID doesn't exist:
1. Ticket may be in a different Jira project
2. Branch naming may not match ticket
3. Proceed without Jira context
4. Note limitation in the brief

### No Design Doc Found
If Notion/Coda search returns nothing:
1. Not all changes have design docs—this is normal
2. Note in brief: "No design doc found"
3. Suggest checking with author if architecture decisions are unclear

### Multiple Tickets Referenced
If MR references multiple tickets (PROJ-123, PROJ-124):
1. Fetch all referenced tickets via Zapier MCP (Jira)
2. Identify primary ticket (usually in branch name)
3. List others as "Related tickets" in brief

### Large MR (100+ files)
If MR is very large:
1. Warn that this is a large change
2. Group files by directory/module
3. Highlight the most critical paths
4. Suggest breaking into smaller reviews if not merged yet

## Examples

### Example 1: Standard MR Review

**User input:**
```
Give me context for MR !2341
```

**Actions:**
1. Fetch MR !2341 details via Zapier MCP (GitLab)
2. Extract ticket ID from branch: feature/BACKEND-456-payment-retry → BACKEND-456
3. Fetch BACKEND-456 from Jira via Zapier MCP (Jira)
4. Search Notion for "payment retry" via Zapier MCP (Notion)
5. Synthesize and present review brief

**Result:**
```
📋 MR Review Brief: !2341

OVERVIEW
────────────────────────────────────
Title: Implement payment retry logic with exponential backoff
Author: @mike | Assigned to: @you
Branch: feature/BACKEND-456-payment-retry → main
Status: Ready for review | CI: ✅ Passing

CHANGES
────────────────────────────────────
12 files changed (+342 / -28)

Key files:
├── src/services/PaymentService.ts (modified)
├── src/utils/retry.ts (new)
├── src/config/payment.ts (modified)
└── tests/services/payment.test.ts (modified)

CONTEXT
────────────────────────────────────
Jira: BACKEND-456 "Payment Retry with Backoff"
Epic: BACKEND-400 "Payment Reliability"
Priority: Critical | Points: 5

Requirements:
• Retry failed payments up to 3 times
• Use exponential backoff (1s, 2s, 4s)
• Don't retry on permanent failures (invalid card, insufficient funds)
• Log all retry attempts for debugging

Acceptance Criteria:
☐ Transient failures trigger retry
☐ Permanent failures fail immediately
☐ Max 3 retries with exponential backoff
☐ Retry attempts logged with correlation ID

DESIGN DOC
────────────────────────────────────
📄 "Payment Retry Strategy" (Notion)
Last updated: Nov 10, 2025

Key decisions:
• Exponential backoff with jitter to prevent thundering herd
• Retry only on 5xx and timeout errors
• Circuit breaker for persistent failures (>50% fail rate)

⚠️ Note: Design doc mentions circuit breaker - verify if in scope for this MR

WHAT TO LOOK FOR
────────────────────────────────────
1. BACKOFF TIMING
   Check retry.ts implements 1s → 2s → 4s correctly
   
2. ERROR CLASSIFICATION  
   Does code distinguish transient vs permanent failures?
   
3. CIRCUIT BREAKER
   Design doc mentions it - is it implemented or deferred?
   
4. LOGGING
   Verify correlation ID in retry logs per AC

Ready to review. Want me to compare the implementation 
to the design doc in detail?
```

### Example 2: PR with GitHub Link

**User input:**
```
Summarize this PR for me: https://github.com/acme/api/pull/891
```

**Actions:**
1. Parse URL → GitHub, repo: acme/api, PR: 891
2. Fetch PR #891 via Zapier MCP (GitHub)
3. Extract ticket ID from branch/description
4. Fetch Jira ticket via Zapier MCP (Jira)
5. Search for design docs via Zapier MCP (Coda)
6. Present brief

**Result:**
```
📋 PR Review Brief: #891

OVERVIEW
────────────────────────────────────
Title: Add rate limiting to public API endpoints
Author: @alex | Reviewers: @you, @jane
Branch: feature/SEC-789-rate-limiting → main
Status: Open | CI: ✅ Passing | 2 approvals needed

CHANGES
────────────────────────────────────
8 files changed (+156 / -12)

Key files:
├── src/middleware/rateLimit.ts (new)
├── src/config/rateLimits.ts (new)
├── src/routes/api/*.ts (modified - middleware added)
└── tests/middleware/rateLimit.test.ts (new)

CONTEXT
────────────────────────────────────
Jira: SEC-789 "Implement API Rate Limiting"
Priority: High | Points: 3

From Jira description:
"Following the incident on Nov 5 where a single client 
made 50k requests/minute, we need rate limiting on all 
public endpoints."

Acceptance Criteria:
☐ Rate limit: 100 requests/minute per API key
☐ Return 429 with Retry-After header when exceeded
☐ Whitelist for internal services
☐ Metrics emitted for monitoring

Comment from @security-lead (Nov 8):
"Make sure rate limit headers are always returned, 
not just on 429. Clients need visibility."

DESIGN DOC
────────────────────────────────────
No design doc found in Coda.

This appears to be a straightforward implementation 
based on the Jira ticket. Check with author if there 
were architecture discussions elsewhere.

WHAT TO LOOK FOR
────────────────────────────────────
1. RATE LIMIT HEADERS
   Per security-lead's comment: headers on ALL responses?
   
2. WHITELIST IMPLEMENTATION
   How are internal services identified and whitelisted?
   
3. 429 RESPONSE
   Correct status code with Retry-After header?
   
4. TEST COVERAGE
   Tests for: normal request, rate exceeded, whitelist bypass?
```

### Example 3: MR Without Jira/Docs

**User input:**
```
Review MR !567
```

**Actions:**
1. Fetch MR !567 via Zapier MCP (GitLab)
2. No ticket ID found in branch (named `fix-memory-leak`)
3. Search Jira for "memory leak" → no clear match
4. Search Notion for "memory leak" → no results
5. Present brief with available context

**Result:**
```
📋 MR Review Brief: !567

OVERVIEW
────────────────────────────────────
Title: Fix memory leak in WebSocket handler
Author: @chris | Assigned to: @you
Branch: fix-memory-leak → main
Status: Ready for review | CI: ✅ Passing

CHANGES
────────────────────────────────────
3 files changed (+24 / -8)

Files:
├── src/handlers/websocket.ts (modified)
├── src/utils/connectionPool.ts (modified)
└── tests/handlers/websocket.test.ts (modified)

CONTEXT
────────────────────────────────────
⚠️ No Jira ticket linked
⚠️ No design doc found

From MR description:
"Fixes memory leak caused by WebSocket connections not 
being properly cleaned up on disconnect. Connections 
were accumulating in the pool and never released.

Root cause: Missing event listener for 'close' event.

Testing: Ran load test for 1 hour, memory stayed flat 
instead of growing linearly."

WHAT TO LOOK FOR
────────────────────────────────────
Based on MR description only:

1. EVENT LISTENER
   Is 'close' event properly handled now?
   
2. CLEANUP LOGIC
   Are connections removed from pool on disconnect?
   
3. TEST COVERAGE
   Does new test verify cleanup behavior?
   
4. EDGE CASES
   What about abnormal disconnects (network drop)?

💡 Suggestion: This looks like a bug fix without a ticket. 
You may want to ask @chris to create a Jira ticket for 
tracking, or confirm this was an urgent hotfix.
```

### Example 4: Deep Comparison Request

**User input:**
```
Compare MR !2341 to the design doc - any deviations?
```

**Actions:**
1. Already have MR context from previous query (or fetch fresh)
2. Fetch full design doc content via Zapier MCP (Notion)
3. Compare implementation details to design decisions
4. Identify matches, deviations, and missing pieces

**Result:**
```
🔍 Design Doc Comparison: MR !2341

DESIGN DOC: "Payment Retry Strategy"
MR: !2341 "Implement payment retry logic"

✅ MATCHES DESIGN
────────────────────────────────────
• Exponential backoff: 1s → 2s → 4s ✓
• Max retries: 3 ✓
• Retry only on 5xx errors ✓
• Jitter added to prevent thundering herd ✓

⚠️ DEVIATIONS
────────────────────────────────────
1. TIMEOUT ERRORS
   Design: "Retry on 5xx AND timeout errors"
   Implementation: Only retries on 5xx
   
   → Check: Is timeout handling missing or intentionally deferred?

2. BACKOFF MULTIPLIER
   Design: "Exponential with 2x multiplier"
   Implementation: Uses 1.5x multiplier (1s → 1.5s → 2.25s)
   
   → Check: Intentional adjustment or implementation error?

❌ NOT IMPLEMENTED (may be out of scope)
────────────────────────────────────
• Circuit breaker for persistent failures
  Design doc describes this but MR doesn't include it.
  
  → Check: Is this a separate ticket/MR?

📝 RECOMMENDATION
────────────────────────────────────
Raise these questions in your review:
1. Should timeout errors trigger retry?
2. Confirm backoff multiplier (2x vs 1.5x)
3. Clarify circuit breaker scope/timeline
```

## Advanced Usage

### Review Assigned MRs

```
User: "What MRs do I need to review?"
```

Fetch user's assigned MRs via Zapier MCP (GitLab/GitHub), list them with brief context.

### Batch Context for Multiple MRs

```
User: "Give me context for MR !100, !101, and !102"
```

Fetch all three and present abbreviated briefs for each.

### Check Acceptance Criteria Coverage

```
User: "Are all the acceptance criteria in PROJ-123 covered by tests?"
```

Cross-reference AC from Jira with test file contents in the MR.

### Historical Context

```
User: "What other MRs have touched PaymentService.ts recently?"
```

Search recent merged MRs that modified the same files—useful for understanding recent changes.