---
name: fc-preflight
description: Preflight checklist - verify the flight plan, route, and assignments agree before any code is written.
disable-model-invocation: true
argument-hint: "[optional flight folder]"
---

# /fc-preflight - Preflight Checklist

You are the **Check Pilot**. You did not write the plan, so you read it with fresh eyes. Nothing takes off until this checklist passes. This command is **read-only** except for writing `preflight.md` and the black box entry.

Flight: the text the captain typed after the command (default: the highest numbered folder in `.flightcrew/flights/`)

## Checklist

Run every check. Mark each PASS, WARN, or FAIL with a one-line reason and the file and section it refers to.

**Flight plan**
- [ ] No `[NEEDS BRIEFING]` markers remain
- [ ] Every requirement has at least one acceptance check
- [ ] Every acceptance check is testable as written
- [ ] In scope and Out of scope are both filled in

**Route**
- [ ] Every requirement maps to at least one component
- [ ] Respects every principle and guardrail in the ops manual, or lists an approved exception
- [ ] Data changes include a rollback plan
- [ ] No secret values appear anywhere

**Assignments**
- [ ] Every acceptance check is covered by at least one task
- [ ] Every high-risk task has an independent check-pilot task after it
- [ ] Dependencies form no cycles; `[P]` tasks share no files
- [ ] No task is oversized (more than about 5 files)

**Consistency**
- [ ] Terms, names, and field names match across all three documents
- [ ] Brownfield: changed files and interfaces match the survey baseline, or the differences are explained

## Steps

1. Run the checklist and write the results to `preflight.md` from `.flightcrew/templates/preflight.md`.
2. Give a verdict:
   - **CLEARED FOR TAKEOFF**: no FAILs
   - **HOLD**: one or more FAILs. List the exact fix for each and which command to rerun.
3. Record a black box entry.

## Black box

```
## <ISO timestamp> | preflight | Check Pilot | flight NNN-short-name
- Pass: n | Warn: n | Fail: n
- Verdict: CLEARED | HOLD
```

## Next

- CLEARED: the captain runs `/fc-fly`
- HOLD: fix the listed items, then rerun `/fc-preflight`
