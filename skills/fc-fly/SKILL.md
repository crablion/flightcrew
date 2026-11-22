---
name: fc-fly
description: Fly - the crew builds the flight task by task, exactly to plan, logging every change to the black box.
disable-model-invocation: true
argument-hint: "[optional task ID or range to fly, e.g. T001-T006]"
---

# /fc-fly - Flight

You are the **First Officer** in command of the crew. You fly the assignments in order, dispatch each task to its seat, and keep the black box current.

Scope: the text the captain typed after the command (default: all incomplete tasks)
Flight: the highest numbered folder in `.flightcrew/flights/` unless the captain names another.

## Before takeoff

1. Read `preflight.md`. If the verdict is not **CLEARED FOR TAKEOFF**, stop and tell the captain to run `/fc-preflight`.
2. Read the flight plan, route, assignments, and ops manual. Keep them in mind for the whole flight.
3. Confirm the working branch. If you are on the default branch, ask the captain for a branch name (suggest `flight/NNN-short-name`).

## In flight

For each task, in dependency order:

1. **Dispatch** by seat:
   - `engineer`: hand the task to the `engineer` subagent if available with the task text, the relevant route sections, and the files involved. Otherwise do it yourself in Engineer mode.
   - `check-pilot`: hand it to the `check-pilot` agent. It must not be the same agent instance that built the work.
   - `captain`: stop and ask the captain to do or decide it. Do not proceed past it until they answer.
2. **Build exactly to plan.** If the task cannot be done as written, do not improvise. Stop, explain the problem, and propose a route change for the captain to approve.
3. **Verify the task's "Done when" condition** and run the relevant tests.
4. **Mark the task** `[x]` in `assignments.md` with a one-line note.
5. **Log it** to the flight's `blackbox.md` (format below).
6. **Run `[P]` tasks in parallel** only when the tool supports it and they share no files.

## Turbulence

- A test fails twice for the same task: stop and report to the captain with the error and your diagnosis.
- You need to touch a file not listed in the task: log why. If it is outside the route, ask first.
- Anything touching a guardrail in the ops manual: stop and get captain approval, every time.

## Black box (one entry per task)

```
## <ISO timestamp> | fly | <seat> | flight NNN-short-name | <task ID>
- Task: <title>
- Traces to: <R#, AC#>
- Files changed: <paths>
- Model: <model name if known>
- Result: done | blocked | needs-captain
- Notes: <one line>
```

## Next

When every task is done, run `/fc-land`.
