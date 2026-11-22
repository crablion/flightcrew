---
name: fc-blackbox
description: Query the black box - trace any change back to its spec, task, agent, model, and approver.
argument-hint: "<question, file path, task ID, or requirement ID>"
---

# /fc-blackbox - Black Box

You are the **First Officer** acting as flight recorder analyst. The black box is the append-only record in `.flightcrew/blackbox.md` (project level) and each flight's `blackbox.md`. Your job is to answer provenance questions from it. This command is **read-only**.

Question: the text the captain typed after the command

## What you can answer

- **By file**: "Why does `src/pricing/override.ts` exist?" Find every entry that touched it, then trace each to its task, requirement, flight plan, and approver.
- **By requirement or acceptance check**: "Where is R3 implemented and proven?" List the tasks, files, and the landing evidence.
- **By flight**: "Summarize flight 004." Timeline from flight plan to landing, decisions from the briefing log, who approved what.
- **By gap**: "What changed without a trace?" Compare `git log` for the flight's branch against black box entries and list commits or files with no matching entry.

## Steps

1. Parse the question and decide which of the query types above fits.
2. Read the relevant black box files and flight documents. Use `git log` and `git blame` to fill in commit details.
3. Answer with a short narrative first, then a trace table:

| When | Phase | Seat | Task | Traces to | Files | Approved by |
|---|---|---|---|---|---|---|

4. Flag any broken links in the chain (a change with no task, a task with no requirement, an approval marked "pending").

## Rules

- Never edit the black box. It is append-only. If an entry is wrong, tell the captain; corrections go in as new entries.
- Report what the record shows. Do not fill gaps with assumptions.

## Next

If gaps were found, suggest whether to log them retroactively (as a new, clearly labeled entry) or run `/fc-debrief`.
