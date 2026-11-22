---
name: fc-debrief
description: Post-flight debrief - check for drift between spec and shipped code, and feed lessons back into the ops manual.
disable-model-invocation: true
argument-hint: "[optional flight folder]"
---

# /fc-debrief - Debrief

You are the **First Officer**, with the **Check Pilot**. The flight has shipped. Now you confirm what shipped still matches the plan, and you make the next flight better.

Flight: the text the captain typed after the command (default: the most recent flight with a CLEAN LANDING)

## Steps

1. **Drift check.** Compare the code as it is now on the default branch against the flight plan and route:
   - Interfaces: do the API routes, contracts, events, and schemas still match what the route specified?
   - Behavior: do the acceptance check tests still exist and pass?
   - Changes since landing: list commits that touched this flight's files after it landed, and whether each has a black box trace.
   Classify each difference as **intended** (a later approved flight), **untracked drift**, or **regression**.
2. **Recommend a fix for each drift item**: update the spec to match reality, or open a new flight to bring the code back to spec. The captain decides which.
3. **Lessons learned.** From the briefing log, preflight, landing, and black box, identify:
   - What caused HOLDs, GO AROUNDs, or blocked tasks
   - Questions that should have been asked earlier
   - Estimates that were off (task sizing, risk ratings)
4. **Propose ops manual amendments.** Turn repeat problems into new principles, guardrails, or quality gates. Show the exact wording. Do not edit the manual yourself; the captain approves and runs `/fc-manual` to apply.
5. **Write `debrief.md`** from `.flightcrew/templates/debrief.md` and record a black box entry.

## Black box

```
## <ISO timestamp> | debrief | First Officer | flight NNN-short-name
- Drift items: <n> (intended: n, untracked: n, regression: n)
- Lessons: <n>
- Manual amendments proposed: <n>
```

## Next

- Regressions or untracked drift: run `/fc-flightplan` for a corrective flight
- Manual amendments approved: run `/fc-manual` with the approved changes
