# Flightcrew

**Your AI crew, cleared for takeoff.**

Flightcrew is a spec-driven development (SDD) workflow for running a crew of AI agents on real software projects, new or legacy. You're the captain. The agents fly the plane. Every flight has a plan, a preflight checklist, a black box, and a clean landing.

Nobody vibes a 747. Don't vibe your codebase either.

---

## Why Flightcrew

AI coding agents are fast. Fast without discipline gets you a demo that falls over in production. Spec-driven tools like GitHub Spec Kit fixed half the problem: write the spec first, then let the AI build. Flightcrew takes that idea and adds what real engineering teams still need:

- **Brownfield first.** Most work happens in existing systems. Flightcrew surveys the terrain before it plans the route.
- **A crew, not a chatbot.** Work is split across role-specific agents, each with a seat and a job.
- **A black box.** Every change traces back to the spec section, the agent, the model, and the human who approved it.
- **A real landing.** Nothing is done until the acceptance checks pass.
- **A debrief.** After you ship, Flightcrew checks for drift and feeds lessons back into your ops manual.

## The flight

| Command | Phase | What happens |
|---|---|---|
| `/fc-manual` | Ops manual | Set the principles, guardrails, and standards every flight follows |
| `/fc-survey` | Survey | Brownfield only. Scan the existing code, APIs, and config into a baseline |
| `/fc-flightplan` | Flight plan | Write the feature spec: intent, scope, acceptance criteria |
| `/fc-briefing` | Briefing | Crew Q&A. Close every gap before anyone builds |
| `/fc-route` | Route | Technical plan: architecture, approach, risks |
| `/fc-assign` | Crew assignments | Break the route into tasks and seat each one with the right agent |
| `/fc-preflight` | Preflight | Checklist. Plan, route, and assignments must agree before takeoff |
| `/fc-fly` | Flight | The crew builds, task by task, logging to the black box |
| `/fc-land` | Landing | Tests and acceptance checks must pass to touch down |
| `/fc-blackbox` | Black box | Query the record: who did what, from which spec, and why |
| `/fc-debrief` | Debrief | Post-flight drift check and lessons learned |

### Two flight paths

**Greenfield** (new project or feature):
```
manual -> flightplan -> briefing -> route -> assign -> preflight -> fly -> land -> debrief
```

**Brownfield** (existing system):
```
manual -> survey -> flightplan -> briefing -> route -> assign -> preflight -> fly -> land -> debrief
```

You run `/fc-manual` once per project and `/fc-survey` whenever the terrain changes. Everything else runs once per flight (one feature, fix, or change).

## The crew

| Seat | Who | Job |
|---|---|---|
| Captain | You | Owns intent, approves the plan, makes the calls that matter |
| First Officer | Main agent session | Runs the checklist, coordinates the crew, keeps the log |
| Navigator | `navigator` agent | Surveys terrain, plans routes, flags risk |
| Engineer | `engineer` agent | Builds one task at a time, exactly to spec |
| Check Pilot | `check-pilot` agent | Independent review and verification. Never grades its own work |

Crew agents ship in two formats: `.github/agents/*.agent.md` for VS Code with GitHub Copilot, and `.claude/agents/*.md` for Claude Code. If your tool can't run subagents, the First Officer takes each seat in turn.

## Quick start

Requirements: a git repo, plus VS Code with GitHub Copilot Chat in agent mode, or Claude Code (terminal or its VS Code extension).

Windows (PowerShell), from your project root:

```powershell
git clone https://github.com/crablion/flightcrew.git $env:TEMP\flightcrew
powershell -ExecutionPolicy Bypass -File $env:TEMP\flightcrew\scripts\install.ps1 -Target .
```

macOS / Linux / Git Bash:

```bash
git clone https://github.com/crablion/flightcrew.git /tmp/flightcrew
bash /tmp/flightcrew/scripts/install.sh .
```

This installs:
- `.github/skills/fc-*/` and `.github/agents/*.agent.md` for VS Code with GitHub Copilot
- `.claude/skills/fc-*/` and `.claude/agents/*.md` for Claude Code
- `.flightcrew/templates/` with the templates every phase uses

Every phase is an [agent skill](https://code.visualstudio.com/docs/agent-customization/agent-skills), so it shows up as a slash command in both tools. The phase skills only run when you call them. The crew never jumps ahead on its own.

Then open Copilot Chat in agent mode (or Claude Code) and type:

```
/fc-manual
/fc-survey                 # brownfield only
/fc-flightplan Add store-level price overrides to the item API
```

and follow the checklist from there. Each phase tells you what to run next.

## What a flight leaves behind

```
.flightcrew/
  manual.md                    # ops manual (one per project)
  survey/
    baseline.md                # brownfield terrain map
  flights/
    001-price-overrides/
      flightplan.md            # spec + briefing Q&A
      route.md                 # technical plan
      assignments.md           # tasks, seats, status
      preflight.md             # checklist results
      blackbox.md              # append-only provenance log
      landing.md               # verification results
      debrief.md               # drift check + lessons
  templates/
```

Everything is plain markdown in your repo. Review it in PRs like any other code.

## Principles

1. **Spec before code.** No agent writes production code without an approved flight plan.
2. **Checklists over heroics.** Preflight and landing are not optional.
3. **Small flights.** One feature per flight. Long flights drift.
4. **Independent verification.** The agent that built it never signs off on it.
5. **Everything on the record.** If it isn't in the black box, it didn't happen.
6. **The captain decides.** Agents propose. Humans approve.

## Roadmap

- [ ] Drift detection that compares deployed APIs against flight plans
- [ ] Platform-aware routes (Azure APIM, Key Vault, Entra ID, pipelines)
- [ ] Black box export for audit and compliance reviews
- [ ] Flight dashboard across a team

## Credits

Flightcrew is inspired by and compatible with [GitHub Spec Kit](https://github.com/github/spec-kit) (MIT). See [NOTICE](NOTICE).

## License

MIT. Copyright (c) 2026 CrabLion LLC. See [LICENSE](LICENSE).

Built by [CrabLion](https://flightcrew.dev).
