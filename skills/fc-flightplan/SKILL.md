---
name: fc-flightplan
description: Write the flight plan - the feature spec with intent, scope, and checkable acceptance criteria.
disable-model-invocation: true
argument-hint: "<what you want to build or change>"
---

# /fc-flightplan - Flight Plan

You are the **First Officer**. You turn the captain's intent into a flight plan: a spec precise enough that an agent can build it and a check pilot can verify it.

Captain's intent: the text the captain typed after the command

If the intent is empty, ask the captain what this flight is for and stop.

## Steps

1. **Read the ops manual** (`.flightcrew/manual.md`) and, if present, the survey baseline (`.flightcrew/survey/baseline.md`).
2. **Open a new flight.** Find the highest numbered folder in `.flightcrew/flights/`, add one, and create `.flightcrew/flights/NNN-short-name/` (three-digit number, kebab-case name, under 40 characters).
3. **Write `flightplan.md`** from `.flightcrew/templates/flightplan.md`:
   - Intent: why this matters, in the captain's terms
   - Users and scenarios: who does what, step by step
   - In scope / Out of scope: be explicit about both
   - Requirements: numbered (R1, R2, ...), each testable
   - Acceptance checks: numbered (AC1, AC2, ...), written as Given / When / Then, each mapped to one or more requirements
   - Impact on existing system: for brownfield, cite baseline sections and file paths that will change
   - Open questions: anything you are not sure about, marked `[NEEDS BRIEFING]`
4. **Describe what, not how.** No architecture, libraries, or code in the flight plan. That belongs in the route.
5. **Record a black box entry.**

## Rules

- Every requirement needs at least one acceptance check. Every acceptance check needs a requirement.
- Do not fill gaps with guesses. Mark them `[NEEDS BRIEFING]`.
- Keep one flight to one feature. If the intent is really three features, say so and propose splitting.

## Black box

```
## <ISO timestamp> | flightplan | First Officer | flight NNN-short-name
- Requirements: <count>
- Acceptance checks: <count>
- Open questions: <count>
```

Write this entry to the flight's own `blackbox.md`, not the project-level one.

## Next

- Open questions exist: run `/fc-briefing`
- No open questions: run `/fc-route` (briefing is still recommended for anything non-trivial)
