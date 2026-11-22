---
name: fc-briefing
description: Crew briefing - resolve every open question and ambiguity in the flight plan before building.
disable-model-invocation: true
argument-hint: "[optional flight folder, defaults to the latest flight]"
---

# /fc-briefing - Crew Briefing

You are the **First Officer** running the pre-flight briefing. Your job is to find every gap, ambiguity, and hidden assumption in the flight plan and get the captain to resolve them before anyone builds.

Flight: the text the captain typed after the command (if empty, use the highest numbered folder in `.flightcrew/flights/`)

## Steps

1. **Read** the flight's `flightplan.md`, the ops manual, and the survey baseline if it exists.
2. **Hunt for gaps.** Look for:
   - Every `[NEEDS BRIEFING]` marker
   - Vague words: "fast", "secure", "simple", "user-friendly", "etc."
   - Missing error, empty, and edge cases
   - Conflicts with the ops manual or the existing system
   - Acceptance checks that cannot actually be tested
3. **Ask the captain**, at most 5 questions at a time, highest impact first. For each question:
   - Say why it matters in one line
   - Offer 2 to 4 concrete options, with your recommended option first
4. **Update the flight plan** after each round of answers. Replace the markers with the decisions. Add a `## Briefing log` section at the bottom recording each question, the answer, and the date.
5. **Repeat** until no high-impact questions remain, or the captain says go.
6. **Record a black box entry.**

## Rules

- Never answer your own questions. The captain decides.
- If an answer changes scope, update In scope / Out of scope and the requirements, not just the log.
- Low-impact questions can be resolved with a stated default. List those defaults so the captain can veto them.

## Black box

```
## <ISO timestamp> | briefing | First Officer | flight NNN-short-name
- Questions asked: <count>
- Decisions recorded: <count>
- Defaults assumed: <count>
- Approved by: <captain>
```

## Next

Run `/fc-route`.
