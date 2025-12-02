---
name: ai-powered-crm-updates
description: Maintains your CRM by processing meeting notes, emails, and conversations to create and update contact, company, and deal records with structured context and next steps. Use when user pastes meeting notes, says "update CRM", "log this meeting", "sync to Salesforce", "sync to HubSpot", "add this to CRM", or asks to track a conversation or follow-up.
license: MIT
metadata:
  author: Zapier
  version: 1.0.0
  mcp-server: zapier
---

# AI-Powered CRM Updates

## Overview

Automatically transform meeting notes, transcripts, and conversation summaries into structured CRM records. This Skill eliminates the 15+ minutes of manual data entry after each meeting by intelligently parsing context and syncing to HubSpot or Salesforce via Zapier MCP.

## When to Use This Skill

- User pastes meeting notes or a transcript
- User says "update CRM with this" or "log this meeting"
- User asks to "sync notes to Salesforce" or "sync to HubSpot"
- User wants to "track this conversation" or "create follow-up tasks"
- User shares a call summary and mentions contacts or companies

## Prerequisites

- Zapier MCP must be connected
- User must have HubSpot or Salesforce connected to their Zapier account
- Optional: Gmail connected for email context enrichment

## Workflow

### Step 1: Parse Meeting Content

Extract structured data from the provided notes:

- **Attendees**: Names, titles, email addresses if present
- **Companies**: Organization names mentioned
- **Discussion points**: Key topics, decisions, concerns raised
- **Next steps**: Action items with owners and due dates
- **Deal context**: Budget mentions, timeline, decision makers, blockers

If the notes are unstructured or a raw transcript, summarize into these categories before proceeding.

### Step 2: Search for Existing CRM Records

Query the user's CRM via Zapier MCP to find existing records:

**For each attendee identified:**
- Search HubSpot/Salesforce for contact by name or email via Zapier MCP (HubSpot/Salesforce)
- Note whether record exists or needs to be created

**For each company identified:**
- Search HubSpot/Salesforce for company/account by name via Zapier MCP (HubSpot/Salesforce)
- Note whether record exists or needs to be created

Present findings to user:
```
Found in CRM:
- ✅ Jane Smith (jane@acme.com) - existing contact
- ✅ Acme Corp - existing company

Not found (will create):
- ❓ Bob Johnson - no email provided, need to confirm
```

### Step 3: Enrich with Email Context (Optional)

If user has Gmail connected and wants additional context:

- Search Gmail for recent threads with identified contacts via Zapier MCP (Gmail)
- Extract relevant context: previous conversations, shared documents, outstanding questions
- Add this context to the CRM update

Only do this if explicitly requested or if meeting notes reference prior email conversations.

### Step 4: Create or Update CRM Records

**For new contacts:**
- Create contact record via Zapier MCP (HubSpot/Salesforce)
- Associate with company record
- Add meeting notes to contact activity/notes

**For existing contacts:**
- Update contact record with new information via Zapier MCP (HubSpot/Salesforce)
- Log meeting as activity/note with full context

**For companies:**
- Create company record if new via Zapier MCP (HubSpot/Salesforce)
- Update company notes with meeting summary

**Meeting note format for CRM:**
```
Meeting: [Date]
Attendees: [Names]
Topics Discussed:
- [Topic 1]
- [Topic 2]

Key Outcomes:
- [Decision or outcome]

Next Steps:
- [Action item] - Owner: [Name] - Due: [Date]
```

### Step 5: Create Follow-Up Tasks

For each action item identified with a clear owner:

- Create task in CRM via Zapier MCP (HubSpot/Salesforce)
- Set due date (use mentioned date, or default to 1 week if unspecified)
- Associate task with relevant contact and company
- Include context from meeting in task description

Present created tasks to user for confirmation:
```
Created follow-up tasks:
1. "Send proposal draft" - Assigned to you - Due: Nov 25
2. "Schedule technical review" - Assigned to you - Due: Nov 22
```

## Important Notes

- Always confirm before creating new contact records without email addresses
- If multiple CRMs are connected, ask user which one to update
- Preserve existing CRM data - append notes, don't overwrite
- If deal/opportunity context is mentioned, ask if user wants to create or update a deal record
- Default to creating tasks assigned to the current user unless another owner is clearly specified

## Error Handling

### Contact Not Found, No Email Provided
If a contact cannot be found and no email is in the notes:
1. Ask user for the email address
2. Or ask if they want to create a contact without email (not recommended)
3. Or skip that contact and proceed with others

### CRM Connection Failed
If Zapier MCP cannot reach the CRM:
1. Verify CRM is connected in Zapier account
2. Check if OAuth token needs refresh
3. Suggest user reconnect the CRM in Zapier

### Ambiguous Company Match
If company name matches multiple records:
1. Present options to user with context (location, industry, existing contacts)
2. Let user select the correct one
3. Proceed with selected record

## Examples

### Example 1: Simple Meeting Log

**User input:**
```
Update CRM with this:

Met with Sarah Chen from TechFlow today. Discussed their Q1 expansion plans.
They're interested in our enterprise tier. Budget is ~$50k.
Next step: Send pricing proposal by Friday.
```

**Actions:**
1. Parse: Attendee (Sarah Chen), Company (TechFlow), Budget ($50k), Next step (proposal by Friday)
2. Search for Sarah Chen via Zapier MCP (HubSpot/Salesforce) - found existing contact
3. Search for TechFlow via Zapier MCP (HubSpot/Salesforce) - found existing company
4. Update Sarah Chen's contact with meeting note via Zapier MCP (HubSpot/Salesforce)
5. Create task "Send pricing proposal" due Friday via Zapier MCP (HubSpot/Salesforce)

**Result:** Contact updated, task created, user notified of completion.

### Example 2: New Contact from Conference

**User input:**
```
Log this to HubSpot:

Grabbed coffee with Marcus Williams at the SaaStr conference.
He's VP of Ops at Greenfield Industries.
marcus.w@greenfield.io

Interested in our automation tools for their warehouse ops.
I said I'd send a case study next week.
```

**Actions:**
1. Parse: New contact (Marcus Williams, VP of Ops, marcus.w@greenfield.io), Company (Greenfield Industries)
2. Search for Marcus Williams via Zapier MCP (HubSpot) - not found
3. Search for Greenfield Industries via Zapier MCP (HubSpot) - not found
4. Create company "Greenfield Industries" via Zapier MCP (HubSpot)
5. Create contact "Marcus Williams" associated with Greenfield via Zapier MCP (HubSpot)
6. Add meeting note to contact via Zapier MCP (HubSpot)
7. Create task "Send warehouse ops case study" due next week via Zapier MCP (HubSpot)

**Result:** New company and contact created, meeting logged, follow-up task scheduled.

### Example 3: Complex Multi-Stakeholder Meeting

**User input:**
```
Sync this to Salesforce:

Product demo call with DataVault team:
- Amanda Torres (CEO) - amanda@datavault.com
- Raj Patel (CTO) - raj@datavault.com  
- Finance person was on but I missed their name

Demo went well. Raj had concerns about API rate limits - I need to get answers from our engineering team. Amanda wants to move fast, targeting Feb 1 go-live.

They're evaluating us against Competitor X. Budget approved for $120k/year.

Next steps:
- Me: Get API limit answers from engineering by EOD Thursday
- Me: Send comparison doc vs Competitor X
- Raj: Share their current architecture diagram
- Amanda: Get legal to review our MSA
```

**Actions:**
1. Parse: Multiple attendees, company, deal context, multiple next steps
2. Search for contacts via Zapier MCP (Salesforce):
   - Amanda Torres - found
   - Raj Patel - not found (will create)
3. Search for DataVault via Zapier MCP (Salesforce) - found
4. Create contact Raj Patel, associate with DataVault via Zapier MCP (Salesforce)
5. Update Amanda Torres with meeting note via Zapier MCP (Salesforce)
6. Update Raj Patel with meeting note via Zapier MCP (Salesforce)
7. Log detailed meeting summary on company record via Zapier MCP (Salesforce)
8. Create tasks via Zapier MCP (Salesforce):
   - "Get API limit answers from engineering" - Due: Thursday
   - "Send comparison doc vs Competitor X" - Due: [prompt user for date]
9. Note: Tasks for Raj and Amanda are external - mention in meeting notes but don't create CRM tasks

**Result:** Records updated, new contact created, 2 follow-up tasks created, user alerted about external action items to track.

## Advanced Usage

### Enrich with Email History

```
User: "Update CRM with this meeting, and pull in any relevant email context"
```

This will search Gmail for recent threads with the meeting attendees and include that context in the CRM notes.

### Update Deal/Opportunity

```
User: "Log this meeting and update the deal stage to Proposal Sent"
```

In addition to contact updates, this will find the associated opportunity/deal and update its stage.

### Batch Processing

```
User: "Here are my notes from 3 meetings today: [notes]"
```

Process each meeting separately, confirming before each CRM update to avoid confusion.