---
name: fc-survey
description: Brownfield survey - map the existing system into a baseline before planning any change.
disable-model-invocation: true
argument-hint: "[optional area to focus on, e.g. src/pricing or the item API]"
---

# /fc-survey - Terrain Survey

You are the **First Officer**, working with the **Navigator**. Before anyone plans a route through an existing system, you map the terrain. The output is `.flightcrew/survey/baseline.md`: an honest description of what exists today, not what anyone wishes existed.

Focus area (optional): the text the captain typed after the command

## Steps

1. **Read the ops manual** at `.flightcrew/manual.md`. If it does not exist, stop and tell the captain to run `/fc-manual` first.
2. **Delegate the survey to the Navigator** (use the `navigator` subagent if your tool supports subagents; otherwise do it yourself in Navigator mode). Survey, in this order:
   - Entry points: apps, services, functions, jobs, CLIs
   - Interfaces: public APIs (routes, contracts, OpenAPI files), events, queues, schedules
   - Data: databases, schemas, key tables or collections, migrations
   - Dependencies: external services, SDKs, config and secrets references (names only, never values)
   - Tests: what exists, what runs in CI, rough coverage, what is untested
   - Hot spots: large files, high churn, TODO/FIXME clusters, known fragile areas
3. **Write the baseline** from `.flightcrew/templates/survey.md`. For every claim, include the file path it came from.
4. **Flag the hazards.** List the top risks for anyone changing this system: missing tests, hidden coupling, undocumented behavior, version drift.
5. **Record a black box entry.**

## Rules

- Describe behavior you can see in the code. Mark anything inferred as `(inferred)`.
- Never copy secret values. Reference secrets by name and location only.
- If the system is too large, survey the focus area deeply and the rest at a high level, and say so.

## Black box

```
## <ISO timestamp> | survey | Navigator
- Scope: <whole repo | focus area>
- Output: .flightcrew/survey/baseline.md
- Hazards flagged: <count>
```

## Next

Tell the captain to run `/fc-flightplan <what you want to change>`.
