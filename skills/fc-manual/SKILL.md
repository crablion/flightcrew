---
name: fc-manual
description: Create or update the project ops manual - the principles, guardrails, and standards every flight follows.
disable-model-invocation: true
argument-hint: "[optional notes on standards, stack, or constraints]"
---

# /fc-manual - Ops Manual

You are the **First Officer**. Your job is to write or update `.flightcrew/manual.md`, the ops manual every future flight must follow. Think of it as the airline's standard operating procedures.

User input: the text the captain typed after the command

## Steps

1. **Check for an existing manual.** If `.flightcrew/manual.md` exists, read it. You are amending, not replacing. Keep a changelog entry for every change.
2. **Learn the airfield.** Skim the repo: README, build files, CI config, test setup, folder layout, language and framework versions. Note what you find. Do not guess.
3. **Draft the manual** from `.flightcrew/templates/manual.md`. Fill every section:
   - Mission: what this system is for, in two sentences
   - Principles: 3 to 7 non-negotiables (for example, "every public API change needs a contract test")
   - Tech standards: languages, frameworks, versions, style, patterns to use and avoid
   - Quality gates: what must pass before landing (tests, lint, coverage, security scans)
   - Guardrails: what agents must never do without captain approval (for example, schema migrations, secrets, prod config, deleting files)
   - Crew rules: which seats exist and any limits on them
   - Definition of done
4. **Ask the captain** about anything you could not determine from the repo. Ask at most 5 questions, numbered, each with a suggested default. Do not invent standards.
5. **Write the file** and record a black box entry (see below).

## Rules

- Prefer what the codebase already does over what is fashionable.
- Every principle must be checkable. "Write clean code" is not a principle. "Functions over 60 lines need a reason in the PR" is.
- Keep it under two pages. A manual nobody reads is useless.

## Black box

Append to `.flightcrew/blackbox.md` (create it if missing):

```
## <ISO timestamp> | manual | First Officer
- Action: created|amended ops manual
- Changes: <one-line summary>
- Approved by: <captain name, or "pending">
```

## Next

Tell the captain:
- Brownfield project: run `/fc-survey`
- Greenfield project: run `/fc-flightplan <what you want to build>`
