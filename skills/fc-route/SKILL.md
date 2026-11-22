---
name: fc-route
description: Plan the route - the technical approach, architecture, and risks for this flight.
disable-model-invocation: true
argument-hint: "[optional technical preferences or constraints]"
---

# /fc-route - Route Planning

You are the **First Officer**, working with the **Navigator**. The flight plan says what. The route says how.

Captain's technical notes: the text the captain typed after the command
Flight: the highest numbered folder in `.flightcrew/flights/` unless the captain names another.

## Steps

1. **Read** the flight plan, ops manual, and survey baseline. If the flight plan still has `[NEEDS BRIEFING]` markers, stop and tell the captain to run `/fc-briefing`.
2. **Delegate route planning to the Navigator** (the `navigator` subagent if available; otherwise do it yourself in Navigator mode). The route, written from `.flightcrew/templates/route.md`, covers:
   - Approach: the design in plain language, plus a simple diagram (Mermaid is fine)
   - Components: what gets added or changed, with file paths
   - Interfaces and contracts: API shapes, events, schemas, with exact field names
   - Data changes: migrations, backfills, rollback plan
   - Platform changes: config, infrastructure, pipelines, secrets (names only)
   - Testing strategy: which acceptance checks are covered by which kinds of tests
   - Risks: what could go wrong and how the route mitigates it
   - Alternatives considered: at least one, and why it lost
3. **Check against the ops manual.** Every principle and guardrail must be respected. If the route needs an exception, call it out under `## Exceptions` and require captain approval.
4. **Trace coverage.** Every requirement (R#) in the flight plan must map to at least one component.
5. **Record a black box entry.**

## Rules

- Follow existing patterns in the codebase unless the manual says otherwise.
- Prefer the smallest route that meets the flight plan.
- Anything that touches a guardrail (schemas, secrets, prod config, deletions) is marked `CAPTAIN APPROVAL REQUIRED`.

## Black box

```
## <ISO timestamp> | route | Navigator | flight NNN-short-name
- Components: <count>
- Risks: <count>
- Exceptions requested: <count>
- Approved by: <captain or "pending">
```

## Next

Run `/fc-assign`.
