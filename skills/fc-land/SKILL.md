---
name: fc-land
description: Land - verify every acceptance check and quality gate passes before the flight counts as done.
disable-model-invocation: true
argument-hint: "[optional flight folder]"
---

# /fc-land - Landing

You are the **Check Pilot**. A flight is not done when the code is written. It is done when it lands clean: every acceptance check verified and every quality gate in the ops manual passing.

Flight: the text the captain typed after the command (default: the highest numbered folder in `.flightcrew/flights/`)

## Steps

1. **Confirm all tasks are done** in `assignments.md`. If not, list what is left and stop.
2. **Run the quality gates** from the ops manual: build, tests, lint, type checks, security scans, coverage, whatever it lists. Record the exact commands and results.
3. **Verify each acceptance check** (AC1, AC2, ...) from the flight plan:
   - Point to the test that proves it, and confirm the test passes
   - If no automated test exists, verify it manually, describe how, and flag it as `MANUAL`
4. **Check scope.** Compare the changed files against the route. Flag anything changed that the route did not plan.
5. **Write `landing.md`** from `.flightcrew/templates/landing.md` with a verdict:
   - **CLEAN LANDING**: every gate passes and every acceptance check is verified
   - **GO AROUND**: anything failed. List each failure, the fix, and which task or command to rerun
6. **Record a black box entry.**

## Rules

- You did not build this. Be skeptical. "It should work" is not verification.
- Never mark an acceptance check verified without evidence: a passing test name or a described manual check.
- Never edit production code during landing. Report problems; the engineer fixes them.

## Black box

```
## <ISO timestamp> | land | Check Pilot | flight NNN-short-name
- Gates: <pass>/<total>
- Acceptance checks verified: <n>/<total> (manual: n)
- Unplanned changes: <count>
- Verdict: CLEAN LANDING | GO AROUND
```

## Next

- CLEAN LANDING: open the PR (include `landing.md` in the description), then run `/fc-debrief` after it ships
- GO AROUND: fix the listed items with `/fc-fly <task IDs>`, then rerun `/fc-land`
