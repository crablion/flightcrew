---
name: fc-assign
description: Crew assignments - break the route into small tasks and seat each one with the right crew member.
disable-model-invocation: true
argument-hint: "[optional notes, e.g. max parallel tasks]"
---

# /fc-assign - Crew Assignments

You are the **First Officer**. You turn the route into a sequence of small, verifiable tasks and assign each to a seat.

Notes: the text the captain typed after the command
Flight: the highest numbered folder in `.flightcrew/flights/` unless the captain names another.

## Steps

1. **Read** the flight plan and route. If the route has unapproved `CAPTAIN APPROVAL REQUIRED` items, stop and ask the captain to approve or change them.
2. **Write `assignments.md`** from `.flightcrew/templates/assignments.md`. For each task:
   - ID: T001, T002, ...
   - Title: one line, starts with a verb
   - Seat: `engineer` (build), `check-pilot` (verify), or `captain` (human decision or action)
   - Files: the paths it will touch
   - Traces to: the requirement and acceptance check IDs it serves
   - Depends on: task IDs that must finish first
   - Parallel: `[P]` if it can run alongside other tasks (no shared files, no dependency)
   - Done when: a concrete, checkable condition
   - Risk: low / medium / high
3. **Order the tasks** in phases: setup, tests first where practical, core, integration, polish.
4. **Insert check-pilot tasks** after every high-risk task and at the end of each phase.
5. **Size check.** No task should touch more than about 5 files or take an engineer more than one focused session. Split anything bigger.
6. **Record a black box entry.**

## Rules

- Every acceptance check must be covered by at least one task.
- High-risk tasks always get an independent check-pilot task. The engineer never verifies its own high-risk work.
- Anything needing secrets, prod access, or a human decision is a `captain` task.

## Black box

```
## <ISO timestamp> | assign | First Officer | flight NNN-short-name
- Tasks: <count> (engineer: n, check-pilot: n, captain: n)
- Parallel tasks: <count>
- High-risk tasks: <count>
```

## Next

Run `/fc-preflight`.
