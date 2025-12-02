---
name: digital-ea
description: A proactive chief of staff that analyzes your calendar, email, and Slack to help align daily activities with strategic priorities. Use when user asks "what should I focus on", "am I spending time on the right things", "time audit", "priority check", "what's important today", "help me plan my day", or shares their OKRs, goals, or priorities.
license: MIT
metadata:
  author: Zapier
  version: 1.0.0
  mcp-server: zapier
---

# Digital EA / Chief of Staff

## Overview

A proactive executive assistant that analyzes your work patterns across Slack, Gmail, and Google Calendar to surface what matters, flag misalignments, and help you stay focused on strategic priorities instead of getting lost in reactive work.

## When to Use This Skill

- User asks "What should I focus on today?"
- User asks "Am I spending time on the right things?"
- User wants a "time audit" or "weekly review"
- User shares their OKRs, goals, or job description for context
- User asks to "plan my day" or "prioritize my week"
- User feels overwhelmed and wants help triaging

## Prerequisites

- Zapier MCP must be connected
- Google Calendar connected to Zapier account
- Gmail connected to Zapier account
- Slack connected to Zapier account
- Recommended: User provides their priorities, OKRs, or job description as context (in the conversation or as Project Knowledge)

## Workflow

### Step 1: Understand User's Priorities

Before analyzing activity, establish what "right work" means for this user:

**If priorities are already provided (Project Knowledge or conversation):**
- Reference their stated OKRs, goals, or job description
- Note key themes: strategic vs operational, individual vs team, creative vs administrative

**If priorities are NOT provided:**
- Ask: "What are your top 2-3 priorities this quarter?" or "What does success look like in your role right now?"
- Can proceed with general analysis, but recommendations will be less targeted

### Step 2: Fetch Calendar Data

Query Google Calendar via Zapier MCP (Google Calendar):

- Fetch today's events (for daily focus)
- Fetch this week's events (for weekly audit)
- Note for each event:
  - Duration
  - Number of attendees
  - Whether user is organizer or attendee
  - Event title/type (1:1, team meeting, external, focus time)

**Categorize meetings:**
- 🎯 Strategic: Planning, OKR reviews, key stakeholder meetings
- 👥 Operational: Team syncs, standups, status updates
- 🤝 External: Customer/partner/vendor meetings
- 💬 1:1s: Direct report and manager conversations
- 🔒 Focus time: Blocked time for deep work

### Step 3: Analyze Email Patterns

Query Gmail via Zapier MCP (Gmail):

- Search for emails from today/this week
- Identify high-volume threads (lots of back-and-forth)
- Note threads where user is in CC vs TO
- Flag threads with urgency signals (URGENT, ASAP, EOD)

**Look for patterns:**
- Time spent on email threads that could be async
- Threads where user is pulled in but not essential
- Unread count and inbox stress signals

### Step 4: Analyze Slack Activity

Query Slack via Zapier MCP (Slack):

- Identify channels with high user activity
- Note direct messages vs channel messages
- Look for patterns in reactive communication

**Categorize channel activity:**
- 🚨 Interrupt-driven: Support channels, incidents, urgent requests
- 📣 Broadcast: Announcements, FYIs (low effort to monitor)
- 💬 Discussion: Active threads requiring thought and response
- 🔕 Low-signal: Channels with activity but minimal user engagement needed

### Step 5: Synthesize and Compare to Priorities

Cross-reference activity against stated priorities:

**Calculate rough time allocation:**
```
Meetings: X hours (Y% strategic, Z% operational)
Email: ~X hours estimated
Slack: High/Medium/Low reactivity
Focus time: X hours blocked (X hours actually protected)
```

**Identify misalignments:**
- Priority says "strategic planning" but calendar is 80% operational meetings
- Priority says "ship feature X" but no focus time blocked
- High Slack activity in channels unrelated to stated goals
- Email threads consuming time on delegatable topics

### Step 6: Provide Recommendations

Based on analysis, provide actionable recommendations:

**For Daily Focus ("What should I focus on today?"):**

```
🎯 Today's Priority Focus:
Based on your Q4 goal of [goal], here's what matters today:

1. [Specific task/meeting that aligns with priorities]
2. [Second priority item]
3. [Third priority item]

⚠️ Watch Out For:
- [Meeting/thread that could derail focus]
- [Slack channel that's been a time sink]

💡 Suggestion:
- [Specific actionable recommendation]
```

**For Weekly Audit ("Time audit for this week"):**

```
📊 This Week's Time Breakdown:

Meetings: 22 hours
├── Strategic (OKR-aligned): 6 hours (27%)
├── Operational (syncs/standups): 10 hours (45%)
├── External (customers): 4 hours (18%)
└── 1:1s: 2 hours (9%)

Communication:
├── High-activity email threads: 8
├── Slack channels with heavy engagement: 3
└── Estimated reactive time: 6-8 hours

Focus Time:
├── Blocked: 4 hours
└── Actually protected: ~2 hours (meetings scheduled over blocks)

🔴 Misalignment Alert:
Your Q4 priority is [priority], but only 27% of meeting time 
supports this. You're spending 45% of meetings on operational 
syncs that could potentially be async or delegated.

💡 Recommendations:
1. [Specific calendar change]
2. [Specific delegation suggestion]
3. [Specific Slack/email boundary]
```

## Important Notes

- This Skill provides estimates and patterns, not precise time tracking
- Email and Slack time estimates are rough based on volume, not actual screen time
- Recommendations are suggestions—user knows their context best
- If user hasn't shared priorities, analysis will be general rather than strategic
- Avoid being preachy; present data and let user decide

## Error Handling

### Calendar Access Limited
If calendar fetch returns limited data:
1. Check if Google Calendar is connected in Zapier
2. May need to expand date range if today is empty
3. Proceed with available data, note the limitation

### No Priorities Provided
If user hasn't shared their goals:
1. Provide general time breakdown without alignment analysis
2. Ask if they'd like to share priorities for more targeted insights
3. Offer common priority frameworks (revenue, shipping, team health)

### High Volume Data
If user has 50+ meetings or 200+ emails:
1. Focus on patterns rather than individual items
2. Summarize by category rather than listing everything
3. Highlight only the most significant misalignments

## Examples

### Example 1: Morning Focus Check

**User input:**
```
What should I focus on today? 

My priorities this quarter are:
1. Ship the new onboarding flow (engineering)
2. Hire 2 senior engineers
3. Reduce support ticket volume by 20%
```

**Actions:**
1. Note priorities: onboarding flow, hiring, support reduction
2. Fetch today's calendar events via Zapier MCP (Google Calendar)
3. Search recent Gmail threads via Zapier MCP (Gmail)
4. Check Slack activity patterns via Zapier MCP (Slack)
5. Cross-reference against priorities
6. Generate focused daily plan

**Result:**
```
🎯 Today's Priority Focus:

Based on your Q4 goals, here's what matters today:

1. 10am: 1:1 with Sarah (engineering) — Use this to unblock 
   the onboarding flow. She flagged API issues yesterday.
   
2. 2pm: Interview - Senior Engineer candidate — Directly 
   supports your hiring goal. Prep the system design question.
   
3. Protect 3-4pm: You have focus time blocked. Use it for 
   the onboarding flow spec review that's been pending.

⚠️ Watch Out For:
- 11am "Team Sync" is operational. Consider async update 
  if onboarding work is behind.
- #support-escalations has 23 messages since yesterday. 
  Relevant to your support goal, but could be a rabbit hole.
  Skim for patterns, don't get pulled into individual tickets.

💡 Suggestion:
Your calendar has no time for hiring-related work beyond 
the interview. Consider blocking 30 min tomorrow for 
recruiter sync and pipeline review.
```

### Example 2: Weekly Time Audit

**User input:**
```
Give me a time audit for this week. I feel like I'm not 
making progress on what matters.
```

**Actions:**
1. Ask for priorities if not known (or use previously shared context)
2. Fetch this week's calendar events via Zapier MCP (Google Calendar)
3. Analyze email thread volume via Zapier MCP (Gmail)
4. Review Slack channel activity via Zapier MCP (Slack)
5. Generate comprehensive breakdown with recommendations

**Result:**
```
📊 This Week's Time Audit (Mon-Fri):

MEETINGS: 26 hours total
├── 🎯 Strategic: 4 hours (15%)
│   └── Quarterly planning, board prep
├── 👥 Operational: 14 hours (54%)
│   └── Daily standups (5h), team syncs (6h), status updates (3h)
├── 🤝 External: 5 hours (19%)
│   └── Customer calls, vendor check-ins
└── 💬 1:1s: 3 hours (12%)
    └── 4 direct reports + manager

COMMUNICATION LOAD:
├── Email threads with 5+ messages: 12
├── Threads where you're CC'd (not TO): 8
├── Slack channels with 10+ your messages: #engineering, #incidents, #random
└── Estimated reactive time: 8-10 hours

FOCUS TIME:
├── Blocked on calendar: 6 hours
├── Actually happened: 2 hours
└── Interrupted by: 2 meetings scheduled over, 2 "quick calls"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 Why You Feel Stuck:

You wanted to ship the onboarding flow, but:
- 54% of your meetings are operational (syncs and status)
- Your 6 hours of focus time got cut to 2 hours
- You're active in #incidents (23 messages) which isn't 
  in your top 3 priorities

The math: ~26h meetings + ~9h reactive comms = 35 hours 
before you touch priority work.

💡 Recommendations:

1. RECLAIM STANDUPS: Daily standups = 5 hours/week. 
   Try async standups (Slack/Loom) 3 days, sync only 2 days.
   Saves: ~3 hours

2. PROTECT FOCUS TIME: Your blocks aren't respected. 
   Options:
   - Mark as "Busy" not "Focus Time" (people ignore focus time)
   - Block on a shared calendar people check before booking
   - Decline meetings that land on blocks with a redirect

3. DELEGATE #INCIDENTS: You're the 3rd most active person 
   in #incidents but it's not your priority. Can someone 
   else be first responder this quarter?

4. AUDIT THE CC'S: 8 threads where you're CC'd. Review if 
   you need to be on these or can unsubscribe.

Want me to help you draft a message to your team about 
changing standup format?
```

### Example 3: Ongoing Priority Alignment

**User input:**
```
Am I spending time on the right things this week? 

Context: I'm the Head of Product. My board presentation 
is in 2 weeks and it's my #1 priority right now.
```

**Actions:**
1. Note priority: Board presentation in 2 weeks
2. Fetch this week's activity via Zapier MCP (Google Calendar, Gmail, Slack)
3. Specifically look for board-prep related work
4. Flag everything that's NOT board prep

**Result:**
```
🎯 Priority Alignment Check: Board Presentation

Your #1 priority: Board presentation (due in 2 weeks)

This week's board-prep time: ~3 hours
├── Thursday 2pm: "Board deck review" (1 hour)
├── Email thread with CFO on metrics (est. 1 hour)
└── Scattered Slack in #exec-team (est. 1 hour)

Everything else: ~32 hours
├── Product team meetings: 12 hours
├── Customer calls: 6 hours
├── Engineering syncs: 5 hours
├── Recruiting/interviews: 4 hours
├── Other: 5 hours

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ Honest Assessment:

You're spending ~9% of your time on your stated #1 priority 
with 2 weeks to go. If the board deck needs significant 
work, this week's allocation won't get you there.

Questions to consider:
- Is the deck already 90% done? (Then 3 hours may be fine)
- Are the customer calls feeding into the board narrative? 
  (Then they count as prep)
- Can any of the 12 hours of product meetings be delegated 
  or shortened this week?

💡 If you need more board prep time:

Option A: Cancel/delegate
- Which product meetings can your PM leads run without you?
- Can recruiting interviews shift to next week?

Option B: Consolidate
- Block Wed + Thu mornings for board prep (4 hours)
- Do one working session with CFO instead of async email

Want me to look at next week's calendar and suggest 
what to move?
```

## Advanced Usage

### Set Recurring Check-ins

```
User: "Every Monday morning, give me a priority focus for the week"
```

While Skills can't schedule themselves, user can build this habit. The Skill will reference any stored priorities and current calendar state.

### Compare Weeks

```
User: "How does this week compare to last week in terms of focus time?"
```

Fetch two weeks of calendar data and compare patterns.

### Team-Level Analysis (if manager)

```
User: "Am I spending enough time with my direct reports?"
```

Analyze 1:1 frequency and duration against team size and any stated management priorities.