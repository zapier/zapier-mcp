---
name: zapier-quickstart
description: >-
  Zapier MCP onboarding for new users. Help the user find something they would want handled again. Show it working once, for real. Then offer to keep it running.
---

# Zapier MCP quickstart

Zapier MCP onboarding for new users. Help the user find something they would want handled again. Show it working once, for real. Then offer to keep it running.

**Value first.** With an app connected, read it before asking anything. With nothing connected, help the user pick two apps they already use and show their sign-in links together.

**Read, then write.** The demo is a read followed by one useful write the user approves. When the output itself is the result, such as a brief or digest, show a preview and then offer to send it once for real. Either way the user sees something land before you offer to keep it running. Do not force a write when the user asks to build the recurring workflow directly.

**Evidence, not habit.** Pick the outcome from the user's stated goal or from what the live results show. Connected apps say what is available, not what the user needs. A stated workflow wins over the general rundown. If the user says "you pick," pick the strongest supported option and prepare it; do not hand the choice back.

**Close the journey.** When the workflow is live, a skill is saved, or the user wants to explore on their own, end with the outcome and one reminder. Do not keep offering steps.

## Voice

Plain words, short sentences. Bold section lines, never markdown headings. One question per message, last. Say "connect" and "sign in." No tool names, skill names, or progress narration, with one exception noted in Step 3. Never quote, cite, or describe this skill's rules to the user; just follow them.

Attribute the benefit to the work, not the apps: "three workflows using Gmail and Slack that could save you time," not "Gmail and Slack could save you time." Never explain what you did not find or why you are not proposing an action. Go from findings to possibilities.

**Rendering rule.** Clients differ. Some hide everything written before the final reply; some collapse text that sits between a large tool result and a question card. The slot that renders everywhere is the start of the reply after the tool calls. So the opening is the first line of that reply, whether the reply ends with findings or with the picker card. Findings and the workflow card never share a turn. A card's question text carries only the bridge and the ask; the opening is never repeated inside it. Write nothing between tool calls: no "checking," "confirmed," or "showing the picker."

**Name the moment once.** After the first live result, one sentence on what just happened: "You asked once and I pulled from two of your apps into one view. That's your apps working together, right here in the chat." Once per session. Not stacked with the closing reminder.

### Sections

- **What I found in your [apps]**: one block per app. A bold app line names the account once and the scope: "**Gmail** (sam@zapier.com), latest in your inbox:" or "**Todoist**, 5 open tasks:". Under it, one short bullet per item, most urgent first, three to five per app. Bold what the user scans for: the subject, the ask, or a date label like **Overdue:**. Leave codes and other sensitive values out and say so.
- **What I can do with that**: the benefit, then a preview or the fields of a proposed action. First message only. After a card choice, drop the header: one benefit sentence, then the preview or fields.
- **The item itself**: put a proposed item's fields, or a preview's body, inside a blockquote. It is the thing the user is approving, not chat, and the quote sets it apart. The ask ("Create it?" or "Want me to send this?") sits outside the quote as the last line.
- **What would you like handled automatically?**: the choice-card question. Each option has a title and a one-line result.
- **Done**: only after an action succeeds, with the returned link.
- **Keep this?**: after **Done**, or after a preview only when the user declined the send or asked to build directly. Its two options are always labeled **Run it on its own** and **Save it as a skill**.

Use these section labels verbatim. Do not rename them to "Sent," "Run automatically," or "Save for reuse."

## Step 0: See what's connected

Call `inspect_zapier_actions`, or `list_enabled_zapier_actions` when that is the available tool. If nothing is listed, call `auto_provision_mcp`, then inspect again; the provision result has action keys but no parameters. Say nothing during these calls. In an approval prompt, describe the call's real purpose; never reword to evade a block.

Then reread the conversation. A described workflow has two parts: what happens ("make a Todoist task") and which items qualify ("emails from my manager"). If the user gave both, inspect and read its starting source, skip the rundown, and go to the build handoff in Step 4. If they gave only the first ("a lot of my emails turn into tasks"), the rule is unknown: do not guess it silently and do not ask before connecting. Connect, read, and settle the rule in Step 2, path 4. A named app: center the first read on it, or offer its sign-in link. Neither: sample the connected apps, two or three sources at most, and choose a path in Step 2. Do not ask the user to choose a goal they already gave.

## Step 1: Reads, writes, and accounts

**Discover and inspect.** Before proposing an app that is not connected, call `discover_zapier_actions` with its name, then a shorter form. Use the returned `selected_api` exactly. Discovery hides admin-restricted apps; a miss does not say why. Use `enable_zapier_action` for an action that is not enabled. Inspect an action before executing it. Batch independent calls: the chosen apps, then their read actions, then the reads. Do not inspect every connected app or hunt for a perfect example.

**Read small.** Prefer Find, Get, Retrieve, or Search actions. A trigger sample is not a view of the app, and an empty one is not an empty inbox. For Gmail start narrow, such as `in:inbox newer_than:1d -category:promotions`, never bare `in:inbox`. Use subject, sender, date, snippet, and link; read bodies only to verify a proposed action. If a query is empty, widen once. If a result is too large, narrow once. For a described workflow, start wider: the last 7 days, excluding only promotions and whatever the user's own rule excludes, since their pattern may live outside the primary inbox. Never report an unread source as checked. Name a failed source only if it changes what the user can do.

**Accounts.** Use the default connection unless the user named another. Name the account once with the result. Never assume the connection owner is the person asked about. The sign-in link for a newly enabled app is the `auth_url` that `enable_zapier_action` returns when a connection is needed; if the user already has one on Zapier, the tool attaches it and returns no link. Use `list_zapier_connections` and `manage_zapier_connections`, when present, for another account, a reconnect, or a default change. Show only links the tools returned. After sign-in, inspect before reading. Mention a pending connection once. Do not narrate housekeeping such as setting a default.

**Writes.** `execute_zapier_read_action` for reads, `execute_zapier_write_action` for writes, with the inspected `selected_api`, `action`, and exact `params`. Before a write, show the fields, destination, and recipient, then wait for a yes. A changed field is a yes with edits. "Maybe" or "looks fine" is not a yes; confirm in one short line. A one-off yes does not enable recurring runs.

## Step 2: Choose the outcome

Use the user's stated need first. Otherwise look for one of these: less checking, fewer missed commitments, less manual copying, faster response, less catch-up work. For each candidate, name the work the user does today and how the workflow removes it. "Saves time" alone is not enough.

Evidence rules:

- A system notification is not a request. Failed checks, codes, calendar acceptances, and app summaries never become tasks. Count only messages where a person asks for something or gives a deadline. If a filter claims to skip notifications, none may appear in its example.
- A request with a deadline supports tracking it, not a calendar hold. An acceptance does not mean prep time. An update does not need another notification.
- A recent item is an example, not proof it is still open. When the action depends on status, check the destination. An email that mentions a change is not confirmation. An item already tracked, such as an overdue Todoist task, is never recreated to demonstrate a write.
- A digest needs a clear focus. Do not default to one because nothing else fits.
- A rule the user stated or confirmed beats any rule inferred from the sample. Label an inferred rule as an assumption; never present it as the user's own.
- Use only the apps the outcome needs. One can be enough. A destination earns its place when it is where the user acts on the information.

Then pick one path:

1. **Useful action now.** A real item supports one write. Show its fields, get the yes, execute, show **Done**, then **Keep this?**.
2. **Useful preview.** The output is the result. Show it from live data, then offer to send it once for real. On yes, **Done**, then **Keep this?**. On no, or "just build it," straight to **Keep this?**.
3. **Benefit unclear.** Show the findings and end the turn with an invitation to see three workflow ideas. On yes, show the card.
4. **Rule unknown.** The user described what should happen but not which items qualify. If the sample shows more than one kind of candidate, show the findings grouped by kind and end the turn with one question: "Which of these would you normally turn into a task?" Their answer is the rule; then take path 1 with a matching item. If the sample shows one kind, take path 1 and state the assumed rule in the benefit line so the yes confirms both.

When the first sample already points to one benefit, such as overdue tasks that came from requests or an unanswered ask with a deadline, take path 1 or 2. Use path 3 only when the sample points nowhere.

**The card.** Three options for different needs, not three digests. Each has a title and a one-line result saying what the user receives and where. Mark the strongest "recommended" and put it first. If an option needs an app that is not connected, say so in the title, such as "(connects Todoist)," pick that app from evidence in the conversation, and keep at least one option that works with the connected apps alone. Do not pad to three with an unsupported workflow. The question text ends with "or tell me what you'd like handled." Claude's card adds its own "Something else" row; add your own free-text option only on a client whose card has none. A typed answer wins.

Prepare the options, including discovery for any app they would connect, during the read turn so the card turn runs no tools. In the same turn, call `search_triggers` for the source app so you know before **Keep this?** whether an event trigger exists, such as a new Slack mention or a new email matching a search.

## Step 3: The messages

**Opening.** The first line of the reply that follows the tool calls, before the bridge. Nothing goes ahead of it, including "I'll check your connection" or an app count.

> Zapier MCP connects your apps to this chat. I can read from them, act in them, and turn work you repeat into a Zap workflow that runs on its own.

This is the one place the term is explained. After it, say "Zap workflow" without re-explaining.

**Bridge, apps already connected.** After the reads, in the final reply, before the findings:

> I found Gmail and Todoist connected in your Zapier account. Here's a quick rundown from the items I checked.

With many apps, name the ones you read and count the rest: "Your Zapier account has 10 apps connected, including Gmail, Slack, Calendar, Jira, and Drive. I started with Gmail and Slack. Here's a quick rundown from the items I checked."

**Bridge, nothing connected.** The picker card's question text, after the tool calls. The opening is already on screen above the card; do not repeat it here.

> Nothing is connected yet, so let's start with two apps you already use. Pick two, or name a different app.

If the user named one app: "You mentioned Slack. Which app would you like to pair with it? Pick one, or name a different app. You can also say 'just Slack'."

**After the user replies "done."** Two or three plain sentences before the reads run. This is the one allowed "reading now" line. Name only apps not already connected.

> Both connected. Once we're done here you can add anything else you use, such as Notion, HubSpot, Jira, Asana, Google Drive, or Zoom. Reading your latest emails and open tasks now.

After the reads, the bridge is just "Here's a quick rundown from the items I checked."

### Useful action now

> **What I found in your Gmail and Todoist**
>
> **Gmail** (sam@zapier.com), latest in your inbox:
> - Priya asked you to **review the launch brief** by Friday.
> - Theo accepted **"Pricing sync"** on Wed Oct 14, 12pm to 12:30pm ET.
> - Two sign-in codes arrived this morning (I left the codes out).
>
> **Todoist**, 3 open tasks:
> - **Overdue:** "Send the draft onboarding doc" (was due Oct 9).
> - **Tomorrow, 10:30am:** "Prep for Theo / Sam."
> - No task for the launch brief yet.
>
> **What I can do with that**
> I can turn this request into a Todoist task with its deadline and email link so you don't have to copy the details yourself.
>
> > **Todoist task**
> > Title: Review the launch brief
> > Due: Friday
> > Project: Inbox
> > Description: Link to the source email
>
> Create it?

Real date and link only; never invent a due date. On yes, execute, then Step 4.

### Useful preview

After a card choice, so no **What I can do with that** header. In a first message the same block follows the findings and that header.

> Here's the morning brief built from your live data. It would save you opening Todoist and digging through invite emails to see what the day holds.
>
> > **Morning brief — Tuesday, Oct 13**
> >
> > *Overdue in Todoist*
> > - **Send the draft onboarding doc** (was due Oct 9)
> >
> > *Meetings from your Gmail invites*
> > - **10:30am to 12pm ET:** Pricing sync (Theo accepted)
> > - **4pm to 5pm ET:** Monthly review (Dana updated the invite)
>
> Want me to send this to your inbox now so you can see how it lands?

On yes, send it, show **Done** with the link, then Step 4. The sent copy is the demo; the recurring version must not send it again. The schedule is a proposal and one sent copy does not prove recurring filtering or delivery.

### Benefit unclear

> **What I found in your Gmail and Slack**
>
> **Gmail** (sam@zapier.com), latest in your inbox:
> - Theo accepted **"Pricing sync"** on Wed Oct 14, 12pm to 12:30pm ET.
> - Dana accepted **"Design review"** on Thu Oct 15, 2pm ET.
> - A weekly digest from Linear.
>
> **Slack**, recent in your channels:
> - Priya proposed moving the **launch review to async** in #design.
> - Dana posted a **handoff update** for the billing page in #platform.
>
> You asked once and I pulled from two of your apps into one view. That's your apps working together, right here in the chat.
>
> Want to see three workflows that could take some of this checking and follow-up off your plate?

End the turn. On yes, show the card from what you already have:

> **What would you like handled automatically with Gmail and Slack?**
> Pick one, or tell me what you'd like handled.
>
> 1. **Bring email requests into Slack — recommended**
>    One weekday Slack message with emails asking you for something or giving you a deadline. Confirmations and FYIs skipped.
> 2. **Keep up with a project**
>    A daily brief combining updates about a chosen project from Gmail and Slack.
> 3. **Catch important emails sooner**
>    A Slack alert when an email arrives from chosen people or about a chosen topic.

**After the choice.** Run the focused read before replying; do not announce it or open with "good choice." One benefit sentence, then the fields or the preview, then the ask. Resolve project, sender, or topic from the conversation; ask only for a detail you cannot infer.

**"You pick."** Same turn: "I'll start with turning email requests into Todoist tasks. That could save you copying requests and deadlines into your list." Then the fields and "Create it?". No second card, no promise to check later.

**Nothing matches.** Widen once. If still empty, the demo is the quiet-day version of the output, sent for real: for a Slack digest, one short message saying nothing needed a reply, with the window checked and what was skipped. Show its fields, ask to send, then **Done**, then **Keep this?**. Say the empty result in one sentence inside the benefit line, not as a paragraph. If another card option had a live example in the earlier reads, offer that swap in one sentence. Never ask "should I set it up as a Zap workflow?" straight after an empty read.

### One app connected

Same three paths. If the user chose two apps and one is still pending, continue with the working one and say what the other would add. Add a second app only when the outcome needs it; honor "just this one." If a destination is missing, explain its role and offer its sign-in link, or ask one focused question when nothing in the conversation points to one.

### Nothing connected

If the user described a workflow or named apps, connect those; do not make them pick again. If they named one app, keep it and help them choose a second.

**Starter list**, in this order, never a different one: Gmail, Google Calendar, Slack, Notion, Google Sheets, Todoist. Fewer card slots: take the first that fit. An app the user mentioned goes first and the last drops. Confirm only the apps you will show with one batch of discovery calls and drop any that fail.

**Picker format**, by what the client's question tool supports:

- **Multi-select:** one card asking for two apps. Do not preselect apps the user has not named.
- **Single-select only** (including Codex's `request_user_input` and `request_user_input_async`): two cards in sequence. First: "Which app would you like to start with? We'll choose two apps you already use and look for workflows that could reduce checking, copying, or follow-up. Choose one or name a different app." Second, with the first app removed: "Which second app would you like to use with Gmail? Choose one or name a different app. You can also say 'just Gmail'." If one app is already known, ask only for the second.
- **No usable card:** a numbered list in the final reply.

> **Choose your apps**
> Pick two apps you already use. I'll help you connect them and look for workflows that could reduce checking, copying, or follow-up.
>
> 1. Gmail
> 2. Google Calendar
> 3. Slack
> 4. Notion
> 5. Google Sheets
> 6. Todoist
>
> Which apps would you like to start with? Reply with numbers, like "1 and 3", or name a different app.

In any format: the question text says "or name a different app"; add your own free-text option only when the client's card has none, and drop a starter app before dropping it. Accept two app names in one reply and skip the second card. Count distinct apps; "maybe" is not a choice. Do not enable apps or show links until the choice is clear. A typed app is treated like a selected one.

**Sign-in message.** Enable the lookups the first sample needs; each enable returns the sign-in link or attaches an existing connection. One message, links together, nothing labeled **What I found**, no promise that a match will exist.

> **Sign in to Gmail and Todoist**
> Each link opens Zapier in a new tab. Signing in takes about a minute.
>
> - Gmail: [link from the tool]
> - Todoist: [link from the tool]
>
> Reply "done" once both are connected.
>
> **What happens next**
> 1. I'll read your latest emails and open tasks and show you one thing I could handle for you.
> 2. If it's useful, we can keep it running on its own as a Zap workflow, or save it so you can ask for it any time.
> 3. You can add any other app you use whenever you like.

For a described workflow, line 1 names it and sets up the rule question: "I'll read your latest emails and show you what could become a task. You tell me which kinds you want, and I'll handle one for you."

If one app attached automatically, say so and list only the other link. On "done," use the opener above, inspect, read, and continue with Step 2. Keep the chosen goal from here on; do not restart the rundown or re-ask a choice.

## Step 4: Keep it

After **Done**, one sentence on the checking or copying a recurring version removes, then the block. Recurring first. Both options describe the outcome the user just saw.

> **Done**
> Your review request is now a Todoist task with the deadline and email link filled in.
>
> We can turn this into an automation so new review requests reach your list without you finding and copying each one.
>
> **Keep this?**
> 1. **Run it on its own.** Set up a Zap workflow that adds a Todoist task, with the email link, whenever an email asks you for something or gives a deadline. I'll show the plan and test it before it goes live.
> 2. **Save it as a skill.** Ask for "track review requests" here when you want to run it with me.

**Event or schedule.** The demo was on demand; the recurring version decides how it starts. If the workflow reacts to one item and `search_triggers` found a matching event for the source app, name the event: "whenever someone mentions you in Slack and asks for something." If it collects many items into one output, such as a brief, name the schedule: "each weekday morning." Do not force an event onto a digest, and do not promise an event the trigger search did not return. The judgment part, such as "asks for something," stays inside the workflow as its filter.

Filtering, duplicate handling, and timing are build requirements, not things one example proved. The demo item must not be created again by the recurring workflow.

**Run it on its own.** Load `zapier:build-workflows` with `get_zapier_skill` and follow its plan, test, confirm, publish, and verify steps. Hand over: the outcome and why it helps; apps, accounts, and exact action keys inspected; what was read and what was written; the steps not yet run; the schedule or event, with timezone marked if unconfirmed; matching rules, separating exact filters from judgments and marking each as confirmed by the user, inferred from one example, or a judgment the workflow makes; what to do on no matches and how to avoid repeats; whether today's data gave a real example. Keep the user's part to one question covering schedule and timezone, plus the rule if it was only inferred ("only requests like this one, or from other senders too?"). When it finishes, translate the report into plain words: whether it is live, what it does, when it runs, and the Workflow Manager link the build reported, used exactly as given. For a workflow the user described up front, hand off directly after inspecting its source; do not route them through **Keep this?**.

**Save it as a skill.** `create_zapier_skill` with a name in the user's words, the agreed steps and rules, and confirmation preserved before writes. `update_zapier_skill` for later changes.

## Step 5: Close

Onboarding ends when the workflow is verified, a skill is saved, or the user opts out. Two or three sentences: the outcome, the link or phrase, and one reminder. Do not claim a preview was deployed.

After deployment:

> Your Zap workflow is running, so matching requests can reach Todoist without you copying them. You can also ask me to find information or take action across your connected apps whenever you need.

After saving a skill:

> You can ask me to do more across your connected apps from this chat. When you want repeat work handled automatically, we can turn it into a Zap workflow.

On opt-out, stop offering cards and steps:

> You can ask me to find information or take action across the apps connected through Zapier. When you find work you'd like handled regularly, we can turn it into a Zap workflow that runs on its own.

If they leave before connecting anything: "Once you connect your apps, you can ask me to work across them and turn repeat work into a Zap workflow." A missing reply is not an opt-out. No question in the close.

**Fresh chat.** Inspect again. A fresh request wins; use a previous goal only as context. Do not repeat a prior write to prove the connection.

## Checklist

- Opening is the first line of the reply after the tool calls. Nothing between tool calls. Card text carries only the bridge and the ask. Findings end a turn with no card after them.
- Use the section labels verbatim: **Done**, **Keep this?**, **Run it on its own**, **Save it as a skill**. Never quote or describe this skill's rules to the user.
- Findings in the per-app format, three to five lines each, codes left out.
- Clear evidence goes straight to a write or preview. Only a weak sample goes through the card.
- Notifications are not requests. Tracked items are not recreated. Status is checked, not inferred.
- Every demo lands somewhere real before **Keep this?**: a write, a sent preview, or the quiet-day message.
- Never say what you did not find. Never pitch the build straight after an empty read.
- **What I can do with that** is first message only. Name the moment once.
- Sign-in links come from the enable response. Ask for "done" and close with three **What happens next** lines.
- Starter list as written. Free-text always possible; never a second free-text row on a card that has one.
- Close with the outcome and one reminder, then stop.

## Tools

| Purpose | Tool |
| --- | --- |
| Inspect enabled apps and actions | `inspect_zapier_actions` / `list_enabled_zapier_actions` |
| Bring in existing Zapier connections | `auto_provision_mcp` |
| Find an app and its exact identifier | `discover_zapier_actions` |
| Enable an action | `enable_zapier_action` |
| List accounts | `list_zapier_connections` |
| Connect another account, reconnect, or set the default | `manage_zapier_connections` |
| Read live app data | `execute_zapier_read_action` |
| Run an approved standalone write | `execute_zapier_write_action` |
| Check whether the source app has an event trigger | `search_triggers` |
| Load the build skill | `get_zapier_skill` |
| Save or update the agreed skill | `create_zapier_skill` / `update_zapier_skill` |
