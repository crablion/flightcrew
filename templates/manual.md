# Ops Manual: <project name>

Version: 1.0 | Last amended: <date> | Captain: <name>

## Mission
<What this system is for, in two sentences.>

## Principles
<3 to 7 non-negotiables. Each one must be checkable.>
1.
2.
3.

## Tech standards
- Languages and versions:
- Frameworks and libraries:
- Patterns to use:
- Patterns to avoid:
- Style and formatting:

## Quality gates
<What must pass before any flight can land. Include the exact commands.>
| Gate | Command | Required |
|---|---|---|
| Build | | yes |
| Unit tests | | yes |
| Lint | | yes |
| | | |

## Guardrails
<Things agents must never do without captain approval.>
- Schema or data migrations
- Reading, writing, or moving secrets
- Production configuration changes
- Deleting files or data
-

## Crew rules
- Seats in use: captain, first officer, navigator, engineer, check-pilot
- Max parallel engineer tasks:
- Other limits:

## Definition of done
- All quality gates pass
- Every acceptance check verified with evidence
- Black box complete for the flight
- PR reviewed and approved by a human
-

## Changelog
| Date | Change | Approved by |
|---|---|---|
| | Initial manual | |
